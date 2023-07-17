
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hellohealth/widget/appointment/appointment_widget.dart';
// import '../../models/Appointment.dart';
// import 'make_appointment_page.dart';

// class UserAppointmentPage extends StatelessWidget {
//   //const UserAppointmentPage({Key? key}) : super(key: key);

//   get symptom => symptom;

//   get date => date;

// final TextEditingController _patientnameController = TextEditingController();
// final TextEditingController _dateappointmentController = TextEditingController();

//   get ctx => ctx;

// /*
//   Future<void> _deleteAppointments(String id) async {
//     await docAppointment.doc(id).delete();

//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('You have successfully deleted this appointment !')));
//   }

//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {

//     if (documentSnapshot != null) {

//       controllerPatientName.text = documentSnapshot['name'];
//       controllerAge.text = documentSnapshot['age'].toString();
//       dateInput.text = documentSnapshot['date'];

//     }
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 // prevent the soft keyboard from covering text fields
//                 bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: controllerPatientName,
//                   decoration: decoration('PatientName'),
//                 ),
//                 SizedBox(height: 24,),
//                 TextField(
//                   controller: controllerAge,
//                   decoration: decoration('Age'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 24,),
//                 Column(
//                   children: [
//                     Text('Symptoms? '),
//                     DropdownButton(
//                       value: dropdownvalue,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       items: items.map((items) {
//                         return DropdownMenuItem(
//                             value: items, child: Text(items));
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           dropdownvalue = newValue;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24,),
//                 TextField(
//                   controller: dateInput,
//                   //editing controller of this TextField
//                   decoration: InputDecoration(
//                       icon: Icon(
//                         Icons.calendar_today,
//                         color: Colors.orange,
//                       ),
//                       //icon of text field
//                       labelText: "Enter Date" //label text of field
//                   ),
//                   readOnly: true,
//                   onTap: () async {
//                     var today = new DateTime.now();
//                     var fiftyDaysFromNow = today.add(new Duration(days: 3));
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(1950),
//                       lastDate: DateTime(2100),
//                     );
//                     if (pickedDate != null && pickedDate.isAfter(today) && pickedDate.isBefore(fiftyDaysFromNow)) {
//                       print(
//                           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                       String formattedDate =
//                       DateFormat('yyyy-MM-dd').format(pickedDate);
//                       print(
//                           formattedDate); //formatted date output using intl package =>  2021-03-16
//                       setState(() {
//                         dateInput.text =
//                             formattedDate; //set output date to TextField value.
//                       });
//                     } else {

//                     }
//                   },
//                 ),
//                 ElevatedButton(
//                   child: Text( 'Update'),
//                   onPressed: () async {
//                     final String? name = controllerPatientName.text;
//                     final int? age = int.parse(controllerAge.text);
//                     final String? date  = dateInput.text ;
//                     final DateTime  createdAt = DateTime.now();
//                     final String? symptom = dropdownvalue.toString();

//                     if (name != null && age != null && date != null && createdAt != null && symptom != null) {


//                         // Update the appointment
//                         await docAppointment
//                             .doc(documentSnapshot!.id)
//                             .update({"patientname": name, "age": age , "date": date, "createdAt": createdAt,"symptom": symptom,});


//                       // Clear the text fields
//                       controllerPatientName.text = '';
//                       controllerAge.text = '';
//                       dateInput.text = '';
//                       dropdownvalue.toString();

//                       // Hide the bottom sheet
//                       Navigator.of(context).pop();
//                     }
//                   },
//                 )
//               ],
//             ),
//           );
//         });
//   }*/


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Appointments'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => MakeAppointmentPage()));
//         },
//       ),
//       body: FutureBuilder<List<Appointment>>(
//         future: readAppointments().first,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong! ${snapshot.error}');
//           }
//       /*   else if (snapshot.hasData) {
//          final appointment = snapshot.data;
//          return appointment == null ? Center(
//            child: Text('No User !')
//          ) : buildAppointment(appointment);

//           }
//           else {
//             return Text('Something went wrong! ${snapshot.error}');
//           }*/
//          else if (snapshot.hasData){
//             final appointments = snapshot.data!;
//             return ListView.builder(
//               itemCount: appointments.length,
//               itemBuilder: (context,index) {
//                 return AppointmentWidget(key: ValueKey(appointments.elementAt(index)), appointment: appointments.elementAt(index));
//               },
//             );
//           }
//             else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),

//     );

//   }

//   Stream<List<Appointment>> readAppointments() {
//    // User fUser =  FirebaseAuth.instance.currentUser!;
//   return  FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('appointments')
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => Appointment.fromJson(doc.data()))
//             .toList());
//   }

//   Future<Appointment?> readAppointment() async {
//     final docAppointment = FirebaseFirestore.instance.collection('appointments').doc();
//     final snapshot = await docAppointment.get();
//     if(snapshot.exists) {
//       return Appointment.fromJson(snapshot.data()!);
//     }
//   }



// /*
//   Future createAppointment({required String patientname}) async {
//     final  docAppointment = FirebaseFirestore.instance.collection('appointments').doc('MliTHIIDij8zcEt3sH4f');

//     final appointment = Appointment(
//       id: docAppointment.id,
//       patientname: patientname,
//       age: 21,
//       date: date,
//       createdAt: DateTime.now(),
//       symptom: symptom,
//     );

//     final json = appointment.toJson();
//     await docAppointment.set(json);
//   }*/
// }
