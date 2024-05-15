import SwiftUI

// MARK: The custom navigation bar that appears as a user scrolls
// MARK: down the `ServiceView` view
struct ServiceViewHeaderNavigationBar: View {
	let title: String
	let tab: TabName

	@EnvironmentObject private var router: Router
	@Environment(\.colorScheme) private var colorScheme
	@EnvironmentObject private var data: ServiceViewHeaderModel

	var body: some View {
		VStack {
			ZStack {
				// Background
				Rectangle()
					.fill(.thinMaterial)
					.opacity(self.data.navigationBarOpacity)

				// The centered title of the service
				VStack {
					Spacer()

					Text(self.title)
						.font(.system(size: 17, weight: .semibold))
						.padding(.bottom, 14)
						.opacity(self.data.navigationBarOpacity >= 1 ? (self.data.navigationBarOpacity - 1.2) * (50 / self.data.titleHeight) : 0)
				}

				// Back button that is initially visible, but has a background that fades out as
				// the user scrolls. Moreover, the button shifts color if needed by the user's
				// preferred color scheme
				VStack {
					Spacer()

					Button {
						self.router.popLast(for: self.tab)
					} label: {
						Image(systemName: "chevron.left")
							.resizable()
							.scaledToFit()
							.foregroundStyle(
								self.colorScheme == .dark
									? .white
									: Color(hue: 0, saturation: 0, brightness: 1 - self.data.navigationBarOpacity)
							)
							.frame(
								width: 18 - min(1, self.data.navigationBarOpacity) * 2,
								height: 18 - min(1, self.data.navigationBarOpacity) * 2
							)
					}
					.offset(x: -1)
					.padding(8)
					.background(
						.ultraThinMaterial.opacity(1 - self.data.navigationBarOpacity)
					)
					.clipShape(Circle())
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.leading, 20)
				.padding(.bottom, 8)
			}
			.frame(height: 95)

			Spacer()
		}
	}
}
