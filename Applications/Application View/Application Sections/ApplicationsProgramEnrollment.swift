import SwiftUI

struct ApplicationsProgramEnrollment: View {
	@EnvironmentObject private var application: Application

	var body: some View {
		Section {
			FieldRepresentable(
				icon: "person.line.dotted.person.fill",
				label: "Has a Case Worker",
				value: self.application.hasCaseWorker ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "person.crop.square.filled.and.at.rectangle.fill",
				label: "Name of Case Worker",
				value: self.application.hasCaseWorker ? self.application.caseWorkerName : "N/A"
			)

			FieldRepresentable(
				icon: "square.fill",
				label: "In Other Homeless Programs",
				value: self.application.inOtherPrograms ? "Yes" : "No"
			)

			FieldRepresentable(
				icon: "square.and.at.rectangle.fill",
				label: "Other Program Names",
				value: self.application.inOtherPrograms ? self.application.otherPrograms : "N/A"
			)

			FieldRepresentable(
				icon: "person.fill.badge.plus",
				label: "Justification of Need",
				value: self.application.needForService,
				large: true
			)

			FieldRepresentable(
				icon: "doc.fill.badge.ellipsis",
				label: "Additional Details",
				value: self.application.additionalDetails,
				large: true
			)
		}
	}
}
