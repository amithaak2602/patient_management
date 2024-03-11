import 'package:patient_management_app/data/api/api.dart';
import 'package:patient_management_app/model/branch.dart';
import 'package:patient_management_app/model/patient.dart';
import 'package:patient_management_app/model/patient_dtl.dart';
import 'package:patient_management_app/model/treatment.dart';

class ApiRepository {
  Future<List<Patient>> fetchPatientData() async {
    var data = await Api().get('PatientList');
    if (data['status'] = true && data.containsKey('patient')) {
      List list = data['patient'];
      print(list);
      final patient = List<Patient>.from(list.map((x) => Patient.fromJson(x)));
      return patient;
    } else {
      return [];
    }
  }

  Future<List<Branch>> fetchBranchList() async {
    var data = await Api().get('BranchList');
    if (data['status'] = true && data.containsKey('branches')) {
      List list = data['branches'];
      final branchList = List<Branch>.from(list.map((x) => Branch.fromJson(x)));
      return branchList;
    } else {
      return [];
    }
  }

  Future<List<Treatment>> fetchTreatmentList() async {
    var data = await Api().get('TreatmentList');
    if (data['status'] = true && data.containsKey('treatments')) {
      List list = data['treatments'];
      final treatmentList =
          List<Treatment>.from(list.map((x) => Treatment.fromJson(x)));

      return treatmentList;
    } else {
      return [];
    }
  }

  Future register(
      String name,
      number,
      address,
      location,
      total,
      discount,
      selected,
      advance,
      balance,
      DateTime date,
      hour,
      minute,
      List<PatientDetail> dtlList,
      Branch branch) async {
    Map<String, dynamic> data = {};
    dtlList.forEach((element) {
      data = {
        'name': name,
        'executive': 'Jane Smith',
        'payment': selected,
        'phone': number,
        'address': address,
        'total_amount': total,
        'discount_amount': discount,
        'advance_amount': advance,
        'balance_amount': balance,
        'date_nd_time': DateTime.now().toString(),
        'id': '',
        'male': '${element.treatment},',
        'female': '${element.treatment},',
        'branch': branch.toJson(),
        'treatments': '${element.treatment},',
      };
    });

    final res = await Api().postRegister(data);
    print(res);
  }
}
