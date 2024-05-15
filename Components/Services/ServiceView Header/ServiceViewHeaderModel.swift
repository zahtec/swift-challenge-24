import SwiftUI

// MARK: Shared transition state shared between the `ServiceViewHeader`,
// MARK: `ServiceViewHeaderImageTitle`, and `ServiceViewHeaderNavigationBar` views
final class ServiceViewHeaderModel: ObservableObject {
	@Published var navigationBarOpacity: Double = 0
	@Published var titleHeight: Double = 0
	@Published var titleOffset: Double = 0
}
