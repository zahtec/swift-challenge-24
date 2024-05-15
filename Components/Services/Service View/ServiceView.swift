import SwiftUI

// MARK: The primary view for displaying a service and its associated information
struct ServiceView: View {
	let service: Service
	let tab: TabName

	@EnvironmentObject private var router: Router
	@Environment(\.managedObjectContext) private var objContext
	@Environment(\.currentTab) private var currentTab
	@FetchRequest(sortDescriptors: []) private var applications: FetchedResults<Application>
	@FetchRequest(sortDescriptors: []) private var savedServices: FetchedResults<SavedService>

	// Compute whether an application for this service has already been made. There is a max of one
	// application per service
	private var application: Application? {
		self.applications.first { app in app.id == self.service.id }
	}

	@State private var showApplication = false

	var body: some View {
		ServiceViewHeader(
			title: self.service.name,
			image: self.service.image,
			tab: self.tab,
			showApplication: self.$showApplication
		) {
			Text(self.service.description)
				.textSelection(.enabled)
				.foregroundStyle(Color("Tertiary"))

			ServiceViewTopButtons(service: self.service, application: self.application, showApplication: self.$showApplication)

			Divider()

			VStack(spacing: 50) {
				ServiceSection("About") {
					Text(self.service.about)
						.textSelection(.enabled)
				}

				// If there are requirements for this service, display them in a bullet
				// point list
				if !self.service.requirements.isEmpty {
					ServiceSection("Requirements") {
						ForEach(self.service.requirements, id: \.self) { requirement in
							Label {
								Text(requirement)
							} icon: {
								Image(systemName: "circle.fill")
									.resizable()
									.frame(width: 7, height: 7)
							}

							.textSelection(.enabled)
						}
						.frame(maxWidth: .infinity, alignment: .leading)
					}
				}

				ServiceSection("Availability") {
					HStack {
						ServiceAvailabilityRange(level: self.service.availability)

						Text(self.service.availability.rawValue.uppercased())
							.font(.system(size: 15, weight: .heavy))
							.foregroundStyle(Color(self.service.availability.rawValue))

						Spacer()

						Text(self.service.availabilityUpdated)
					}
					.frame(maxWidth: .infinity)
					.frame(height: 45)
					.padding(.vertical, 15)
					.padding(.horizontal, 20)
					.background(Color("Primary"))
					.clipShape(RoundedRectangle(cornerRadius: 15))
					.shadow(color: Color("GeneralShadow").opacity(0.6), radius: 5)
					.padding(.bottom, 20)

					// Provide an explanation for the service's listed availability to
					// inform the user and increase transparency
					Text(self.service.availabilityExplanation)
				}

				ServiceSection("Contact") {
					LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
						if let phone = self.service.phone {
							ContactButton(copyValue: phone) {
								UIApplication.shared.open(URL(string: "tel://" + phone)!)
							} label: {
								Label("Call", systemImage: "phone.fill")
							}
						}

						if let email = self.service.email {
							ContactButton(copyValue: email) {
								UIApplication.shared.open(URL(string: "mailto://" + email)!)
							} label: {
								Label("Email", systemImage: "envelope.fill")
							}
						}

						if let website = self.service.website {
							ContactButton(copyValue: website) {
								UIApplication.shared.open(URL(string: website)!)
							} label: {
								Label("Website", systemImage: "globe")
							}
						}

						ContactButton(copyValue: self.service.address) {
							UIApplication.shared.open(
								URL(
									// Opens maps with the service's address queried
									string: "maps://?q=\(self.service.address)"
								)!
							)
						} label: {
							Label("Location", systemImage: "location.fill")
						}

					})
				}
			}
		}
		.sheet(isPresented: self.$showApplication) {
			ServiceApplySheetView(service: self.service)
				.interactiveDismissDisabled()
		}
	}
}
