/*
 Unfortunately, Xcode does not list any app targets when attempting to create a data model. Thus, it
 has to be entirely in code.
 */

import CoreData
import SwiftUI

extension NSEntityDescription {
	// Allow for repetitive adding of `NSAttributeDescription` to CoreData entities
	func addAttribute(name: String, type: NSAttributeDescription.AttributeType) -> Self {
		let attribute = NSAttributeDescription()
		attribute.name = name
		attribute.type = type

		self.properties.append(attribute)

		return self
	}
}

// MARK: Miara's CoreData controller, utilized to persistently store saved services
// MARK: and applications
class DataController: ObservableObject {
	let container: NSPersistentContainer

	init() {
		// Unfortunately, since there is no perceivable way to iterate over NSManaged
		// properties in Swift, CoreData has to be manually notified of properties
		// like so

		let savedServiceEntity =
			DataController.createEntity(name: "SavedService")
			.addAttribute(name: "id", type: .string)

		let applicationEntity =
			DataController.createEntity(name: "Application")
			.addAttribute(name: "serviceName", type: .string)
			.addAttribute(name: "serviceImage", type: .string)
			.addAttribute(name: "id", type: .string)
			.addAttribute(name: "firstName", type: .string)
			.addAttribute(name: "lastName", type: .string)
			.addAttribute(name: "dob", type: .date)
			.addAttribute(name: "birthState", type: .string)
			.addAttribute(name: "primaryLanguage", type: .string)
			.addAttribute(name: "livingScenario", type: .string)
			.addAttribute(name: "safeParkingArea", type: .boolean)
			.addAttribute(name: "location", type: .string)
			.addAttribute(name: "yearsUnhoused", type: .integer16)
			.addAttribute(name: "evictionCount", type: .integer16)
			.addAttribute(name: "substanceAbuse", type: .boolean)
			.addAttribute(name: "inLegalScenario", type: .boolean)
			.addAttribute(name: "threatened", type: .boolean)
			.addAttribute(name: "abuse", type: .string)
			.addAttribute(name: "receivedHelp", type: .boolean)
			.addAttribute(name: "helpDetails", type: .string)
			.addAttribute(name: "illnessesCount", type: .integer16)
			.addAttribute(name: "isDisabled", type: .boolean)
			.addAttribute(name: "isPregnant", type: .boolean)
			.addAttribute(name: "medicalProvider", type: .string)
			.addAttribute(name: "isEmployed", type: .boolean)
			.addAttribute(name: "employmentType", type: .string)
			.addAttribute(name: "salaryRange", type: .string)
			.addAttribute(name: "onLeave", type: .boolean)
			.addAttribute(name: "workplace", type: .string)
			.addAttribute(name: "migrant", type: .boolean)
			.addAttribute(name: "basicNeedsFulfilled", type: .boolean)
			.addAttribute(name: "supportingConnections", type: .boolean)
			.addAttribute(name: "debtOrCreditIssues", type: .boolean)
			.addAttribute(name: "childrenCount", type: .integer16)
			.addAttribute(name: "hasCaseWorker", type: .boolean)
			.addAttribute(name: "caseWorkerName", type: .string)
			.addAttribute(name: "inOtherPrograms", type: .boolean)
			.addAttribute(name: "otherPrograms", type: .string)
			.addAttribute(name: "needForService", type: .string)
			.addAttribute(name: "additionalDetails", type: .string)
			.addAttribute(name: "status", type: .string)

		let model = NSManagedObjectModel()
		model.entities = [savedServiceEntity, applicationEntity]

		self.container = NSPersistentContainer(name: "Main", managedObjectModel: model)

		self.container.loadPersistentStores { _, error in
			if let _ = error {
				fatalError("CoreData Failed to Load!")
			}
		}
	}

	// Add a saved service
	static func addSaved(service: Service, context: NSManagedObjectContext) {
		let savedService = SavedService(context: context)

		savedService.id = service.id

		try? context.save()
	}

	// Remove a saved service
	static func removeSaved(serviceId: String, savedServices: FetchedResults<SavedService>, context: NSManagedObjectContext) {
		context.delete(savedServices.first { saved in saved.id == serviceId }!)
		try? context.save()
	}

	// Create an application
	static func addApplication(serviceId: String, data: ApplicationData, context: NSManagedObjectContext) {
		let application = Application(context: context)

		application.serviceName = data.serviceName
		application.serviceImage = data.serviceImage

		application.id = serviceId
		application.firstName = data.firstName
		application.lastName = data.lastName
		application.dob = data.dob
		application.birthState = data.birthState.rawValue
		application.primaryLanguage = data.primaryLanguage.rawValue

		application.livingScenario = data.livingScenario.rawValue
		application.safeParkingArea = data.safeParkingArea
		application.location = data.location
		application.yearsUnhoused = Int16(data.yearsUnhoused)
		application.evictionCount = Int16(data.evictionCount)

		application.substanceAbuse = data.substanceAbuse
		application.inLegalScenario = data.inLegalScenario
		application.threatened = data.threatened
		application.abuse = data.abuse.rawValue
		application.receivedHelp = data.receivedHelp
		application.helpDetails = data.helpDetails

		application.illnessesCount = Int16(data.illnessesCount)
		application.isDisabled = data.isDisabled
		application.isPregnant = data.isPregnant
		application.medicalProvider = data.medicalProvider.rawValue

		application.isEmployed = data.isEmployed
		application.employmentType = data.employmentType.rawValue
		application.salaryRange = data.salaryRange.rawValue
		application.onLeave = data.onLeave
		application.workplace = data.workplace

		application.migrant = data.migrant
		application.basicNeedsFulfilled = data.basicNeedsFulfilled
		application.supportingConnections = data.supportingConnections
		application.debtOrCreditIssues = data.debtOrCreditIssues
		application.childrenCount = Int16(data.childrenCount)

		application.hasCaseWorker = data.hasCaseWorker
		application.caseWorkerName = data.caseWorkerName
		application.inOtherPrograms = data.inOtherPrograms
		application.otherPrograms = data.otherPrograms
		application.needForService = data.needForService
		application.additionalDetails = data.additionalDetails

		application.status = data.status.rawValue

		try? context.save()
	}

	// Based on fetched results, attain the corresponding services from the global
	// `services` variable
	static func resolveSavedServices(fetched: FetchedResults<SavedService>) -> [Service] {
		let ids = fetched.map { savedService in savedService.id }

		return services.filter { service in ids.contains(service.id) }
	}

	static func createEntity(name: String) -> NSEntityDescription {
		let entity = NSEntityDescription()

		entity.name = name
		entity.managedObjectClassName = name

		return entity
	}
}
