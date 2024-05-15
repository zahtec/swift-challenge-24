import SwiftUI

// MARK: The custom scroll header present on the `ServiceView` view
struct ServiceViewHeader<Content: View>: View {
	let title: String
	let image: String
	let tab: TabName

	// If the user has the application sheet modal open, odd things with
	// the `ScrollView` occur. Hence, it needs to be tracked
	@Binding var showApplication: Bool

	@EnvironmentObject private var router: Router
	@StateObject private var data = ServiceViewHeaderModel()

	@ViewBuilder let content: () -> Content

	var body: some View {
		ZStack {
			ScrollView {
				VStack(spacing: 0) {
					ServiceViewHeaderImageTitle(image: self.image, title: self.title, showApplication: self.$showApplication)
						.environmentObject(self.data)

					VStack(alignment: .leading, spacing: 20) {
						self.content()
					}
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.padding(20)
					.padding(.bottom, 100)
					.background(.background)
				}
			}
			.scrollIndicators(.hidden)

			ServiceViewHeaderNavigationBar(title: self.title, tab: self.tab)
				.environmentObject(self.data)
		}
		.ignoresSafeArea()
		.animation(.smooth(duration: 0.3), value: self.showApplication ? self.data.navigationBarOpacity : nil)
	}
}
