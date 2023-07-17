import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Appointment {
  String uid;
  String docId;
  final String patientname;
  final String age;
  late final String time;
  final String doctorName;
  final String DoctorUid;
  final String? createAt;
  final String? updateAt;
  final String? location;
  final String? symptom;
  final String specialistof;
  final String doctorPhone;
  final String whatsappDoctorPone;


  Appointment({
    this.uid = '',
    this.docId='',
    required this.patientname,
    required this.age,
    required this.DoctorUid,
    required this.doctorName,
    required this.time,
    required this.doctorPhone,
    required this.location,
    required this.whatsappDoctorPone,
    this.createAt,
    this.updateAt,
    this.symptom,
    required this.specialistof,
  });
  static List<Appointment> fromQuerySnapshot(QuerySnapshot querySnapshot) {
    List<Appointment> appointments = [];
    for (final doc in querySnapshot.docs) {
      final appointment = Appointment(
        docId: doc.id,
        uid: doc['uid'],
        doctorPhone: doc['doctorPhone'],
        patientname: doc['patientname'],
        location: doc['location'],
        age: doc['age'],
        time: doc['time'],
        whatsappDoctorPone: doc['whatsappDoctorPone'],
        createAt: doc['createAt'],
        updateAt: doc['updateAt'],
        symptom: doc['symptom'],
        DoctorUid: doc['DoctorUid'],
        doctorName: doc['doctorName'],
        specialistof: doc['specialistof'],
      );
      appointments.add(appointment);
    }
    // end for
    return appointments;
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'patientname': patientname,
        "location":location,
        'age': age,
        'date': time,
        "whatsappDoctorPone":whatsappDoctorPone,
        'createdAt': createAt,
        'updatedAt': updateAt,
        'symptom': symptom,
        "DoctorUid": DoctorUid,
        "doctorName": doctorName,
        "specialistof": specialistof,
      };

  static Appointment fromJson(Map<String, dynamic> json) => Appointment(
    doctorPhone: json['doctorPhone'],
        uid: json['uid'],
        patientname: json['patientname'],
        age: json['age'],
        time: json['time'],
        createAt: json['createdAt'],
        location: json['location'],
        whatsappDoctorPone:json['whatsappDoctorPone'],
        updateAt: json['updatedAt'],
        symptom: json['symptom'],
        DoctorUid: json['DoctorUid'],
        doctorName: json['doctorName'],
        specialistof: json['specialistof'],
      );
}
