import SwiftUI

// MARK: The custom header for `ApplicationView` that display the respective
// MARK: service name and application status, which transition into a navigation
// MARK: bar upon scrolling
struct ApplicationViewHeader: View {
	let serviceName: String

	@ObservedObject var scrollDelegate: ApplicationViewDelegate

	@EnvironmentObject var router: Router
	@EnvironmentObject private var application: Application

	var body: some View {
		VStack {
			VStack {
				Rectangle()
					.fill(.ultraThinMaterial)
					.frame(height: 95)
					.frame(maxWidth: .infinity)
					.opacity(self.scrollDelegate.headerTransitionProgress)

				// Display the application's status above the title until scrolled up
				HStack {
					Circle()
						.fill(Color(self.application.status))
						.frame(width: 13, height: 13)

					Text(self.application.status.uppercased())
						.foregroundStyle(Color(self.application.status))
						.font(.system(size: 14, weight: .black))
				}
				.offset(
					x: 0,
					y: self.scrollDelegate.headerTransitionProgress * -63
				)
				.opacity(CGFloat(1) - (self.scrollDelegate.headerTransitionProgress * 1.5))

				Text(self.serviceName)
					.font(.system(size: 25 - (self.scrollDelegate.headerTransitionProgress * 8), weight: .semibold))
					.offset(
						x: 0,
						y: self.scrollDelegate.headerTransitionProgress * -63
					)
			}
			.ignoresSafeArea(edges: .top)

			Spacer()
		}

		// Back button
		VStack {
			Button {
				self.router.popLast(for: .applications)
			} label: {
				Image(systemName: "chevron.left")
					.resizable()
					.scaledToFit()
					.frame(
						width: 18 - min(1, self.scrollDelegate.headerTransitionProgress) * 2,
						height: 18 - min(1, self.scrollDelegate.headerTransitionProgress) * 2
					)
			}
			.offset(x: -1)
			.padding(8)
			.background(
				Color("CommonButton").opacity(1 - self.scrollDelegate.headerTransitionProgress)
			)
			.foregroundStyle(.foreground)
			.clipShape(Circle())

			Spacer()
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.leading, 20)
		.padding(.bottom, 8)
		.offset(y: -5)
	}
}
