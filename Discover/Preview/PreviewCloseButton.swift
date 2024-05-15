import SwiftUI

struct PreviewCloseButton: View {
	@EnvironmentObject var mapData: MapModel

	var body: some View {
		VStack {
			Spacer()

			if self.mapData.selectedService != nil {
				Button {
					// Deselect annotation
					self.mapData.selectedService = nil
					self.mapData.unselectAnnotationCallback?()
				} label: {
					Image(systemName: "xmark")
				}
				.foregroundStyle(Color("Tertiary"))
				.padding(10)
				.background(.background)
				.clipShape(Circle())
			}
		}
		.padding(.bottom, 200)
	}
}
