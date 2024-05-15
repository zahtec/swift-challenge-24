import SwiftUI

struct ApplicationsEmploymentInformation: View {
	@EnvironmentObject private var application: Application

	var body: some View {
		Section {
			FieldRepresentable(
				icon: "hammer.fill",
				label: "Currently Employed",
				value: self.application.isEmployed ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "doc.badge.gearshape.fill",
				label: "Employment Type",
				value: self.application.isEmployed ? self.application.employmentType : "N/A"
			)

			FieldRepresentable(
				icon: "dollarsign.circle.fill",
				label: "Salary Range",
				value: self.application.isEmployed ? self.application.salaryRange : "N/A"
			)

			FieldRepresentable(
				icon: "door.right.hand.open",
				label: "On leave",
				value: self.application.isEmployed
					? self.application.onLeave ? "Yes" : "No"
					: "N/A"
			)

			FieldRepresentable(
				icon: "building.2.fill",
				label: "Name of Employer",
				value: self.application.isEmployed ? self.application.workplace : "N/A"
			)
		}
	}
}
