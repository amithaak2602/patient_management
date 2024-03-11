
class PatientDetail {
  int id;
  String male;
  String female;
  int patient;
  int treatment;
  String treatmentName;

  PatientDetail({
    required this.id,
    required this.male,
    required this.female,
    required this.patient,
    required this.treatment,
    required this.treatmentName,
  });

  PatientDetail copyWith({
    int? id,
    String? male,
    String? female,
    int? patient,
    int? treatment,
    String? treatmentName,
  }) =>
      PatientDetail(
        id: id ?? this.id,
        male: male ?? this.male,
        female: female ?? this.female,
        patient: patient ?? this.patient,
        treatment: treatment ?? this.treatment,
        treatmentName: treatmentName ?? this.treatmentName,
      );

  factory PatientDetail.fromJson(Map<String, dynamic> json) => PatientDetail(
    id: json["id"],
    male: json["male"],
    female: json["female"],
    patient: json["patient"],
    treatment: json["treatment"],
    treatmentName: json["treatment_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "male": male,
    "female": female,
    "patient": patient,
    "treatment": treatment,
    "treatment_name": treatmentName,
  };
}