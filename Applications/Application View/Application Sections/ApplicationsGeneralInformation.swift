import SwiftUI

struct ApplicationsGeneralInformation: View {
	@EnvironmentObject private var application: Application

	var body: some View {
		Section {
			FieldRepresentable(
				icon: "person.fill",
				label: "First Name",
				value: self.application.firstName.capitalized
			)

			FieldRepresentable(
				icon: "person.2.fill",
				label: "Last Name",
				value: self.application.lastName.capitalized
			)

			FieldRepresentable(
				icon: "birthday.cake.fill",
				label: "Date of Birth",
				value: self.application.dob.formatted(date: .long, time: .omitted)
			)

			FieldRepresentable(
				icon: "globe.americas.fill",
				label: "Birth State",
				value: self.application.birthState
			)

			FieldRepresentable(
				icon: "star.bubble.fill",
				label: "Primary Language",
				value: self.application.primaryLanguage
			)
		}
	}
}
