import SwiftUI

enum TabName: String, Equatable {
	case discover = "safari"
	case saved = "bookmark"
	case applications = "doc.plaintext"
}

// MARK: The always-in-view tab bar present at the bottom of the app
struct TabBar<Content>: View where Content: View {
	@ViewBuilder let content: () -> Content

	@Environment(\.currentTab) private var currentTab

	var body: some View {
		TabView(selection: self.currentTab, content: self.content)
			.overlay {
				VStack {
					Spacer()

					HStack(spacing: 0) {
						TabBarIcon(
							tag: .discover,
							name: "Discover"
						)

						TabBarIcon(
							tag: .saved,
							name: "Saved"
						)

						TabBarIcon(
							tag: .applications,
							name: "Applications"
						)
					}
					.frame(height: 93)
					.frame(maxWidth: .infinity)
					.overlay(Divider(), alignment: .top)
				}
				.ignoresSafeArea()
			}
	}
}
