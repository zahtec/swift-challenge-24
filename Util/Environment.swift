/*

 Custom environment values. Currently, the only value allows for quick
 attainment of the current tab the user is on

 */

import SwiftUI

struct CurrentTabKey: EnvironmentKey {
	static let defaultValue: Binding<TabName> = .constant(.discover)
}

extension EnvironmentValues {
	var currentTab: Binding<TabName> {
		get { self[CurrentTabKey.self] }
		set { self[CurrentTabKey.self] = newValue }
	}
}
