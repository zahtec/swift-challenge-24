import MapKit

// MARK: Draws the pin's teardrop shape
func drawPinShape(_ rect: CGRect, _ view: MKAnnotationView) {
	guard let context = UIGraphicsGetCurrentContext() else { return }

	context.translateBy(x: 0, y: -6)
	context.beginPath()

	// Draw from the bottom-left of the top circle
	context.move(
		to: .init(
			x: rect.midX + cos(Double.pi / 4) * 24.08,
			y: rect.midY + sin(Double.pi / 4) * 24.08
		)
	)

	// To right before the teardrop's endpoint
	context.addLine(
		to: .init(
			x: rect.midX + 3.36,
			y: rect.midY + 31.36
		)
	)

	// Curved teardrop point
	context.addCurve(
		to: .init(
			x: rect.midX - 3.36,
			y: rect.midY + 31.36
		),
		control1: .init(
			x: rect.midX,
			y: rect.midY + 34.72
		),
		control2: .init(
			x: rect.midX,
			y: rect.midY + 34.72
		)
	)

	// Draw from the left-side end of the point back up to the primary arc
	context.addLine(
		to: .init(
			x: rect.midX + cos((3 * Double.pi) / 4) * 24.08,
			y: rect.midY + sin((3 * Double.pi) / 4) * 24.08
		)
	)

	// Draw the body of the teardrop, an arc
	context.addArc(
		center: .init(x: rect.midX, y: rect.midY),
		radius: 24.08,
		startAngle: (3 * Double.pi) / 4,
		endAngle: Double.pi / 4,
		clockwise: false
	)

	if view.traitCollection.userInterfaceStyle == .light {
		UIColor.white.setFill()
	} else {
		UIColor.black.setFill()
	}

	context.setShadow(offset: .zero, blur: 5)

	context.fillPath()
}
