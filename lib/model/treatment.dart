import 'dart:convert';
import 'package:patient_management_app/model/branch.dart';

class Treatment {
  int id;
  List<Branch> branchList;

  String name;
  String duration;

  double price;

  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  Treatment({
    required this.id,
    required this.branchList,
    required this.duration,
    required this.name,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    id: json["id"],
    branchList:
    List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
    name: json["name"],
    duration: json["duration"],
    price: double.parse(json["price"]),
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
  static Treatment fromString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Treatment.fromJson(json);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch": List<dynamic>.from(branchList.map((x) => x.toJson())),
    "name": name,
    "duration": duration,
    "price": price,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
