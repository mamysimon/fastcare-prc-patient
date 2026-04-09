%dw 2.0
output application/json

var patient = vars.patient
var consultations = vars.medicalRecord.consultations
var allergies = vars.medicalRecord.allergies
var laboratoryResults = vars.laboratoryResults
var radiologyResults = vars.radiologyResults

fun gender(code): String = code match {
	case "M" -> "male"
	case "F" -> "female"
	else -> "male"	
}

---
{
	"id": patient.externalId,
	"firstname": splitBy(patient.fullName, " ")[0],
	"lastname": splitBy(patient.fullName, " ")[1],
	"gender": gender(patient.genderCode),
	"birthDate": patient.dobRow as Date,
	"phoneNumber": patient.phoneNumber,
	"email": patient.emailAddress,
	"postalAddress": "$(patient.addressLine), $(patient.zipCode) $(patient.city)",
	"emergencyContact": {
		"firstname": splitBy(patient.emergencyContactFullName, " ")[0],
		"lastname": splitBy(patient.emergencyContactFullName, " ")[1],
		"phoneNumber": patient.emergencyContactNumber replace /^0/ with "+33",
		"relation": patient.emergencyContactRelation
	},
	"insurance": {
		"name": patient.insuranceName,
		"number": patient.insuranceNumber
	},
	"medicalRecord": {
		"history": consultations map ((consultation) -> {
			"date": consultation.visitDate as Date,
			"practitioner": consultation.practitionerName,
			"reasonForVisit": consultation.reasonForVisit,
			"clinicalNotes": consultation.clinicalNotes,
			"prescriptions": if(!isEmpty(consultation.prescriptionsList)) splitBy(consultation.prescriptionsList, ", ") else [],
			"bloodPressure": consultation.bloodPressure default "",
			"temperature": if(consultation.temperature != null) "$(consultation.temperature) °C" else ""
		}),
		"allergies": allergies map ((allergy) -> {
			"type": allergy.allergenType,
			"name": allergy.allergenName,
			"severity": allergy.severityLevel
		})
	},
	"laboratoryResults": laboratoryResults map ((result) -> {
		"date": result.examDate as Date,
		"testName": result.testName,
		"resultValue": result.resultValue,
		"unit": result.unit default "N/A",
		"range": result.range default "N/A",
		"interpretation": result.status default "N/A",
		"technician": result.labTechnician
	}),
	"radiologyResults": radiologyResults map ((result) -> {
		"date": result.examDate as Date,
		"examType": result.examType,
		"bodyPart": result.bodyPart,
		"findings": result.findings,
		"urgency": result.urgency,
		"radiologist": result.radiologist
	})
}