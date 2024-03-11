import 'dart:convert';

import 'package:patient_management_app/model/branch.dart';
import 'package:patient_management_app/model/patient_dtl.dart';

List<Patient> patientFromJson(String str) =>
    List<Patient>.from(json.decode(str).map((x) => Patient.fromJson(x)));

String patientToJson(List<Patient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patient {
  int id;
  List<PatientDetail> patientdetailsSet;
  Branch branch;
  String user;
  String payment;
  String name;
  String phone;
  String address;
  double price;
  double totalAmount;
  double discountAmount;
  double advanceAmount;
  double balanceAmount;
  DateTime dateNdTime;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;

  Patient({
    required this.id,
    required this.patientdetailsSet,
    required this.branch,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    required this.price,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateNdTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  // Welcome copyWith({
  //   int? id,
  //   List<Patientdetail>? patientdetailsSet,
  //   Branch? branch,
  //   String? user,
  //   String? payment,
  //   String? name,
  //   String? phone,
  //   String? address,
  //   dynamic price,
  //   int? totalAmount,
  //   int? discountAmount,
  //   int? advanceAmount,
  //   int? balanceAmount,
  //   DateTime? dateNdTime,
  //   bool? isActive,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) =>
  //     Welcome(
  //       id: id ?? this.id,
  //       patientdetailsSet: patientdetailsSet ?? this.patientdetailsSet,
  //       branch: branch ?? this.branch,
  //       user: user ?? this.user,
  //       payment: payment ?? this.payment,
  //       name: name ?? this.name,
  //       phone: phone ?? this.phone,
  //       address: address ?? this.address,
  //       price: price ?? this.price,
  //       totalAmount: totalAmount ?? this.totalAmount,
  //       discountAmount: discountAmount ?? this.discountAmount,
  //       advanceAmount: advanceAmount ?? this.advanceAmount,
  //       balanceAmount: balanceAmount ?? this.balanceAmount,
  //       dateNdTime: dateNdTime ?? this.dateNdTime,
  //       isActive: isActive ?? this.isActive,
  //       createdAt: createdAt ?? this.createdAt,
  //       updatedAt: updatedAt ?? this.updatedAt,
  //     );

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["id"],
        patientdetailsSet: List<PatientDetail>.from(
            json["patientdetails_set"].map((x) => PatientDetail.fromJson(x))),
        branch: Branch.fromJson(json["branch"]),
        user: json["user"]??"",
        payment: json["payment"]??"",
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        price: json["price"] ?? 0,
        totalAmount: json["total_amount"],
        discountAmount: json["discount_amount"],
        advanceAmount: double.parse(json["advance_amount"]),
        balanceAmount: json["balance_amount"],
        dateNdTime: DateTime.parse(json["date_nd_time"]),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientdetails_set":
            List<dynamic>.from(patientdetailsSet.map((x) => x.toJson())),
        "branch": branch.toJson(),
        "user": user,
        "payment": payment,
        "name": name,
        "phone": phone,
        "address": address,
        "price": price,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "advance_amount": advanceAmount,
        "balance_amount": balanceAmount,
        "date_nd_time": dateNdTime.toIso8601String(),
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
