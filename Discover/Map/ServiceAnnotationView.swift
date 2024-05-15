import MapKit

// MARK: The custom view for the service annotations
final class ServiceAnnotationView: MKAnnotationView, UIGestureRecognizerDelegate {
	let service: Service

	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		let annotation = annotation as! MapServiceAnnotation

		self.service = annotation.service

		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

		self.frame = CGRect(x: 0, y: 0, width: 50, height: 60)
		self.backgroundColor = .clear
		self.anchorPoint = .init(x: 0.5, y: 1)

		self.setupImageView()
	}

	// Needed for conformance
	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) not implemented!")
	}

	override func draw(_ rect: CGRect) {
		drawPinShape(rect, self)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		if !animated {
			return
		}

		// Scale the pin up/down when it is selected/deselected
		UIView.animate(
			withDuration: 0.2,
			delay: 0.0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 20,
			options: .curveEaseOut
		) {
			self.transform = selected ? .init(scaleX: 1.15, y: 1.15) : .init(scaleX: 1, y: 1)
		}
	}

	// Place the service's primary image over the teardrop shape
	private func setupImageView() {
		let imageView = UIImageView(frame: .init(x: 5, y: 4, width: 40, height: 40))

		imageView.image = UIImage(named: self.service.image)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 20
		imageView.clipsToBounds = true

		self.addSubview(imageView)
	}
}
