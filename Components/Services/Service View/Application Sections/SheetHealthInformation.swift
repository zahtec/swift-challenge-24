import SwiftUI

struct SheetHealthInformation: View {
	@EnvironmentObject private var applicationData: ApplicationData

	var body: some View {
		Section {
			Stepper(
				"Permanent Illnesses: \(self.applicationData.illnessesCount)",
				value: self.$applicationData.illnessesCount,
				in: 0 ... 10,
				step: 1
			)

			Toggle("Disabled", isOn: self.$applicationData.isDisabled)

			Toggle("Pregnant", isOn: self.$applicationData.isPregnant)

			Picker("Medical Provider", selection: self.$applicationData.medicalProvider) {
				ForEach(MedicalProvider.allCases, id: \.self) { provider in
					Text(provider.rawValue)
				}
			}
		} header: {
			Text("Health Information")
		}
	}
}
