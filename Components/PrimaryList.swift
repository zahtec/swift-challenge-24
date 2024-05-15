import SwiftUI

struct PrimaryList<Content: View>: View {
	let placeholder: String
	@Binding var search: String
	@Binding var empty: Bool

	@FocusState private var searchFocused
	@State private var overlayShadow = false

	@ViewBuilder var content: () -> Content

	var body: some View {
		ScrollView {
			GeometryReader { proxy in
				let frame = proxy.frame(in: .named("primaryList"))

				VStack(spacing: 13) {
					self.content()

					if self.empty {
						Text(self.placeholder)
							.foregroundStyle(Color("Tertiary"))
					}

					Spacer()
				}
				.frame(maxWidth: .infinity)
				.padding(15)
				.padding(.vertical, 75)
				.onChange(of: frame.minY) { minY in
					self.overlayShadow = minY < -5
				}
			}
		}
		.coordinateSpace(name: "primaryList")
		.background(Color("Primary"))
		.overlay {
			VStack(spacing: 0) {
				Color("Primary")
					.ignoresSafeArea(edges: .top)
					.frame(height: 10)

				VStack {
					SearchBar(search: self.$search, overlayShadow: self.$overlayShadow, searchFocused: self.$searchFocused)

					Spacer()
				}
				.clipped()

				Spacer()
			}
		}
		.ignoresSafeArea(.keyboard)
	}
}
