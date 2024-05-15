/*
 Unfortunately, Xcode does not list any app targets when attempting to create a data model. Thus, it
 has to be entirely in code.
 */

import CoreData

@objc(SavedService)
final class SavedService: NSManagedObject {
	@NSManaged var id: String
}

@objc(Application)
class Application: NSManagedObject {
	@NSManaged var serviceName: String
	@NSManaged var serviceImage: String

	@NSManaged var id: String
	@NSManaged var firstName: String
	@NSManaged var lastName: String
	@NSManaged var dob: Date
	@NSManaged var birthState: String
	@NSManaged var primaryLanguage: String

	@NSManaged var livingScenario: String
	@NSManaged var safeParkingArea: Bool
	@NSManaged var location: String
	@NSManaged var yearsUnhoused: Int16
	@NSManaged var evictionCount: Int16

	@NSManaged var substanceAbuse: Bool
	@NSManaged var inLegalScenario: Bool
	@NSManaged var threatened: Bool
	@NSManaged var abuse: String
	@NSManaged var receivedHelp: Bool
	@NSManaged var helpDetails: String

	@NSManaged var illnessesCount: Int16
	@NSManaged var isDisabled: Bool
	@NSManaged var isPregnant: Bool
	@NSManaged var medicalProvider: String

	@NSManaged var isEmployed: Bool
	@NSManaged var employmentType: String
	@NSManaged var salaryRange: String
	@NSManaged var onLeave: Bool
	@NSManaged var workplace: String

	@NSManaged var migrant: Bool
	@NSManaged var basicNeedsFulfilled: Bool
	@NSManaged var supportingConnections: Bool
	@NSManaged var debtOrCreditIssues: Bool
	@NSManaged var childrenCount: Int16

	@NSManaged var hasCaseWorker: Bool
	@NSManaged var caseWorkerName: String
	@NSManaged var inOtherPrograms: Bool
	@NSManaged var otherPrograms: String
	@NSManaged var needForService: String
	@NSManaged var additionalDetails: String

	@NSManaged var status: String
}
