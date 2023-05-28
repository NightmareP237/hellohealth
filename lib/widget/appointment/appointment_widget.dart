import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../screens/appointment/user_appointment_page.dart';
import 'make_appointment_form_widget.dart';

class AppointmentWidget extends StatefulWidget {
  final Appointment? appointment;

  const AppointmentWidget({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<AppointmentWidget> createState() => _AppointmentWidgetState();
}

class _AppointmentWidgetState extends State<AppointmentWidget> {
  final CollectionReference docAppointment =
      FirebaseFirestore.instance.collection('appointments');

  void showEditAppointment(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Material(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: MakeAppointmentFormWidget(
                  mode: 'edit',
                  appointment: widget.appointment,
                ),
              ),
            ),
          ),
        );
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${widget.appointment!.age}'),
      ),
      title: Text(
        widget.appointment!.patientname,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
          ' AppointmentDate : ${widget.appointment!.date}    Symptom: ${widget.appointment!.symptom}'),
      trailing: Wrap(
        spacing: 5, // space between two icons
        children: [
          IconButton(
              onPressed: () {
                showEditAppointment(context);
              },
              icon: Icon(Icons.edit)), // icon-1
          IconButton(
              onPressed: () {
          showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('My Appointment'),
                    content: Text('Are you sure to delete this Appointment ?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            deleteAppointment(widget.appointment!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserAppointmentPage()));
                          },
                          child: Text('Ok')),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete)), // icon-2
        ],
      ),
    );
  }

  Future deleteAppointment(Appointment appointment) async {
    if (kDebugMode) {
      print('bjr');
    }
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointment.id)
        .delete()
        .then((_) {
      print("success !");
    })
        .catchError((error) => print("Failed to delete Item: $error"));
  }
}
