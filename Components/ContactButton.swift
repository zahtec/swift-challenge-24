import SwiftUI

struct ContactButton<ButtonLabel: View>: View {
	let copyValue: String
	let action: () -> Void
	let label: () -> ButtonLabel

	@State private var showCopy = false

	var body: some View {
		Button(action: self.action) {
			self.label()
				.padding(17)
				.frame(maxWidth: .infinity)
		}
		.buttonStyle(CommonButton {
			self.showCopy = true
		})
		.confirmationDialog("Hello", isPresented: self.$showCopy) {
			Button("Copy " + (self.copyValue.count > 25 ? self.copyValue.sub(range: 0 ..< 25) + "..." : self.copyValue)) { UIPasteboard.general.string = self.copyValue
			}
			Button("Cancel", role: .cancel) {}
		}
	}
}
