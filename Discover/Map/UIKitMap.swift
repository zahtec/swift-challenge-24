import MapKit
import SwiftUI

// The `Map` view in SwiftUI in iOS 16.0 is not capable enough for the complications of Miara's
// map. Therefore, a MKMapView UIViewRepresentable is utilized
struct UIKitMap: UIViewRepresentable {
	@Binding var region: MKCoordinateRegion
	var mapData: MapModel

	// Initiate the custom tile renderer for offline map use. See `TileOverlay` for
	// more information on the tile source
	@State var tileRenderer: MKTileOverlayRenderer = .init(
		tileOverlay: {
			let overlay = TileOverlay()
			overlay.canReplaceMapContent = true
			return overlay
		}()
	)

	func makeUIView(context: Context) -> MKMapView {
		let map = MKMapView()

		map.showsScale = false
		map.isPitchEnabled = false
		map.showsTraffic = false
		map.showsCompass = false
		map.showsBuildings = true
		map.isRotateEnabled = false

		// Set the boundary to encapsulate Santa Cruz City and Watsonville
		map.setCameraBoundary(
			.init(
				mapRect: .init(
					origin: .init(
						.init(
							latitude: 37.00055578647542,
							longitude: -122.07712774773498
						)
					),
					size: .init(
						width: 251_000,
						height: 100_000
					)
				)
			),
			animated: false
		)
		

		map.setCameraZoomRange(
			.init(
				minCenterCoordinateDistance: 3500,
				maxCenterCoordinateDistance: 40000
			),
			animated: false
		)

		map.layoutMargins.top = -50
		map.layoutMargins.bottom = -50

		map.setRegion(self.region, animated: false)

		// Add the annotations for every service utilizing the custom `MapServiceAnnotation` that holds
		// each service's data
		map.addAnnotations(
			services.map { service in
				MapServiceAnnotation(service, map)
			}
		)

		// Add the tile replacement overlay
		map.addOverlay(self.tileRenderer.overlay, level: .aboveLabels)

		map.delegate = context.coordinator

		// When an individual closes the `ServiceView` view utilizing the X button, the
		// map needs to correspond and deselect the annotation
		self.mapData.unselectAnnotationCallback = {
			map.deselectAnnotation(nil, animated: true)
		}

		return map
	}

	func updateUIView(_ map: MKMapView, context _: Context) {
		map.setRegion(self.region, animated: true)
	}

	func makeCoordinator() -> Coordinator {
		Coordinator(region: self.$region, tileRenderer: self.$tileRenderer, mapData: self.mapData)
	}

	final class Coordinator: NSObject, MKMapViewDelegate {
		@Binding var region: MKCoordinateRegion
		@Binding var tileRenderer: MKTileOverlayRenderer
		var mapData: MapModel

		init(region: Binding<MKCoordinateRegion>, tileRenderer: Binding<MKTileOverlayRenderer>, mapData: MapModel) {
			self._region = region
			self._tileRenderer = tileRenderer
			self.mapData = mapData
		}

		func mapView(_ map: MKMapView, regionDidChangeAnimated _: Bool) {
			self.region = map.region
		}

		// Annotation rendering handler
		func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
			if let annotation = annotation as? MKClusterAnnotation {
				// Either recycle or create a new cluster annotation
				let annotationView =
					(
						mapView.dequeueReusableAnnotationView(withIdentifier: clusterAnnotationViewIdentifier) as? ClusterServiceAnnotationView
							??
							ClusterServiceAnnotationView(annotation: annotation, reuseIdentifier: clusterAnnotationViewIdentifier)
					)

				annotationView.canShowCallout = false
				annotationView.annotation = annotation

				// Provide the cluster annotation with the underlying service being clustered by it. Needed to
				// show a count of the services being clustered
				annotationView.setServices(annotation: annotation)

				return annotationView
			}

			if let annotation = annotation as? MapServiceAnnotation {
				// Either recycle or create a new service annotation
				let annotationView = (
					mapView.dequeueReusableAnnotationView(withIdentifier: annotationViewIdentifier) as? ServiceAnnotationView
						??
						ServiceAnnotationView(annotation: annotation, reuseIdentifier: annotationViewIdentifier)
				)

				annotationView.canShowCallout = false
				annotationView.annotation = annotation

				// This could be any value, but utilizing the `clusterAnnotationViewIdentifier` felt appropriate as the annotation
				// and clustering identifiers do not interact anyways
				annotationView.clusteringIdentifier = clusterAnnotationViewIdentifier

				return annotationView
			}

			return nil
		}

		// Annotation tap event handler
		func mapView(_ map: MKMapView, didSelect view: MKAnnotationView) {
			if let view = view as? ClusterServiceAnnotationView {
				// Zoom in where the cluster is to reveal the underlying services. This is done depending on the
				// amount of services composing the annotation as a larger zoom is typically needed for larger numbers
				// of services. The map is quite sparse due to it being a demo; hence, this is appropriate
				map.setRegion(
					.init(
						center: view.annotation!.coordinate,
						span: .init(
							latitudeDelta: map.region.span.latitudeDelta / CGFloat(2 * view.services.count),
							longitudeDelta: map.region.span.longitudeDelta / CGFloat(2 * view.services.count)
						)
					),
					animated: true
				)

				map.deselectAnnotation(nil, animated: false)
			} else if let view = view as? ServiceAnnotationView {
				// Let other views know that a service was selected
				self.mapData.selectedService = view.service.id
			}
		}

		// Run when an annotation is deselected. Propagates change to other views
		func mapView(_: MKMapView, didDeselect view: MKAnnotationView) {
			guard let _ = view as? ServiceAnnotationView else { return }

			self.mapData.selectedService = nil
		}

		func mapView(_: MKMapView, rendererFor _: MKOverlay) -> MKOverlayRenderer {
			return self.tileRenderer
		}
	}
}
