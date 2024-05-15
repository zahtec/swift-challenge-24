import SwiftUI
import SwiftUIIntrospect

struct ApplicationView: View {
	let service: Service

	@EnvironmentObject private var router: Router
	@EnvironmentObject private var application: Application

	@StateObject private var scrollDelegate = ApplicationViewDelegate()

	var body: some View {
		ZStack {
			List {
				// Provide room for the title
				Color.clear.frame(height: 50)
					.listRowBackground(Color.clear)

				// Form sections
				Group {
					ApplicationsGeneralInformation()

					ApplicationsLivingArrangement()

					ApplicationsSensitiveExperiences()

					ApplicationsHealthInformation()

					ApplicationsEmploymentInformation()

					ApplicationsMiscellaneous()

					ApplicationsProgramEnrollment()
				}
				.listRowBackground(Color("Input"))
			}
			.scrollContentBackground(.hidden)
			.padding(.bottom, 40)
			.environmentObject(self.application)
			.introspect(.list, on: .iOS(.v16, .v17)) { list in
				list.delegate = self.scrollDelegate
			}

			ApplicationViewHeader(serviceName: self.service.name, scrollDelegate: self.scrollDelegate)
		}
	}
}
