import SwiftUI

final class PopupServiceListDelegate: NSObject, UIScrollViewDelegate, ObservableObject {
	var overlayShadow: Binding<Bool>?
	var searchFocused: FocusState<Bool>.Binding?
	var positionData: PopupPositionModel?
	var lastOffset: CGFloat = .zero

	// If the `ScrollView` reaches the upper bound of its content, allow it to bounce if
	// it decelerated there. Otherwise, the view can easily close when users do not want and
	// are merely scrolling to the top of the service list
	var preventOffset = false

	init(
		overlayShadow: Binding<Bool>? = nil,
		searchFocused: FocusState<Bool>.Binding? = nil,
		positionData: PopupPositionModel? = nil
	) {
		self.overlayShadow = overlayShadow
		self.searchFocused = searchFocused
		self.positionData = positionData
	}

	func scrollViewDidScroll(_ view: UIScrollView) {
		guard let positionData = self.positionData, let overlayShadow = self.overlayShadow else { return }

		// The `scrollViewDidScroll` function appears to run again after manually setting the contentOffset.y to
		// zero, causing `lastOffset` to always be zero unless zero is ignored. In practice, since `lastOffset` is
		// only utilized at the end of a scrolling action, preventing it from being SET to zero (as it is initialized at zero)
		// has no effect on how the UI behaves
		if view.contentOffset.y != 0 {
			self.lastOffset = view.contentOffset.y
		}

		if !self.preventOffset {
			// If the popup is at the top...
			if positionData.position <= 100 {
				// And the `ScrollView` has reached the upper content limit
				if view.contentOffset.y < 0 {
					// Begin transferring the scroll applied to the `ScrollView` to the
					// parent popup's offset
					positionData.position -= view.contentOffset.y
					view.contentOffset.y = 0
				}
			} else {
				// Otherwise, always transfer the scroll
				positionData.position -= view.contentOffset.y
				view.contentOffset.y = 0
			}
		}

		// If the user has scroll a certain amount, show a shadow that distinguishes the search bar
		// from the list's contents
		overlayShadow.wrappedValue = view.contentOffset.y > 10
	}

	// Triggered when the user initially triggers a gesture that the `ScrollView` captures
	func scrollViewWillBeginDragging(_: UIScrollView) {
		guard let searchFocused = self.searchFocused, let positionData = self.positionData else { return }

		searchFocused.wrappedValue = false
		positionData.dragging = true
		self.preventOffset = false
	}

	func scrollViewWillEndDragging(_ view: UIScrollView, withVelocity _: CGPoint, targetContentOffset target: UnsafeMutablePointer<CGPoint>) {
		guard let positionData = self.positionData, let height = view.window?.screen.bounds.height else { return }

		positionData.dragging = false

		// If the predicted `contentOffset` of the ScrollView is beyond or at the content limit, then
		// prevent the scroll deceleration from transferring to the parent popup
		if target.pointee.y <= 0 {
			self.preventOffset = true
		}

		// Based on whether the user scrolled upward or downward when scrolling is entirely transferred to
		// the parent popup, snap the popup to an adequate position
		if self.lastOffset < 0 {
			positionData.position = height - 300
		} else {
			positionData.position = 100
		}

		// Reset the offset for the next gesture so we can determine direction again
		self.lastOffset = 0
	}
}
