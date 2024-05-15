import SwiftUI

// MARK: The top buttons on the `ServiceView` view, allowing for saving and applying
// MARK: to the service
struct ServiceViewTopButtons: View {
	let service: Service
	let application: Application?

	@Binding var showApplication: Bool

	@EnvironmentObject private var router: Router
	@Environment(\.currentTab) private var currentTab
	@Environment(\.managedObjectContext) private var objContext

	@FetchRequest(sortDescriptors: []) private var savedServices: FetchedResults<SavedService>

	var body: some View {
		HStack(spacing: 15) {
			// Check if the current service is saved to update the button's functionality
			// and appearance accordingly
			let isSaved = self.savedServices.contains { saved in saved.id == self.service.id }

			// Save/Unsave button
			Button {
				if isSaved {
					DataController.removeSaved(serviceId: self.service.id, savedServices: self.savedServices, context: self.objContext)
				} else {
					DataController.addSaved(service: self.service, context: self.objContext)
				}
			} label: {
				Label(
					isSaved ? "Unsave" : "Save",
					systemImage: isSaved ? "bookmark.fill" : "bookmark"
				)
				.padding(17)
				.frame(maxWidth: .infinity)
			}
			.buttonStyle(CommonButton())

			// Application button
			Button {
				// If an application already exists, open the to applications tab and
				// automatically navigate to the appropriate `ApplicationView` view
				if let application = self.application {
					self.currentTab.wrappedValue = .applications

					if !self.router.applications.isEmpty {
						self.router.applications.removeLast()
					}

					self.router.applications.append(application)
				} else {
					self.showApplication = true
				}
			} label: {
				Label(
					self.application != nil ? "Application" : "Apply",
					systemImage: self.application != nil ? "checkmark.seal.fill" : "checkmark.seal"
				)
				.padding(17)
				.frame(maxWidth: .infinity)
			}
			.buttonStyle(CommonButton())
		}
	}
}
