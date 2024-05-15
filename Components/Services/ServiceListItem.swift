import SwiftUI

// MARK: The view for displaying a service in any form of list
struct ServiceListItem: View {
	let service: Service

	var body: some View {
		HStack(spacing: 10) {
			Image(self.service.image)
				.resizable()
				.scaledToFill()
				.frame(width: 58, height: 58)
				.clipShape(RoundedRectangle(cornerRadius: 15))

			VStack(alignment: .leading, spacing: 2.5) {
				Text(self.service.name)
					.font(.system(size: 15, weight: .semibold))

				Text(self.service.address)
					.font(.system(size: 13, weight: .light))

				// Display a bar relative to the list item's size that represents
				// the availability of the service
				GeometryReader { proxy in
					HStack {
						Text(self.service.availability.rawValue.uppercased())
							.font(.system(size: 10, weight: .heavy))
							.foregroundStyle(Color(self.service.availability.rawValue))

						RoundedRectangle(cornerRadius: 100)
							.fill(Color(self.service.availability.rawValue))
							.frame(
								width: proxy.size.width * barSize(self.service.availability),
								height: 5
							)

						Spacer()
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.top, 1)

				Spacer()
			}

			Spacer()

			Image(systemName: "chevron.right")
				.foregroundStyle(Color("Tertiary"))
				.padding(.trailing, 7)
		}
		.padding(.horizontal, 11)
		.padding(.vertical, 13)
		.frame(height: 80)
		.frame(maxWidth: .infinity)
		.background(Color("Primary"))
		.clipShape(RoundedRectangle(cornerRadius: 20))
		.shadow(color: Color("GeneralShadow").opacity(0.5), radius: 12)
		.animation(.none, value: self.service)
	}
}

func barSize(_ availability: Availability) -> Double {
	switch availability {
	case .high:
		return 0.8

	case .medium:
		return 0.6

	case .low:
		return 0.4

	case .none:
		return 0
	}
}

#Preview {
	ServiceListItem(service: services[0])
		.padding(.horizontal, 20)
}
