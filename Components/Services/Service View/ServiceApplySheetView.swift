import SwiftUI

// MARK: The application view that emulates an actual application to any one of
// MARK: the services within Miara
struct ServiceApplySheetView: View {
	let service: Service

	@Environment(\.dismiss) private var dismiss
	@Environment(\.managedObjectContext) private var objContext

	@StateObject var applicationData = ApplicationData()

	var body: some View {
		NavigationStack {
			Form {
				// Form prelude, providing general information
				VStack(alignment: .leading, spacing: 20) {
					Text(self.service.name)
						.font(.system(size: 27, weight: .bold))

					Text("This form provides \(self.service.name) with crucial information that will determine your eligibility for the service, and, if available, how swiftly the service can be provided.")

					Text("Please be entirely truthful in your responses. When accepted, Miara or the service provider will vet the information below to prevent fraudulent service redemption.")
				}
				.listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
				.listRowBackground(Color.clear)

				// Form sections
				Group {
					SheetGeneralInformation()

					SheetLivingArrangement()

					SheetSensitiveExperiences()

					SheetHealthInformation()

					SheetEmploymentInformation()

					SheetMiscellaneous()

					SheetProgramEnrollment()
				}
				.listRowBackground(Color("Input"))
				.environmentObject(self.applicationData)
			}
			.navigationBarTitleDisplayMode(.inline)
			.scrollContentBackground(.hidden)
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						self.dismiss()
					}
				}

				ToolbarItem(placement: .principal) {
					HStack {
						Image(systemName: "checkmark.seal")
							.resizable()
							.frame(width: 20, height: 20)

						Text("Apply to Service")
					}
					.bold()
				}

				ToolbarItem(placement: .confirmationAction) {
					Button("Submit") {
						self.applicationData.serviceName = self.service.name
						self.applicationData.serviceImage = self.service.image

						DataController.addApplication(serviceId: self.service.id, data: self.applicationData, context: self.objContext)

						self.dismiss()
					}
					.disabled(!self.applicationData.isValid)
					.animation(.linear(duration: 0.2), value: self.applicationData.isValid)
				}
			}
			.padding(.top, -10)
		}
	}
}
