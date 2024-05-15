import SwiftUI

struct SheetMiscellaneous: View {
	@EnvironmentObject private var applicationData: ApplicationData

	var body: some View {
		Section {
			Toggle("Migrated to The U.S.", isOn: self.$applicationData.migrant)

			Toggle("Water and Food Needs Fulfilled", isOn: self.$applicationData.basicNeedsFulfilled)

			Toggle("Have Supporting Social Connections", isOn: self.$applicationData.supportingConnections)

			Toggle("Have Debt or Credit Issues", isOn: self.$applicationData.debtOrCreditIssues)

			Stepper(
				"Number of Children: \(self.applicationData.childrenCount)",
				value: self.$applicationData.childrenCount,
				in: 0 ... 10,
				step: 1
			)
		} header: {
			Text("Miscellaneous")
		}
	}
}
