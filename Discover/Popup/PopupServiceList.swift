import SwiftUI
import SwiftUIIntrospect

// MARK: The list of services embedded within the popup view
struct PopupServiceList: View {
	var searchFocused: FocusState<Bool>.Binding
	@EnvironmentObject var positionData: PopupPositionModel

	@State var search = ""
	@State private var overlayShadow = false
	@StateObject private var data = PopupServiceListModel()
	@StateObject private var scrollDelegate = PopupServiceListDelegate()
	@EnvironmentObject private var router: Router

	var body: some View {
		ScrollView {
			VStack(spacing: 13) {
				ForEach(self.data.foundServices) { service in
					Button {
						self.router.append(for: .discover, to: service)
					} label: {
						ServiceListItem(service: service)
					}
					.buttonStyle(ListButton())
				}

				if self.data.foundServices.count == 0 {
					Text("No Results Found")
						.foregroundStyle(Color("Tertiary"))
				}

				Spacer()
			}
			.frame(maxWidth: .infinity)
			.frame(alignment: .top)
			.padding(15)
			.padding(.vertical, 70)
		}
		.scrollIndicators(.hidden)
		.background(Color("Primary"))
		.overlay {
			VStack {
				SearchBar(search: self.$search, overlayShadow: self.$overlayShadow, searchFocused: self.searchFocused)

				Spacer()
			}
			// Prevent the shadow from displaying above the `SearchBar` view
			.clipped()
		}
		.ignoresSafeArea(.keyboard)
		// As there are many advanced scroll functionalities being utilized here, using SwiftUI @ iOS 16.0
		// capabilities is not feasible. Hence, SwiftIntrospect is utilized to extract the underlying
		// UIScrollView
		.introspect(.scrollView, on: .iOS(.v16, .v17)) { view in
			// Set the needed scroll event handler variables before assigning the delegate
			self.scrollDelegate.overlayShadow = self.$overlayShadow
			self.scrollDelegate.searchFocused = self.searchFocused
			self.scrollDelegate.positionData = self.positionData

			view.delegate = self.scrollDelegate
		}
		.onChange(of: self.search) { search in
			self.data.runSearch(query: search)
		}
	}
}

private final class PopupServiceListModel: ObservableObject {
	// Show all services by default as the primary list
	@Published var foundServices = services

	// Run a search of all the services. Match the name to the search query
	func runSearch(query: String) {
		withAnimation(.smooth(duration: 0.25)) {
			self.foundServices = services.filter { service in
				query.count == 0 || service.name.lowercased().contains(query.lowercased())
			}
		}
	}
}
