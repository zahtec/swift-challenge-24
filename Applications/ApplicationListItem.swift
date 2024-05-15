import SwiftUI

// MARK: The view for displaying a application in any form of list
struct ApplicationListItem: View {
	let application: Application

	var body: some View {
		HStack(spacing: 10) {
			ZStack {
				Image(self.application.serviceImage)
					.resizable()
					.scaledToFill()
					.frame(width: 58, height: 58)
					.blur(radius: 5)
					.clipShape(RoundedRectangle(cornerRadius: 15))

				Image(systemName: "doc.fill")
					.resizable()
					.scaledToFill()
					.frame(width: 25, height: 25)
					.foregroundStyle(.white)
					.shadow(radius: 5)

				HStack {
					Spacer()

					// Represent the application's status as an overlayed circle in the bottom right
					// corner of the service's image
					Circle()
						.fill(Color(self.application.status))
						.frame(width: 15, height: 15)
						.padding([.bottom, .trailing], -3.5)
						.shadow(radius: 2)
				}
				.frame(width: 58, height: 58, alignment: .bottom)
			}

			VStack(alignment: .leading, spacing: 1) {
				Text(self.application.status.uppercased())
					.font(.system(size: 10, weight: .black))
					.foregroundStyle(Color(self.application.status))

				Text(self.application.serviceName)
					.font(.system(size: 15, weight: .semibold))

				Text("\(self.application.firstName.capitalized) \(self.application.lastName.capitalized)")
					.font(.system(size: 13, weight: .light))
			}

			Spacer()

			Image(systemName: "chevron.right")
				.foregroundStyle(Color("Secondary"))
				.padding(.trailing, 7)
		}
		.padding(.horizontal, 11)
		.padding(.vertical, 13)
		.frame(height: 83)
		.frame(maxWidth: .infinity)
		.background(.background)
		.clipShape(RoundedRectangle(cornerRadius: 20))
		.shadow(color: Color("GeneralShadow").opacity(0.5), radius: 12)
	}
}
