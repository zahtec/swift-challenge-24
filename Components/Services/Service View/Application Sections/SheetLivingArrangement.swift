import SwiftUI

struct SheetLivingArrangement: View {
	@EnvironmentObject private var applicationData: ApplicationData

	var body: some View {
		Section {
			Picker("Living Situation", selection: self.$applicationData.livingScenario) {
				ForEach(LivingScenario.allCases, id: \.self) { scenario in
					Text(scenario.rawValue)
				}
			}

			if self.applicationData.livingScenario == .vehicle {
				Toggle("Safe Place to Park", isOn: self.$applicationData.safeParkingArea)
			}

			TextField("Address, Shelter, or Typical Location", text: self.$applicationData.location)
				.textContentType(.name)

			Stepper(
				"Lifetime Years Unhoused: \(self.applicationData.yearsUnhoused)",
				value: self.$applicationData.yearsUnhoused,
				in: 1 ... 100,
				step: 1
			)

			Stepper(
				"Lifetime Eviction Count: \(self.applicationData.evictionCount)",
				value: self.$applicationData.evictionCount,
				in: 0 ... 100,
				step: 1
			)
		} header: {
			Text("Living Arrangement")
		}
	}
}
