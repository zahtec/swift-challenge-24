import MapKit

// MARK: The map annotation dataclass that stores the parent `MKMapView` and the service
// MARK: being displayed
final class MapServiceAnnotation: NSObject, MKAnnotation {
	let service: Service
	let mapView: MKMapView

	@objc dynamic var coordinate: CLLocationCoordinate2D

	init(_ service: Service, _ mapView: MKMapView) {
		self.coordinate = service.coordinate
		self.service = service
		self.mapView = mapView
	}
}
