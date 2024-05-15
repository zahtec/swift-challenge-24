import SwiftUI

struct ApplicationsHealthInformation: View {
	@EnvironmentObject private var application: Application

	var body: some View {
		Section {
			FieldRepresentable(
				icon: "facemask.fill",
				label: "Permanent Illness Count",
				value: self.application.illnessesCount.formatted()
			)

			FieldRepresentable(
				icon: "person.crop.circle.dashed",
				label: "Disabled",
				value: self.application.isDisabled ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "figure.child.circle.fill",
				label: "Pregnant",
				value: self.application.isPregnant ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "cross.fill",
				label: "Medical Provider",
				value: self.application.medicalProvider
			)
		}
	}
}
