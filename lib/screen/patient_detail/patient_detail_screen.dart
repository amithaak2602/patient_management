import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:patient_management_app/data/api/api_repository.dart';
import 'package:patient_management_app/model/patient.dart';
import 'package:patient_management_app/model/patient_dtl.dart';
import 'package:patient_management_app/screen/patient_registration/patient_registartion_screen.dart';
import 'package:patient_management_app/widget/custom_button.dart';

class PatientDetailScreen extends StatefulWidget {
  const PatientDetailScreen({Key? key}) : super(key: key);

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  PatientDetail? patientDetail;
  List<Patient> patientList = [];
  bool isLoad = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                Container(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.arrow_back),
                    Icon(
                      Icons.notifications_none,
                      size: 30,
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                        width: 100.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          color: const Color(0xff05690e),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                            child: Text('Search',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white)))),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sort by :',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Container(
                      width: 160,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          hint: const Text('Date'),
                          isExpanded: true,
                          underline: const SizedBox(), // Remove underline
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: <String>[
                            'Option 1',
                            'Option 2',
                            'Option 3',
                            'Option 4'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // Handle dropdown value change
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: ApiRepository().fetchPatientData(),
              initialData: [],
              builder: (BuildContext context, snapshot) {
                final list = snapshot.data ?? [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff05690e),
                    ),
                  );
                }
                return Expanded(
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    list.isEmpty
                        ? const Center(child: Text("No data"))
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return customCard(list[index], index);
                            }),
                    Positioned(
                      bottom: 18,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomButton(
                          child: Text(
                            "Register",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RegisterScreen();
                            }));
                          },
                        ),
                      ),
                    )
                  ]),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget customCard(Patient patient, int count) {
  String formattedDate = DateFormat('dd/MM/yyyy').format(patient.dateNdTime);
  return Container(
    height: 190,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey.withOpacity(0.1)),
    child: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 4.0, right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          ' ${count + 1}.  ',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        )),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          patient.name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    patient.patientdetailsSet.map((patientDtl) {
                                  return Text(
                                    patientDtl.treatmentName,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.green),
                                  );
                                }).toList()),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_sharp,
                              color: Colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(formattedDate),
                            const SizedBox(width: 20),
                            const Icon(
                              Icons.group,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(patient.user),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.only(left: 45, right: 10, top: 0, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'View Booking details',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0,
                    fontSize: 18),
              ),

              Icon(
                Icons.arrow_forward_ios,
                color: Colors.green,
              ), // Trailing icon
            ],
          ),
        ),
      ],
    ),
  );
}
