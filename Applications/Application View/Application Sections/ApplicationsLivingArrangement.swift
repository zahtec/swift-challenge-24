import SwiftUI

struct ApplicationsLivingArrangement: View {
	@EnvironmentObject private var application: Application

	var body: some View {
		Section {
			FieldRepresentable(
				icon: "house.fill",
				label: "Living Scenario",
				value: self.application.livingScenario
			)

			FieldRepresentable(
				icon: "parkingsign.circle.fill",
				label: "Safe Place to Park",
				value: self.application.livingScenario == LivingScenario.vehicle.rawValue
					? self.application.safeParkingArea ? "Yes" : "No"
					: "N/A"
			)

			FieldRepresentable(
				icon: "location.fill",
				label: "Location",
				value: self.application.location
			)

			FieldRepresentable(
				icon: "key.slash.fill",
				label: "Lifetime Years Unhoused",
				value: self.application.yearsUnhoused.formatted()
			)

			FieldRepresentable(
				icon: "wrongwaysign.fill",
				label: "Lifetime Eviction Count",
				value: self.application.evictionCount.formatted()
			)
		}
	}
}
