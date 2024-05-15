/*

 Miara's primary router. Handles each tab view's navigation path

 */

import SwiftUI

final class Router: ObservableObject {
	@Published var discover = NavigationPath()
	@Published var saved = NavigationPath()
	@Published var applications = NavigationPath()

	func getPath(for f: TabName) -> NavigationPath? {
		switch f {
		case .discover:
			return self.discover
		case .saved:
			return self.saved
		case .applications:
			return self.applications
		}
	}

	// T can either be a `Service` or an `Application`, which works for the discover and saved, and
	// applications pages respectively
	func append<T: Hashable>(for f: TabName, to: T) {
		switch f {
		case .discover:
			self.discover.append(to)
		case .saved:
			self.saved.append(to)
		case .applications:
			self.applications.append(to)
		}
	}

	// Navigate back. Maximum navigation depth is always one, so this is safe
	func popLast(for f: TabName) {
		switch f {
		case .discover:
			self.discover.removeLast()
		case .saved:
			self.saved.removeLast()
		case .applications:
			self.applications.removeLast()
		}
	}
}
