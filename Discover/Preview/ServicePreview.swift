import SwiftUI

// MARK: Display a small popup that gives details about a selected service annotation
struct ServicePreview: View {
	@State var selectedId: String?
	@EnvironmentObject var mapData: MapModel
	@EnvironmentObject var router: Router

	var body: some View {
		// Display an X mark above the popup for easy closure
		PreviewCloseButton()

		VStack {
			Spacer()

			if let id = self.selectedId {
				// This view only re-renders if the service changes, so placing this
				// outside of state is fine. Finds associated service with the selected ID
				let service = services.first { service in service.id == id }!

				Button {
					// Navigate to the service page
					self.router.discover.append(service)
				} label: {
					// Retaining style from the normal services list
					ServiceListItem(service: service)
						.padding(.bottom, 12)
				}
				.buttonStyle(ListButton())
				.transition(
					.asymmetric(
						insertion: .move(edge: .bottom),
						removal: .move(edge: .bottom)
					)
				)
			}
		}
		.padding(.bottom, 93)
		.padding(.horizontal, 10)
		.onChange(of: self.mapData.selectedService) { id in
			withAnimation(.smooth(duration: 0.1)) {
				// If there is already a service selected and it changed...
				if let id = id, self.selectedId != nil {
					// Tell the view there is no selected service, making the
					// popup fall down
					self.selectedId = nil

					// Wait until the transition has fully finished and then have the popup come back up
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						withAnimation(.smooth(duration: 0.1)) {
							self.selectedId = id
						}
					}
				} else {
					// First selection of service on map. No animation algorithm
					self.selectedId = id
				}
			}
		}
	}
}
