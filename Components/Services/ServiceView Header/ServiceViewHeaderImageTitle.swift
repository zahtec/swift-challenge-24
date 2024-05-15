import SwiftUI

struct ServiceViewHeaderImageTitle: View {
	let image: String
	let title: String

	@Binding var showApplication: Bool
	@EnvironmentObject private var data: ServiceViewHeaderModel

	var body: some View {
		GeometryReader { proxy in
			ZStack {
				// Attain the minY value of the scrollView frame as the user
				// scrolls, allowing for a custom transition
				let frame = proxy.frame(in: .global)

				Image(self.image)
					.resizable()
					.scaledToFill()
					.clipped()
					.overlay {
						// Display a blurred and darkened image overlay to make the service's
						// name and device status bar visible over the service's image
						Image(self.image)
							.resizable()
							.scaledToFill()
							.blur(radius: 6)
							.mask(LinearGradient(
								gradient: Gradient(
									stops: [
										.init(color: .black, location: 0),
										.init(color: .clear, location: 0.3),
										.init(color: .clear, location: 0.4),
										.init(color: .black, location: 1),
									]),
								startPoint: .top,
								endPoint: .bottom
							))
							.overlay {
								Color.black.opacity(0.3)
							}
					}
					.blur(radius: -frame.minY / 20)
					.frame(
						width: proxy.size.width,
						height: proxy.size.height + max(0, frame.minY)
					)
					.offset(
						y: frame.minY < 0
							? -frame.minY * 0.7
							: -frame.minY
					)
					.animation(.smooth(duration: 0.3), value: self.showApplication ? frame.minY : nil)

				// The service's large title displayed directly above the body of content and remains
				// there whenever the user scrolls via an offset
				VStack {
					Spacer()

					Text(self.title)
						.font(.system(size: 34, weight: .bold))
						.foregroundStyle(.white)
						.padding(.horizontal, 20)
						.padding(.bottom, 10)
						.offset(y: self.data.titleOffset)
						.opacity(self.data.navigationBarOpacity >= 1 ? 1 - ((self.data.navigationBarOpacity - 0.8) * (50 / self.data.titleHeight)) : 1)
						.background {
							GeometryReader { titleProxy in
								Color.clear
									.onAppear {
										self.data.titleHeight = titleProxy.size.height
									}
							}
						}
						.onChange(of: frame.minY) { minY in
							self.data.navigationBarOpacity =
								-min(
									0,
									CGFloat(proxy.size.height - self.data.titleHeight + minY - 150)
								) * 0.02
							self.data.titleOffset = minY < 0 ? 0 : -minY
						}
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
		}
		.frame(height: 400)
	}
}
