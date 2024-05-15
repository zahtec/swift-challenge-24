import SwiftUI

// MARK: Shared data between `PopupServiceList` and its child `ScrollView`
final class PopupPositionModel: ObservableObject {
	@Published var dragging = false
	@Published var position: CGFloat = UIScreen.main.bounds.height - 300
}
