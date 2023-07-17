// import 'package:flutter/material.dart';
// import '../../widget/appointment/make_appointment_form_widget.dart';

// class MakeAppointmentPage extends StatefulWidget {
//   const MakeAppointmentPage({Key? key}) : super(key: key);

//   @override
//   State<MakeAppointmentPage> createState() => _MakeAppointmentPageState();
// }

// class _MakeAppointmentPageState extends State<MakeAppointmentPage> {
//   final controller = TextEditingController();

//   get symptom => null;

//   get date => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Take Appointment'),
//    /*     actions: [
//           IconButton(
//               onPressed: () {
//                 final patientname = controller.text;
//                 createPatient(patientname: patientname);
//               },
//               icon: Icon(Icons.add),
//           ),
//         ],*/
//       ),
//       body: const MakeAppointmentFormWidget(mode: 'create'),
//     );
//   }

// /*  Future createPatient({required String patientname}) async {
//     final docPatient = FirebaseFirestore.instance.collection('patients').doc();
//   final patient = Patient(
//     id: docPatient.id,
//       patientname: patientname,
//       age: 21,
//       //date: date,
//     createdAt: DateTime.now(),
//     symptom: symptom,
//   );
//   final json = patient.toJson();
//   await docPatient.set(json);
//   }*/
// }
