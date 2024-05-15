import SwiftUI

// MARK: A single field on the application form represented by an
// MARK: icon, label, and the value that was submitted by the user
struct FieldRepresentable: View {
	let icon: String
	let label: String
	let value: String

	// For large, paragraph inputs
	var large = false

	var body: some View {
		VStack(alignment: .leading, spacing: 15) {
			HStack(spacing: 15) {
				Image(systemName: self.icon)
					.frame(width: 25)

				Text(self.label)
					.bold()

				Spacer()

				if !self.large {
					Text(self.value)
				}
			}

			if self.large {
				Text(self.value)
			}
		}
	}
}
