import SwiftUI

// MARK: A color-stepped bar indicating a service's availability
struct ServiceAvailabilityRange: View {
	let level: Availability
	var offset: CGFloat {
		switch self.level {
		case .high:
			return 37.5
		case .medium:
			return 12.5
		case .low:
			return -12.5
		case .none:
			return -37.5
		}
	}

	var body: some View {
		ZStack {
			HStack(spacing: 0) {
				Rectangle()
					.fill(Color("None"))
					.frame(width: 25)

				Rectangle()
					.fill(Color("Low"))
					.frame(width: 25)

				Rectangle()
					.fill(Color("Medium"))
					.frame(width: 25)

				Rectangle()
					.fill(Color("High"))
					.frame(width: 25)
			}
			.frame(width: 100, height: 20)
			.clipShape(RoundedRectangle(cornerRadius: 7))

			Image(systemName: "triangle.fill")
				.foregroundStyle(.white)
				.shadow(radius: 5)
				.padding(.top, 20)
				.offset(x: self.offset)
		}
	}
}

#Preview {
	ServiceAvailabilityRange(level: .high)
}
