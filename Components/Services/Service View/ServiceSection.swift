import SwiftUI

// MARK: An individual section with a title inside the `ServiceView` view
struct ServiceSection<Content: View>: View {
	let text: String
	let content: () -> Content

	init(_ text: String, @ViewBuilder content: @escaping () -> Content) {
		self.text = text
		self.content = content
	}

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(self.text)
				.font(.system(size: 25, weight: .bold))

			self.content()
		}
	}
}

#Preview {
	ServiceSection("Test") {
		Text("Test")
	}
}
