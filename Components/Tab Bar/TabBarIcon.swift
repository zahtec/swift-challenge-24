import SwiftUI

// MARK: The individual icons on the tab bar
struct TabBarIcon: View {
	let tag: TabName
	let name: String

	// For some reason, tapping of the tab bar is not disabled when pushing a value
	// to the router's `NavigationPath`s and having the navigation animation play.
	// To prevent navigation bugs, the button is manually disabled utilizing this state.
	@State private var disabled = false

	@EnvironmentObject private var router: Router
	@Environment(\.currentTab) private var currentTab

	var body: some View {
		Button {
			// When tapping on the tab icon for an already-active view, navigate backward
			if self.currentTab.wrappedValue == self.tag && !(self.router.getPath(for: self.tag)?.isEmpty ?? true) {
				self.router.popLast(for: self.tag)
			}

			self.currentTab.wrappedValue = self.tag
		} label: {
			VStack(spacing: 6) {
				Image(systemName: self.currentTab.wrappedValue == self.tag ? "\(self.tag.rawValue).fill" : self.tag.rawValue)
					.resizable()
					.scaledToFit()
					.foregroundStyle(.foreground)
					.frame(width: 25, height: 25)

				Text(self.name)
					.font(.system(size: 12))
					.foregroundStyle(.foreground)
			}
			.frame(maxWidth: .infinity)
			.frame(height: 93)
			.background(Color("Primary"))
		}
		.background(Color("Primary"))
		.buttonStyle(TabButton())
		.onChange(of: self.router.getPath(for: self.tag)) { path in
			// If navigating within the tab, prevent the button from modified the navigation
			// path while the navigation animation is playing
			if !(path?.isEmpty ?? true) {
				self.disabled = true

				// The animation needs approximately 0.25s to fully complete
				DispatchQueue.main.asyncAfter(deadline: .now() + UINavigationController.hideShowBarDuration + 0.25) {
					self.disabled = false
				}
			}
		}
		.allowsHitTesting(!self.disabled)
		.ignoresSafeArea()
	}
}
