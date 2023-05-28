import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/patient.dart';
import '../../models/user.dart';
import '../../screens/appointment/user_appointment_page.dart';

class MakeAppointmentFormWidget extends StatefulWidget {
  final String mode;
  final Appointment? appointment;

  const MakeAppointmentFormWidget(
      {Key? key, this.mode = 'create', this.appointment})
      : super(key: key);

  @override
  State<MakeAppointmentFormWidget> createState() =>
      _MakeAppointmentFormWidgetState();
}

class _MakeAppointmentFormWidgetState extends State<MakeAppointmentFormWidget> {
  final dateInput = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerPatientName = TextEditingController();

  @override
  void initState() {
    if (widget.mode == 'create') {
      dateInput.text = ""; //set the initial value of text field
    }

    if (widget.mode == 'edit' && widget.appointment != null) {
      controllerPatientName.text = widget.appointment!.patientname;
      controllerAge.text = widget.appointment!.age.toString();
      dateInput.text = widget.appointment!.date.toString();
    }

    super.initState();
  }

  String? dropdownvalue = 'Pains'; // les symptomes du patient
  var items = [
    'Pains',
    'Great fatigue',
    'Yellowing of the eyes and skin',
    'Darker urine',
    'Nausea and vomiting',
    'Diarrhoea'
        'Discomfort',
    'Loss of appetite',
    'Sleep disturbances',
    'Fever and diffuse pain',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          padding: EdgeInsets.all(16),
          physics: BouncingScrollPhysics(),
          children: [
            TextField(
              controller: controllerPatientName,
              decoration: decoration('PatientName'),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: controllerAge,
              decoration: decoration('Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 24,
            ),
            if (widget.mode == 'create')
              Column(
                children: [
                  Text('Symptoms? '),
                  DropdownButton(
                    value: dropdownvalue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: items.map((items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue;
                      });
                    },
                  ),
                ],
              ),
            SizedBox(
              height: 24,
            ),
            TextField(
              controller: dateInput,
              //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.orange,
                  ),
                  //icon of text field
                  labelText: "Enter Date" //label text of field
                  ),
              readOnly: true,
              onTap: () async {
                var today = new DateTime.now();
                var fiftyDaysFromNow = today.add(new Duration(days: 3));
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null &&
                    pickedDate.isAfter(today) &&
                    pickedDate.isBefore(fiftyDaysFromNow)) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final appointment = widget.mode == 'create'
                    ? Appointment(
                        patientname: controllerPatientName.text,
                        age: int.parse(controllerAge.text),
                        date: dateInput.text,
                        createdAt: DateTime.now(),
                        symptom: dropdownvalue.toString(),
                      )
                    : Appointment(
                        id: widget.appointment!.id,
                        patientname: controllerPatientName.text,
                        age: int.parse(controllerAge.text),
                        date: dateInput.text,
                        createdAt: widget.appointment?.createdAt,
                        symptom: widget.appointment?.symptom,
                        updatedAt: DateTime.now(),
                      );

                if (widget.mode == 'create') {
                  await createAppointment(appointment);

                }

                if (widget.mode == 'edit') {
                  await updateAppointment(appointment);
                }

                if (!mounted) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserAppointmentPage()));
              },
              child: Text(widget.mode == 'create' ? 'Save' : 'Update'),
            ),
          ],
        ),
      );

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      );

  Future createAppointment(Appointment appointment) async {
    final docAppointment =
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid).collection('appointments').doc();
    appointment.id = docAppointment.id;
    //appointment.id =  FirebaseFirestore.instance.collection('appointments').doc().id;
    final json = appointment.toJson();
    print('-----------------------------------------------------------');
    print(json);
    print('-----------------------------------------------------------');
    await docAppointment.set(json);
  }

  Stream<List<Appointment>> readAppointments() {
   // User fUser =  FirebaseAuth.instance.currentUser!;
    return  FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointments')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Appointment.fromJson(doc.data()))
        .toList());
  }

  Future updateAppointment(Appointment appointment) async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointment.id)
        .update(appointment.toJson());
  }
}
