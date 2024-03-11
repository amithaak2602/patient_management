import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:patient_management_app/data/api/api_repository.dart';
import 'package:patient_management_app/model/patient_dtl.dart';
import 'package:patient_management_app/model/treatment.dart';
import 'package:patient_management_app/widget/custom_button.dart';

class AddTreatmentDialogue extends StatefulWidget {
  const AddTreatmentDialogue({
    super.key,
  });

  @override
  State<AddTreatmentDialogue> createState() => _AddTreatmentDialogueState();
}

class _AddTreatmentDialogueState extends State<AddTreatmentDialogue> {
  String? _selectedTreatment;
  List<Treatment> treatmentList = [];
  int maleCount = 0;
  int femaleCount = 0;
  @override
  void initState() {
    getTreatment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        width: width,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Choose Treatment",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              if (treatmentList.isNotEmpty)
                SizedBox(
                    height: 50,
                    child: DropdownButtonFormField<String>(
                      iconSize: 0.0,
                      value: _selectedTreatment,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTreatment = newValue;
                        });
                      },
                      padding: EdgeInsets.zero,
                      items: treatmentList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.name,
                          child: Text(
                            value.name,
                            overflow: TextOverflow.fade,
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Choose Preferred Treatment',
                        labelStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        // suffixIcon: Padding(
                        //   padding: const EdgeInsets.all(0),
                        //   child: const Icon(Icons.keyboard_arrow_down_sharp),
                        // ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 0,
                                style: BorderStyle.solid),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade400,
                                width: 0,
                                style: BorderStyle.solid),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                      ),
                    )),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Add Patients",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              customSelection("Male", () {
                setState(() {
                  maleCount++;
                });
              }, () {
                setState(() {
                  maleCount--;
                });
              }, maleCount.toString()),
              const SizedBox(
                height: 20,
              ),
              customSelection("Female", () {
                setState(() {
                  femaleCount++;
                });
              }, () {
                setState(() {
                  femaleCount--;
                });
              }, femaleCount.toString()),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                child: Text(
                  "Save",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  int index = treatmentList.indexWhere(
                      (element) => element.name == _selectedTreatment);

                  PatientDetail patientDtl = PatientDetail(
                      id: 0,
                      male: maleCount.toString(),
                      female: femaleCount.toString(),
                      patient: 0,
                      treatment: treatmentList[index].id,
                      treatmentName: _selectedTreatment ?? "");
                  Navigator.pop(context, patientDtl);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSelection(String title, void Function() onTapIncrement,
      void Function() onTapDecrement, String? count) {
    return Row(
      children: [
        Container(
          height: 46,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(child: Text(title)),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: onTapIncrement,
            child: const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xff05690e),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(count ?? ""),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InkWell(
            onTap: onTapDecrement,
            child: const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xff05690e),
                child: Center(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
      ],
    );
  }

  void getTreatment() async {
    treatmentList = await ApiRepository().fetchTreatmentList();
    setState(() {});
  }
}
