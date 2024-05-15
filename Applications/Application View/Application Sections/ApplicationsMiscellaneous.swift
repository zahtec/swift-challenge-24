import SwiftUI

struct ApplicationsMiscellaneous: View {
	@EnvironmentObject private var application: Application

	var body: some View {
		Section {
			FieldRepresentable(
				icon: "person.text.rectangle.fill",
				label: "Migrated to The U.S.",
				value: self.application.migrant ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "fork.knife",
				label: "Water and Food Needs Fulfilled",
				value: self.application.basicNeedsFulfilled ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "person.3.fill",
				label: "Has Supporting Social Connections",
				value: self.application.supportingConnections ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "creditcard.trianglebadge.exclamationmark.fill",
				label: "Has Debt or Credit Issues",
				value: self.application.debtOrCreditIssues ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "figure.and.child.holdinghands",
				label: "Number of Children",
				value: self.application.childrenCount.formatted()
			)
		}
	}
}
