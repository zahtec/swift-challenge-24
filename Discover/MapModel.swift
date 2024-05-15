import SwiftUI

// MARK: Shared data between the `PopupView`, `ServiceView`, and `LocalMapView` views
final class MapModel: ObservableObject {
	@Published var disableMap = false
	@Published var selectedService: String?

	var unselectAnnotationCallback: (() -> Void)?
}
