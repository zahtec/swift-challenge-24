/*

 All of the custom button styles used within Miara

 */

import SwiftUI

// MARK: Used for both services and applications to remove the default styling and add a scaling effect
struct ListButton: ButtonStyle {
	func makeBody(configuration config: Configuration) -> some View {
		config.label
			.scaleEffect(config.isPressed ? 1.03 : 1)
			.animation(.easeOut(duration: 0.2), value: config.isPressed)
	}
}

// MARK: Utilized to remove the default styling of the tab bar buttons and add a shrink effect
struct TabButton: ButtonStyle {
	func makeBody(configuration config: Configuration) -> some View {
		config.label
			.scaleEffect(config.isPressed ? 0.9 : 1)
			.animation(.easeOut(duration: 0.2), value: config.isPressed)
	}
}

// MARK: Primarily utilized on `ServiceView`. Provides long tapping support alongside a default button effect
struct CommonButton: PrimitiveButtonStyle {
	var longPressAction: (() -> Void)?

	@State private var isPressed: Bool = false

	func makeBody(configuration config: Configuration) -> some View {
		config.label
			.opacity(self.isPressed ? 0.5 : 1)
			.background(Color("CommonButton"))
			.clipShape(RoundedRectangle(cornerRadius: 7))
			.scaleEffect(self.isPressed ? 0.9 : 1)
			.onTapGesture {
				config.trigger()
			}
			.onLongPressGesture {
				if let action = longPressAction {
					action()
				} else {
					config.trigger()
				}
			} onPressingChanged: { pressing in
				withAnimation(.smooth(duration: 0.2)) {
					self.isPressed = pressing
				}
			}
	}
}
