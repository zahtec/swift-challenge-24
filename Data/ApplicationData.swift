import SwiftUI

// MARK: The class that `ServiceApplySheetView` writes to and `DataController` converts into
// MARK: `Application`, which is stored with CoreData
final class ApplicationData: ObservableObject {
	// The application's associated service data is stored in order to easily display it on the
	// application's page, where the application data is fetched from CoreData
	var serviceName = ""
	var serviceImage = ""

	// General Information
	@Published var firstName = ""
	@Published var lastName = ""
	@Published var dob = Date()
	@Published var birthState: States = .alaska
	@Published var primaryLanguage: Language = .english

	// Living Arrangement
	@Published var livingScenario: LivingScenario = .none
	@Published var safeParkingArea = false
	@Published var location = ""
	@Published var yearsUnhoused = 1
	@Published var evictionCount = 0

	// Sensitive Experiences
	@Published var substanceAbuse = false
	@Published var inLegalScenario = false
	@Published var threatened = false
	@Published var abuse: AbuseInducer = .nobody
	@Published var receivedHelp = false
	@Published var helpDetails = ""

	// Health Information
	@Published var illnessesCount = 0
	@Published var isDisabled = false
	@Published var isPregnant = false
	@Published var medicalProvider: MedicalProvider = .uncovered

	// Employment Information
	@Published var isEmployed = false
	@Published var employmentType: EmploymentType = .partTime
	@Published var salaryRange: SalaryRange = .none
	@Published var onLeave = false
	@Published var workplace = ""

	// Miscellaneous
	@Published var migrant = false
	@Published var basicNeedsFulfilled = false
	@Published var supportingConnections = false
	@Published var debtOrCreditIssues = false
	@Published var childrenCount = 0

	// Program Enrollment
	@Published var hasCaseWorker = false
	@Published var caseWorkerName = ""
	@Published var inOtherPrograms = false
	@Published var otherPrograms = ""
	@Published var needForService = "Write about why you need this service..."
	@Published var additionalDetails = "Optionally provide any other details about your situation here..."

	// As application updates can not actually occur in this demo, a random status is selected instead
	var status = ApplicationStatus.allCases.randomElement()!

	private let nameRegex = #/^[a-zA-z ]*$/#

	// Form validation
	var isValid: Bool {
		do {
			return try self.nameRegex.wholeMatch(in: self.firstName) != nil &&
				!self.firstName.isEmpty &&
				self.nameRegex.wholeMatch(in: self.lastName) != nil &&
				!self.lastName.isEmpty &&
				!self.location.isEmpty &&
				(!self.receivedHelp || !self.helpDetails.isEmpty) &&
				(!self.isEmployed || !self.workplace.isEmpty) &&
				(!self.hasCaseWorker || !self.caseWorkerName.isEmpty) &&
				(!self.inOtherPrograms || !self.otherPrograms.isEmpty) &&
				(self.needForService != "Write about why you need this service...")
		} catch {
			return false
		}
	}
}

enum States: String, CaseIterable {
	case alaska = "Alaska"
	case alabama = "Alabama"
	case arkansas = "Arkansas"
	case arizona = "Arizona"
	case california = "California"
	case colorado = "Colorado"
	case connecticut = "Connecticut"
	case districtofColumbia = "District of Columbia"
	case delaware = "Delaware"
	case florida = "Florida"
	case georgia = "Georgia"
	case hawaii = "Hawaii"
	case iowa = "Iowa"
	case idaho = "Idaho"
	case illinois = "Illinois"
	case indiana = "Indiana"
	case kansas = "Kansas"
	case kentucky = "Kentucky"
	case louisiana = "Louisiana"
	case massachusetts = "Massachusetts"
	case maryland = "Maryland"
	case maine = "Maine"
	case michigan = "Michigan"
	case minnesota = "Minnesota"
	case missouri = "Missouri"
	case mississippi = "Mississippi"
	case montana = "Montana"
	case northCarolina = "North Carolina"
	case northDakota = "North Dakota"
	case nebraska = "Nebraska"
	case newHampshire = "New Hampshire"
	case newJersey = "New Jersey"
	case newMexico = "New Mexico"
	case nevada = "Nevada"
	case newYork = "New York"
	case ohio = "Ohio"
	case oklahoma = "Oklahoma"
	case oregon = "Oregon"
	case pennsylvania = "Pennsylvania"
	case rhodeIsland = "Rhode Island"
	case southCarolina = "South Carolina"
	case southDakota = "South Dakota"
	case tennessee = "Tennessee"
	case texas = "Texas"
	case utah = "Utah"
	case virginia = "Virginia"
	case vermont = "Vermont"
	case washington = "Washington"
	case wisconsin = "Wisconsin"
	case westVirginia = "West Virginia"
	case wyoming = "Wyoming"
}

enum Language: String, CaseIterable {
	case english = "English"
	case spanish = "Spanish"
	case other = "Other"
}

enum SalaryRange: String, CaseIterable {
	case veryHigh = "$76,000+"
	case high = "$51,000 - $75,000"
	case medium = "$26,000 - $50,000"
	case low = "$11,0000 - $25,000"
	case unsupportive = "$1,000 - $10,000"
	case none = "<$1,000"
}

enum LivingScenario: String, CaseIterable {
	case shelter = "Homeless Shelter"
	case vehicle = "Vehicle"
	case acquaintance = "Relative, Friend, or Partner's House"
	case house = "Owned or Rented House"
	case apartment = "Owned or Rented Apartment"
	case none = "Completely Unhoused"
}

enum AbuseInducer: String, CaseIterable {
	case multiple = "From Multiple Types of Individuals"
	case partner = "From Partner(s)"
	case friend = "From Friend(s)"
	case others = "From Unknown Other(s)"
	case nobody = "From Nobody"
}

enum MedicalProvider: String, CaseIterable {
	case blueshield = "Blue Shield or Blue Cross"
	case kaiser = "Kaiser Permanente"
	case hphp = "HPHP Santa Cruz"
	case medical = "MediCal"
	case other = "Other"
	case uncovered = "Uncovered"
}

enum EmploymentType: String, CaseIterable {
	case fullTime = "Full-Time"
	case partTime = "Part-Time"
	case contract = "Contract"
	case internship = "Internship"
	case selfEmployed = "Self Employed or Independent Contractor"
	case other = "Other"
}

enum ApplicationStatus: String, CaseIterable {
	case submitted = "Submitted"
	case waitlist = "Waitlist"
	case rejected = "Rejected"
	case accepted = "Accepted"
}
