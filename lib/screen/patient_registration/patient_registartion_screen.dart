import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_management_app/data/api/api_repository.dart';
import 'package:patient_management_app/model/branch.dart';
import 'package:patient_management_app/model/patient_dtl.dart';
import 'package:patient_management_app/screen/patient_registration/add_treatment_dialogue.dart';

import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController advance = TextEditingController();
  TextEditingController balance = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController hour = TextEditingController();
  TextEditingController minutes = TextEditingController();
  String? _paymentMethod;
  String? _selectedItem;
  String? _selectedBranch;
  int? _selectedHr;
  int? _selectedMinute;
  DateTime? _selectedDate;
  List<Branch> branchList = [];
  Branch? branchData;
  List<int> hours = [];
  List<int> minute = [];
  List<PatientDetail> dtlList = [];

  @override
  void initState() {
    hours = List.generate(24, (index) => index);
    minute = List.generate(60, (index) => index);
    getBranch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  Icon(
                    Icons.notifications_none,
                    size: 30,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                  )),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Name",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "Enter your Name",
                      controller: name,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Whatsapp Number",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "Enter your Whatsapp Number",
                      controller: number,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Address",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "Enter your full Address",
                      controller: address,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Location",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField<String>(
                      iconSize: 0.0,
                      value: _selectedItem,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue;
                        });
                      },
                      items: <String>[
                        'Option 1',
                        'Option 2',
                        'Option 3',
                        'Option 4'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Choose your Location',
                        labelStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
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
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Branch",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField<String>(
                      iconSize: 0.0,
                      value: _selectedBranch,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBranch = newValue;
                        });
                      },
                      items: branchList.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.name,
                          child: Text(value.name),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Choose your Branch',
                        labelStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
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
                    ),
                  ),
                  if (dtlList.isNotEmpty)
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: dtlList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            ' ${index + 1}.  ',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          dtlList[index]
                                              .treatmentName
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Male",
                                              style: TextStyle(
                                                  color: Color(0xff05690e)),
                                            ),
                                            const SizedBox(width: 5),
                                            Container(
                                              height: 40,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  dtlList[index].male,
                                                  style: const TextStyle(
                                                      color: Color(0xff05690e)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            const Text(
                                              "Female",
                                              style: TextStyle(
                                                  color: Color(0xff05690e)),
                                            ),
                                            const SizedBox(width: 5),
                                            Container(
                                              height: 40,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  dtlList[index].female,
                                                  style: const TextStyle(
                                                      color: Color(0xff05690e)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Container(
                      height: 52,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Text(
                        "+ Add Treatments",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                    ),
                    onTap: () async {
                      PatientDetail patientDtl = await showDialog(
                          context: context,
                          builder: (context) {
                            return const AddTreatmentDialogue();
                          });

                      setState(() {
                        dtlList.add(patientDtl);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Total Amount",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "",
                      controller: total,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Discount Amount",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "",
                      controller: discount,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: 'Card',
                        groupValue: _paymentMethod,
                        onChanged: (String? value) {
                          setState(() {
                            _paymentMethod = value;
                          });
                        },
                      ),
                      const Text('Card'),
                      Radio<String>(
                        value: 'Cash',
                        groupValue: _paymentMethod,
                        onChanged: (String? value) {
                          setState(() {
                            _paymentMethod = value;
                          });
                        },
                      ),
                      const Text('Cash'),
                      Radio<String>(
                        value: 'UPI',
                        groupValue: _paymentMethod,
                        onChanged: (String? value) {
                          setState(() {
                            _paymentMethod = value;
                          });
                        },
                      ),
                      const Text('UPI'),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Advance Amount",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "",
                      controller: advance,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Balance Amount",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "",
                      controller: balance,
                      textInputType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Treatment Date",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 65,
                    child: CustomTextFormField(
                      filled: true,
                      hintText: "",
                      controller: date,
                      icon: const Icon(
                        Icons.date_range,
                        color: Colors.green,
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Treatment Time",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: DropdownButtonFormField<int>(
                            iconSize: 0.0,
                            value: _selectedHr,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedHr = newValue;
                              });
                            },
                            items: hours.map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Hour',
                              labelStyle: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 12),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Colors.green),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 0,
                                      style: BorderStyle.solid),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 0,
                                      style: BorderStyle.solid),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: DropdownButtonFormField<int>(
                            iconSize: 0.0,
                            value: _selectedMinute,
                            onChanged: (int? newValue) {
                              setState(() {
                                _selectedMinute = newValue;
                              });
                            },
                            items: minute.map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: 'Minutes',
                              labelStyle: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 12),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              suffixIcon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.green,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 0,
                                      style: BorderStyle.solid),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 0,
                                      style: BorderStyle.solid),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      int index = branchList.indexWhere(
                          (element) => element.name == _selectedBranch);
                      if (index > -1) {
                        setState(() {
                          branchData = branchList[index];
                        });
                      }
                      ApiRepository().register(
                          name.text,
                          number.text,
                          address.text,
                          location.text,
                          total.text.toString(),
                          discount.text.toString(),
                          _paymentMethod.toString(),
                          advance.text.toString(),
                          balance.text.toString(),
                          _selectedDate ?? DateTime.now(),
                          hour.text,
                          minutes.text,
                          dtlList,
                          branchData!);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getBranch() async {
    branchList = await ApiRepository().fetchBranchList();
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        date.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }
}
