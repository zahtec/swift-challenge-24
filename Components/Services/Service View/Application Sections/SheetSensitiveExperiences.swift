import SwiftUI

struct SheetSensitiveExperiences: View {
	@EnvironmentObject private var applicationData: ApplicationData

	var body: some View {
		Section {
			Toggle("Experiencing Substance Abuse", isOn: self.$applicationData.substanceAbuse)

			Toggle("Involved with Legalities", isOn: self.$applicationData.inLegalScenario)

			Toggle("Feel Threatened by Other(s)", isOn: self.$applicationData.threatened)

			Picker("Experienced Abuse", selection: self.$applicationData.abuse) {
				ForEach(AbuseInducer.allCases, id: \.self) { abuser in
					Text(abuser.rawValue)
				}
			}

			Toggle("Received Help for Anything Above", isOn: self.$applicationData.receivedHelp)
				.onChange(of: self.applicationData.receivedHelp) { receivedHelp in
					self.applicationData.helpDetails = receivedHelp ? "Write about the aid you received here..." : ""
				}

			if self.applicationData.receivedHelp {
				TextEditor(text: self.$applicationData.helpDetails)
					.foregroundColor(Color.gray)
					.frame(height: 180)
			}
		} header: {
			Text("Sensitive Experiences")
		}
	}
}
