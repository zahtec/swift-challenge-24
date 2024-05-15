import MapKit
import SwiftUI

// MARK: A custom, scrollable popup view that provides users with information about services.
// MARK: Immediately available as a swipe-up map overlay
struct PopupView: View {
	@ObservedObject var mapData: MapModel

	// Shared state between the `PopupServiceList`'s scrollView and the popup's
	// overall position
	@StateObject var positionData = PopupPositionModel()

	@FocusState private var searchFocused: Bool
	@GestureState private var dragTracker: CGSize = .zero

	var body: some View {
		GeometryReader { proxy in
			VStack(spacing: 0) {
				// Popup handle
				RoundedRectangle(cornerRadius: 100)
					.fill(Color("Secondary"))
					.frame(width: 70, height: 6)
					.padding(.vertical, 13)

				PopupServiceList(searchFocused: self.$searchFocused)
					.environmentObject(self.positionData)
			}
			.padding(.bottom, 140)
			.frame(maxWidth: .infinity)
			.background(Color("Primary"))
			.clipShape(RoundedRectangle(cornerRadius: 25))
			.shadow(color: Color("GeneralShadow"), radius: 5)
			.offset(
				y: min(
					// If there is a selected service map annotation, allow the view to go below what
					// it allows users to drag it to. Otherwise, limit at height - 200
					self.mapData.selectedService != nil ? proxy.size.height : proxy.size.height - 200,
					max(
						70,
						self.positionData.position + self.dragTracker.height
					)
				)
			)
			.animation(
				// Animate when the position changes programmatically
				.interactiveSpring(duration: 0.2, extraBounce: 0.2),
				value: self.positionData.position
			)
			.animation(
				// Animate while the individual is dragging. Needed for animating the snap-back
				// functionality when users go above/below the maximum offset
				.interactiveSpring(duration: 0.2, extraBounce: 0.2),
				value: self.positionData.dragging
			)
			.gesture(DragGesture(minimumDistance: 5)
				.updating(self.$dragTracker) { drag, state, _ in
					state = drag.translation
				}
				.onChanged { _ in
					self.positionData.dragging = true
					self.searchFocused = false
				}
				.onEnded { drag in
					if drag.translation.height > 0 {
						// If the drag is the in the position direction, snap to the bottom of the page
						self.positionData.position = proxy.size.height - 300
					} else {
						// Otherwise, snap to the top of the page
						self.positionData.position = 100
					}

					self.positionData.dragging = false
				})
			.onChange(of: self.searchFocused) { focused in
				// Snap the popup upward if the search box is focused while it is down.
				if focused {
					self.mapData.disableMap = true
					self.positionData.position = 100
				}
			}
			.onChange(of: self.mapData.selectedService != nil) { hide in
				// If a map service annotation is selected, move the popup out of view behind the tab bar
				self.positionData.position = hide ? proxy.size.height - 50 : proxy.size.height - 300
			}
			.onChange(of: self.positionData.dragging) { dragging in
				// If the popup is being dragged OR the popup is in its expanded mode, disable all map
				// touch interactions
				self.mapData.disableMap = dragging || self.positionData.position == 100
			}
			// Do not allow any user interaction when a map service annotation is selected
			.allowsHitTesting(self.mapData.selectedService == nil)
		}
	}
}
