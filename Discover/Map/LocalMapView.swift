import MapKit
import SwiftUI

// MARK: The main map, encompassing the predominant amount of Santa Cruz County
struct LocalMapView: View {
	@ObservedObject var mapData: MapModel
	@State private var region = MKCoordinateRegion(
		center: .init(
			latitude: 36.97528244284856,
			longitude: -122.01986868271841
		),
		span: .init(
			latitudeDelta: 0.35,
			longitudeDelta: 0.35
		)
	)

	var body: some View {
		UIKitMap(region: self.$region, mapData: self.mapData)
	}
}
