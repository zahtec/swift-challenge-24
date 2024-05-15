import SwiftUI

struct ApplicationsSensitiveExperiences: View {
	@EnvironmentObject private var application: Application

	var body: some View {
		Section {
			FieldRepresentable(
				icon: "wineglass.fill",
				label: "Experiencing Substance Abuse",
				value: self.application.substanceAbuse ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "book.pages.fill",
				label: "Involved with Legalities",
				value: self.application.inLegalScenario ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "exclamationmark.shield.fill",
				label: "Feels Threatened by Other(s)",
				value: self.application.threatened ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "hand.raised.fill",
				label: "Experienced Abuse",
				value: self.application.abuse
			)

			FieldRepresentable(
				icon: "bandage.fill",
				label: "Received Help",
				value: self.application.receivedHelp ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "square.and.pencil.circle.fill",
				label: "Details of Aid Received",
				value: self.application.receivedHelp ? self.application.helpDetails : "N/A",
				large: true
			)
		}
	}
}
