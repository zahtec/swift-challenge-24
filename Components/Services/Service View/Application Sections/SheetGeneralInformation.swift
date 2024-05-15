import SwiftUI

struct SheetGeneralInformation: View {
	@EnvironmentObject private var applicationData: ApplicationData

	var body: some View {
		Section {
			TextField("First Name", text: self.$applicationData.firstName)
				.textContentType(.givenName)
				.keyboardType(.namePhonePad)
				.autocorrectionDisabled(true)

			TextField("Last Name", text: self.$applicationData.lastName)
				.textContentType(.familyName)
				.keyboardType(.namePhonePad)
				.autocorrectionDisabled(true)

			DatePicker("Date of Birth", selection: self.$applicationData.dob, displayedComponents: [.date])

			Picker("Birth State", selection: self.$applicationData.birthState) {
				ForEach(States.allCases, id: \.self) { state in
					Text(state.rawValue)
				}
			}

			Picker("Primary Language", selection: self.$applicationData.primaryLanguage) {
				ForEach(Language.allCases, id: \.self) { lang in
					Text(lang.rawValue)
				}
			}
		} header: {
			Text("General Information")
		}
	}
}
