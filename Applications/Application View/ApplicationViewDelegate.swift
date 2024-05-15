import SwiftUI

// MARK: Scroll delegate for the `ApplicationView` view that powers the header
// MARK: to navigation bar transition
final class ApplicationViewDelegate: NSObject, UICollectionViewDelegate, ObservableObject {
	@Published var headerTransitionProgress: CGFloat = .zero

	func scrollViewDidScroll(_ view: UIScrollView) {
		self.headerTransitionProgress = min(max((view.contentOffset.y + 40) / 60, 0), 1)
	}
}
