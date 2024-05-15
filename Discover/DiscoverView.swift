import SwiftUI

// MARK: Miara's primary view, providing easy discovery of homelessness services
struct DiscoverView: View {
	@StateObject var mapData = MapModel()
	@EnvironmentObject var router: Router

	var body: some View {
		NavigationStack(path: self.$router.discover) {
			GeometryReader { proxy in
				ZStack {
					LocalMapView(mapData: self.mapData)
						.allowsHitTesting(!self.mapData.disableMap)

					ServicePreview()

					PopupView(mapData: self.mapData)

					// Add a subtle gradient that allows the status bar to be visible over the map
					VStack {
						Rectangle()
							.fill(Gradient(
								stops: [
									.init(color: Color("StatusBarShadow"), location: 0),
									.init(color: .clear, location: 1),
								]
							))
							.frame(height: proxy.safeAreaInsets.top)

						Spacer()
					}
				}
				.ignoresSafeArea(edges: [.top, .bottom])
				.navigationDestination(for: Service.self) { service in
					// Navigate based on the service selected in the `PopupServiceList` or `ServicePreview`
					ServiceView(service: service, tab: .discover)
						.navigationBarBackButtonHidden(true)
				}
				.environmentObject(self.mapData)
			}
		}
	}
}
