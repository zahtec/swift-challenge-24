import SwiftUI

@main
struct MiaraApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
	@StateObject private var router = Router()
	@StateObject private var dataController = DataController()
	@State private var currentTab: TabName = .discover

	var body: some Scene {
		WindowGroup {
			TabBar {
				DiscoverView()
					.tag(TabName.discover)

				SavedView()
					.tag(TabName.saved)

				ApplicationsView()
					.tag(TabName.applications)
			}
			.environmentObject(self.router)
			.environment(\.managedObjectContext, self.dataController.container.viewContext)
			.environment(\.currentTab, self.$currentTab)
		}
	}
}
