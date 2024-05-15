import MapKit

// MARK: The custom view for the service annotations
final class ClusterServiceAnnotationView: MKAnnotationView {
	var services: [Service]

	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		// We know the only annotation type that this is constructed with is `MKClusterAnnotation`, so
		// this is safe
		let annotation = annotation as! MKClusterAnnotation

		// Assign the `MKClusterAnnotation`'s underlying services
		self.services = annotation.memberAnnotations.map { annotation in (annotation as! MapServiceAnnotation).service }

		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

		self.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
		self.backgroundColor = .clear
		self.anchorPoint = .init(x: 0.5, y: 1)

		self.setupCountLabel()
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) not implemented!")
	}

	override func draw(_ rect: CGRect) {
		drawPinShape(rect, self)
	}

	// Show a count of the number of underlying services on the annotation
	private func setupCountLabel() {
		let labelView = UILabel(frame: .init(x: 5, y: 5, width: 40, height: 40))

		labelView.text = self.services.count.formatted()
		labelView.font = .systemFont(ofSize: 20, weight: .semibold)
		labelView.textAlignment = .center

		self.addSubview(labelView)
	}

	// Since a custom dataclass for cluster annotations can not be used in this scenario, we must set the services
	// and update the `UILabel` service count each time the annotation is recycled
	func setServices(annotation: MKClusterAnnotation) {
		self.services = annotation.memberAnnotations.map { annotation in (annotation as! MapServiceAnnotation).service }

		if let labelView = self.subviews[0] as? UILabel {
			labelView.text = self.services.count.formatted()
		}
	}
}
