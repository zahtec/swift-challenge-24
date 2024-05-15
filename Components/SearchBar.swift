import SwiftUI

// MARK: The search bar utilized across all primary views for searching
// MARK: through services and applications
struct SearchBar: View {
	@Binding var search: String
	@Binding var overlayShadow: Bool
	var searchFocused: FocusState<Bool>.Binding

	// It is currently not possible to animate a focus state updated, meaning
	// a second variable that reflects `searchFocused` is needed for proper animations
	@State private var __searchFocused = false

	var body: some View {
		HStack(spacing: 0) {
			HStack(spacing: 13) {
				Image(systemName: "magnifyingglass")
					.foregroundStyle(Color("Tertiary"))

				TextField("Search", text: self.$search, prompt: Text("Search..."))
					.textContentType(.organizationName)
					.autocorrectionDisabled(true)
					.focused(self.searchFocused)
					.onChange(of: self.searchFocused.wrappedValue) { focused in
						// Reflect `searchFocused` onto `__searchFocused` with an animation
						withAnimation(.easeOut(duration: 0.25)) {
							self.__searchFocused = focused
						}
					}
			}
			.padding(15)
			.background(Color("Input"))
			.clipShape(RoundedRectangle(cornerRadius: 15))
			.padding([.horizontal, .bottom], 15)

			// Display an X that allows users to end the focus session and
			// clear their search
			if self.__searchFocused {
				Button {
					self.search = ""
					self.searchFocused.wrappedValue = false
				} label: {
					Image(systemName: "xmark")
						.foregroundStyle(Color("Tertiary"))
						.padding(10)
						.background(Color("Input"))
						.clipShape(Circle())
						.padding(.bottom, 13.5)
						.padding(.trailing, 15)
				}
				.transition(.asymmetric(
					insertion: .push(from: .trailing),
					removal: .push(from: .leading)
				))
			}
		}
		// `SearchBar` is always at the top of any ScrollView, thus it provides he
		// list header's shadow
		.background(Color("Primary").shadow(
			.drop(
				color: Color("GeneralShadow"),
				radius: self.overlayShadow ? 3 : 0
			)
		))
		.animation(.smooth(duration: 0.15), value: self.overlayShadow)
	}
}
