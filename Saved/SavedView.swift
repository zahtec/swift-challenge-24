import SwiftUI

// MARK: Saved Services View
struct SavedView: View {
	@State private var search = ""
	@FocusState private var searchFocused: Bool
	@StateObject private var data = SavedViewModel()

	@EnvironmentObject private var router: Router

	@FetchRequest(sortDescriptors: []) private var fetchedServices: FetchedResults<SavedService>

	var body: some View {
		NavigationStack(path: self.$router.saved) {
			// Display a list with search bar
			PrimaryList(placeholder: "No Saved Services", search: self.$search, empty: self.$data.empty) {
				ForEach(self.data.foundServices) { service in
					Button {
						self.router.append(for: .saved, to: service)
					} label: {
						ServiceListItem(service: service)
					}
					.buttonStyle(ListButton())
				}
			}
			.onAppear {
				self.data.getServiceIds(results: self.fetchedServices)
				self.data.runSearch(query: self.search)
			}
			.onChange(of: self.search) { search in
				withAnimation(.smooth(duration: 0.25)) {
					self.data.runSearch(query: search)
				}
			}
			.navigationDestination(for: Service.self) { service in
				ServiceView(service: service, tab: .saved)
					.navigationBarBackButtonHidden(true)
			}
			.navigationTitle("Saved")
			.navigationBarTitleDisplayMode(.inline)
			.toolbarBackground(.hidden)
		}
	}
}

private final class SavedViewModel: ObservableObject {
	@Published var foundServices: [Service] = []
	@Published var fetchedIds: [String] = []
	@Published var empty = true

	// CoreData only saves the IDs of saved services, so fetch them from the static array
	func getServiceIds(results: FetchedResults<SavedService>) {
		self.fetchedIds = results.map { service in service.id }
	}

	// Run a search of all the services that finds ones with matching IDs and names that
	// match the search query
	func runSearch(query: String) {
		self.foundServices = services.filter { service in
			(query.count == 0 || service.name.lowercased().contains(query.lowercased())) &&
				self.fetchedIds.contains(service.id)
		}

		self.empty = self.foundServices.count == 0
	}
}
