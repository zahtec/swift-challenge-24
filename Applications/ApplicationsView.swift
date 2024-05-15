import SwiftUI

struct ApplicationsView: View {
	@EnvironmentObject var router: Router
	@FetchRequest(sortDescriptors: []) private var applications: FetchedResults<Application>

	@State var search = ""
	@State var empty = false
	@State var foundApplications: [Application] = []

	var body: some View {
		NavigationStack(path: self.$router.applications) {
			PrimaryList(placeholder: "No Applications", search: self.$search, empty: self.$empty) {
				ForEach(self.foundApplications, id: \.self) { (application: Application) in
					Button {
						self.router.append(for: .applications, to: application)
					} label: {
						ApplicationListItem(application: application)
					}
					.buttonStyle(ListButton())
				}
			}
			.onAppear {
				self.foundApplications = self.applications.filter { application in
					self.search.count == 0 || application.serviceName.lowercased().contains(self.search.lowercased())
				}

				self.empty = self.foundApplications.count == 0
			}
			.onChange(of: self.search) { search in
				withAnimation(.smooth(duration: 0.25)) {
					self.foundApplications = self.applications.filter { application in
						self.search.count == 0 || application.serviceName.lowercased().contains(search.lowercased())
					}
				}

				self.empty = self.foundApplications.count == 0
			}
			.navigationDestination(for: Application.self) { application in
				let service = services.first { service in service.id == application.id }!

				ApplicationView(service: service)
					.navigationBarBackButtonHidden(true)
					.environmentObject(application)
			}
			.navigationTitle("Applications")
			.navigationBarTitleDisplayMode(.inline)
			.toolbarBackground(.hidden)
		}
	}
}
