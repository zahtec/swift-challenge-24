import SwiftUI

struct SheetEmploymentInformation: View {
	@EnvironmentObject private var applicationData: ApplicationData

	var body: some View {
		Section {
			Toggle("Currently Employed", isOn: self.$applicationData.isEmployed)

			if self.applicationData.isEmployed {
				Picker("Employment Type", selection: self.$applicationData.employmentType) {
					ForEach(EmploymentType.allCases, id: \.self) { type in
						Text(type.rawValue)
					}
				}

				Picker("Salary Range", selection: self.$applicationData.salaryRange) {
					ForEach(SalaryRange.allCases, id: \.self) { range in
						Text(range.rawValue)
					}
				}

				Toggle("On leave", isOn: self.$applicationData.onLeave)

				TextField("Name of Employer", text: self.$applicationData.workplace)
					.textContentType(.organizationName)
			}
		} header: {
			Text("Employment Information")
		}
	}
}
