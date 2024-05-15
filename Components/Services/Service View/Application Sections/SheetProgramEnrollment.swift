import SwiftUI

struct SheetProgramEnrollment: View {
	@EnvironmentObject private var applicationData: ApplicationData

	var body: some View {
		Section {
			Toggle("Have a Case Worker", isOn: self.$applicationData.hasCaseWorker)

			if self.applicationData.hasCaseWorker {
				TextField("Name of Case Worker", text: self.$applicationData.caseWorkerName)
					.textContentType(.name)
					.keyboardType(.namePhonePad)
					.autocorrectionDisabled(true)
			}

			Toggle("In Other Homeless Programs", isOn: self.$applicationData.inOtherPrograms)

			if self.applicationData.inOtherPrograms {
				TextField("Other Program Names", text: self.$applicationData.otherPrograms)
					.textContentType(.name)
			}

			TextEditor(text: self.$applicationData.needForService)
				.foregroundColor(Color.gray)
				.frame(height: 180)

			TextEditor(text: self.$applicationData.additionalDetails)
				.foregroundColor(Color.gray)
				.frame(height: 180)
		} header: {
			Text("Program Enrollment")
		} footer: {
			Text("For information about how your data is handled, please read our [privacy policy](https://miara.app/privacy).")
		}
	}
}
