/*
 The static data of the Miara app, containing all of its services and associated enums
 */

import CoreLocation

enum Availability: String {
	case high = "High"
	case medium = "Medium"
	case low = "Low"
	case none = "None"
}

struct Service: Identifiable, Hashable {
	let id: String
	let name: String
	let description: String
	let about: String
	let email: String?
	let phone: String?
	let website: String?
	let address: String
	let requirements: [String]
	let image: String
	let availability: Availability
	let availabilityUpdated: String
	let availabilityExplanation: String
	let coordinate: CLLocationCoordinate2D

	func hash(into hasher: inout Hasher) {
		hasher.combine(self.id)
	}

	static func == (lhs: Service, rhs: Service) -> Bool {
		lhs.id == rhs.id
	}
}

let services: [Service] = [
	.init(
		id: "bc1xql68yh8jipxs91pgyggx",
		name: "Encompass Residential Recovery",
		description: "Located just outside of downtown Santa Cruz, in a historic Victorian home, the Santa Cruz Residential Recovery program offers a 30-bed co-ed residential program, serving clients for 30-90 days based on individual needs.",
		about: "The Santa Cruz Residential Recovery is staffed by a highly skilled and trained team where certified clinicians help clients focus on issues surrounding recovery from substance use and co-occurring disorders.  Program activities include evidence-based trauma informed and cognitive behavior therapies (CBT), Dialectical Behavioral Therapy (DBT), as well as focused individual and group counseling, pro-social life skill building, mindfulness and daily house meetings.",
		email: "recoverysupport@encompasscs.org",
		phone: "0018312263728",
		website: "https://www.encompasscs.org/santa_cruz_residential_recovery",
		address: "125 Rigg St, Santa Cruz, CA 95060",
		requirements: [],
		image: "ERR",
		availability: .low,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Since the COVID-19 pandemic, Santa Cruz has had an immense decline in available housing. As such, Encompass Residential Recovery is accepting applicants but can not guarantee housing to applications. Very few applicants, who are typically experiencing immense trauma, abuse, etcetera, are being placed in housing at this moment.",
		coordinate: .init(latitude: 36.96959913837745, longitude: -122.03405294909871)
	),
	.init(
		id: "bjw8zqh64imumriu3fwloc3z",
		name: "Pajaro Valley Shelter Services",
		description: "Pajaro Valley Shelter Services, located in Santa Cruz County, offers a range of supportive housing programs to assist homeless women, children, and families in need.",
		about: "PVSS' emergency shelter provides a safe environment for families to reside for a maximum of 6 months. With a current capacity of 30 women and children, the shelter offers coordinated case management support, individual life plan development, and assistance in areas such as employment, education, housing, and budgeting. Additionally, families learn essential financial literacy skills to promote long-term self-sufficiency. PVSS' 1-Year Transitional Housing program supports single- and two-parent households with children, allowing them to reside in two housing units for up to 12 months. Its 2-Year Transitional Housing program offers 13 single-family homes for families to reside in for a maximum of 24 months. Both programs provide the same comprehensive support as the Emergency Shelter, focusing on empowering families with the aforementioned provisions.",
		email: nil,
		phone: "0018317285649",
		website: "https://www.pvshelter.org",
		address: "115 Brennan Street, Watsonville, CA 95076",
		requirements: [],
		image: "PVS",
		availability: .medium,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Pajaro Valley's services have been witnessing an increase in budget size due to recent grants. Availability has improved and is above the level of Santa Cruz City; however, the quality of care may not be to the standard of other, more county-centric programs.",
		coordinate: .init(latitude: 36.91478951370264, longitude: -121.7590958515346)
	),
	.init(
		id: "bsn4cbsnsikthpxwpb8aaztp",
		name: "Encompass Links2Health",
		description: "Encompass Links2Health is a comprehensive program offered in Santa Cruz County, California, designed to provide wraparound care to community members, particularly Medi-Cal beneficiaries, to help them meet essential life needs and improve health outcomes.",
		about: "The Links2Health program is made possible by new funding and aims to reduce barriers to quality care by providing comprehensive case management and care coordination. It breaks down the traditional walls of health care by meeting individuals in the community, shelters, doctors' offices, or at home to address their greatest health needs. Through Links2Health, eligible individuals, including those experiencing homelessness, adults with Serious Mental Illness (SMI) or Substance Use Disorder (SUD), and high utilizers of the healthcare system, can be connected to various social services such as housing navigation, housing retention, and sustaining services.",
		email: nil,
		phone: nil,
		website: "https://www.encompasscs.org/links2health",
		address: "380 Encinal St Suite 200, Santa Cruz, CA 95060",
		requirements: [
			"Be a Medi-Cal member.",
			"Be an adult experiencing homelessness;",
			"a serious mental illness;",
			"a substance abuse disorder;",
			"or high reliance on the healthcare system.",
		],
		image: "LTH",
		availability: .medium,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Encompass has been effectively providing people with proper health care for numerous years and is continuing to do so. While wait times are exacerbated due to high demand, Encompasses's health partners have been able to consistently provide aid to Links2Health members.",
		coordinate: .init(latitude: 36.98829652442092, longitude: -122.03746163876752)
	),
	.init(
		id: "crk1mq0qfzdwefsx6sh3oj5g",
		name: "Homeless Persons' Health Project",
		description: "The Homeless Persons' Health Project (HPHP) project offers a comprehensive range of services to individuals experiencing homelessness and low-income populations in Santa Cruz County.",
		about: "The professional team at HPHP provides respectful medical care and treatment, health benefit advocacy, payee services, and permanent supportive housing programs. They also offer assistance with benefits applications, including EBT, GA, SSI, SSDI, and Medi-Cal. The medical staff, including medical assistants, nurses, physician assistants, and doctors, provide day-to-day and emergency care, long-term health and care, continuity of care, and referrals for more complex medical issues. The clinic emphasizes a patient-centered approach, continuity of care, and excellent coordination of services to improve the quality of care available to the homeless and low-income population in Santa Cruz County. HPHP is committed to providing healthcare, information on local food and shelter programs, referrals, and related topics to those in need, and welcomes walk-ins. The clinic is open Monday to Thursday from 8am to 5pm, and on Fridays from 8am to 3pm, with after-hours services available for established patients only. During 12pm to 1pm on all days, the clinic will be closed for lunch.",
		email: "hphpreferral@santacruzcountyca.gov",
		phone: "0018667314747",
		website: "https://www.santacruzhealth.org/HSAHome/HSADivisions/ClinicServices/HomelessPersonsHealthProject.aspx",
		address: "1080 Emeline Ave, Santa Cruz, CA 95060",
		requirements: [],
		image: "HPHP",
		availability: .medium,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Being the highest rated homelessness aid clinic in the county according to community members, the Homeless Persons' Health Project is continuing to provide services despite high demand. However, due to their direct affiliation with the county, wait times are immensely long for both new applications and program members.",
		coordinate: .init(latitude: 36.99148619978926, longitude: -122.01611716139688)
	),
	.init(
		id: "droso8vdqichvgohrxk0lvwj",
		name: "Housing Matters",
		description: "Housing Matters, located in Santa Cruz, CA, offers a multitude of programs and services to support individuals experiencing homelessness. They are one of the premier providers in Santa Cruz County, and have helped thousands of individuals.",
		about: "Housing Matters' services include housing navigation, employment training programs, and on-campus amenities such as bathrooms, hot showers, and a dedicated mailroom. Their campus hosts partner health organizations, including the Homeless Persons Health Project and Dientes Community Dental, which collectively provide healthcare services, dental care, and employment training. Overall, Housing Matters' employs a comprehensive approach that aims to address the diverse needs of the homeless population in Santa Cruz, supporting them in their journey towards stable housing and self-sufficiency.",
		email: "contact@housingmatterssc.org",
		phone: "0018314586020",
		website: "https://housingmatterssc.org",
		address: "115 Coral St, Santa Cruz, CA 95060",
		requirements: [
			"Be utilizing the healthcare system extensively",
			"Experiencing chronic homelessness",
			"Be in need of on-site services.",
		],
		image: "HM",
		availability: .low,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Housing Matters has witnessed a decline in provided county services and has suffered in accordance. Their permanent housing has no availability and their rapid rehousing program is restricted in terms of whom it can provide.",
		coordinate: .init(latitude: 36.985162072965736, longitude: -122.03060980920422)
	),
	.init(
		id: "xscza2ownjy4i4leicrh9jnk",
		name: "Healing The Streets",
		description: "The Healing the Streets (HTS) program in Santa Cruz County provides supportive case management services to homeless individuals with mental health needs, potentially impacted by substance use. It combines street medicine, behavioral health services, peer support, and housing assistance. The program operates in Watsonville and Santa Cruz.",
		about: "The Healing the Streets (HTS) program, offered in Santa Cruz County, is a comprehensive initiative designed to support individuals experiencing homelessness who also have mental health needs and may be negatively impacted by substance. The program provides a range of services, including street medicine, behavioral health services, case management, peer support, and housing assistance. Services are delivered by a field-based team and a mobile health van, which can be found at various locations in the county depending on its schedule, a calendar on the project's website. The program operates in the cities of Watsonville and Santa Cruz, working collaboratively with county partners and key stakeholders. The HTS program is funded by the Substance Abuse and Mental Health Administration (SAMHSA).",
		email: nil,
		phone: "0018314544352",
		website: "https://www.santacruzhealth.org/HSAHome/HSADivisions/BehavioralHealth/MentalHealthServicesAct/HealingtheStreets(HTS).aspx",
		address: "301 Armory Rd, Santa Cruz, CA 95060",
		requirements: [
			"At least 18 years of age",
			"Experiencing mental health or substance use issues",
		],
		image: "HTS",
		availability: .medium,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Although the county is suffering from a shortage of case workers, Healing The Streets is still providing direction and marginal aid to those who arrive in person at its Santa Cruz location. However, ll of its partner services, which individuals are referred to, have extremely low availability and often are unable to provide additional care that may be desired.",
		coordinate: .init(latitude: 36.992984572843376, longitude: -122.0058705525656)
	),
	.init(
		id: "l47okzwecs93taieear2ccge",
		name: "Pajaro Rescue Mission",
		description: "The Pajaro Rescue Mission, located in Santa Cruz County, offers essential emergency services to the local community 365 days a year. These services include bilingual daily Bible services, shelter for up to 35 homeless men, nourishing meals served twice a day, daily showers, and modern, well-ventilated dormitories.",
		about: "The Pajaro Rescue Mission is a christian-based support group that provides community members opportunities to aid the homeless and the homeless various services. Their offerings include Bible sessions, Gospel messages, hygiene supplies, food, and clothing. The mission is committed to providing a safe and supportive environment and does so by provisioning nightly shelter, dinner and breakfast, cots, and showers for those in need.",
		email: nil,
		phone: "0018317249576",
		website: "https://teenchallengemb.org/our-centers/pajaro-rescue-mission/",
		address: "111 Railroad Ave, Royal Oaks, CA 95076",
		requirements: [],
		image: "PM",
		availability: .high,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Although their housing services are depleted, the food and religious programs that Pajaro Rescue Mission provides are highly available. Constraints due to funding have made the continuation of such programs at scale difficult, but the mission is still finding value in supporting as many community members as it can.",
		coordinate: .init(latitude: 36.89753542737194, longitude: -121.74062868160979)
	),
	.init(
		id: "pdgn58cupzb5vz36rxomujbx",
		name: "Sí Se Puede",
		description: "Sí Se Puede is one of the only bilingual and monolingual treatment environments in the nation. It is a 23-bed residential program that serves Spanish speaking, male clientele for a 30-90 day period, based on individual client needs.",
		about: "Sí Se Puede is located in the serene foothills of Watsonville, CA. Staffed by a bilingual team, highly skilled, trained and certified clinicians help clients focusing on issues surrounding recovery from substance use and co-occurring disorders. Program activities include evidence-based trauma informed and cognitive behavioral therapies (CBT), Dialectical Behavioral Therapy (DBT), as well as focused individual and group counseling, pro-social life skill building, mindfulness and daily house meetings.",
		email: "recoverysupport@encompasscs.org",
		phone: "0018312263728",
		website: "https://www.encompasscs.org/si_se_puede",
		address: "161 Miles Ln, Watsonville, CA 95076",
		requirements: [],
		image: "SSP",
		availability: .none,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Despite it 30-90 day period, Sí Se Puede possesses an immensely long waitlist and is understaffed. Unfortunately, although accepting applications, the program will be unable to provide most individuals for some time.",
		coordinate: .init(latitude: 36.921265839517794, longitude: -121.76466782397827)
	),
	.init(
		id: "yum7qnufdzj1q72q4sakvfk5",
		name: "ALTO Counseling",
		description: "ALTO is a free counseling program that offers outpatient services, drinking driver programs, drug court and more.",
		about: "ALTO's services include individual and group counseling, drinking driver programs, and support for those involved in drug court. The program is staffed by trained professionals who employ proven approaches to help individuals achieve and maintain sobriety. All services are provided in a confidential and comfortable setting, with flexible hours and a sliding fee scale to accommodate different needs. The ALTO program is licensed by the State Department of Health Care Services and is wholly dedicated to supporting individuals in their recovery journey.",
		email: "crs@encompasscs.org",
		phone: "0018314232003",
		website: "https://www.encompasscs.org/alto",
		address: "716 Ocean St, Santa Cruz, CA 95060",
		requirements: [],
		image: "ALTO",
		availability: .low,
		availabilityUpdated: "2/20/24",
		availabilityExplanation: "Owned by Encompass, ALTO Counseling is part of the organization's health network and continues to provide adequate care to the best of its ability. Unfortunately, the service is behind on applications and can not guarantee a timely response.",
		coordinate: .init(latitude: 36.97868615852074, longitude: -122.02063353263082)
	),
]
