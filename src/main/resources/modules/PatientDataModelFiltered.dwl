%dw 2.0
output application/json
---
if(vars.role == "patient")
	vars.patientDataModel update {
		case .medicalRecord.history -> $ map (consultation) -> (consultation -- [
	        "clinicalNotes",
	        "bloodPressure",
	        "temperature"
	    ])
		case .laboratoryResults -> $ map (result) -> (result -- [
			"technician",
			"urgency"
		])
		case .radiologyResults -> $ map (result) -> result - "radiologist"
	}
else
	vars.patientDataModel
	