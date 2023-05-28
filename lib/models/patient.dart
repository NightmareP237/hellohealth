import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String id;
  final String patientname;
  final int age;
  final String date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? symptom;
//  final String userId;

  Appointment({
    this.id = '',
    required this.patientname,
    required this.age,
    required this.date,
    this.createdAt,
    this.updatedAt,
    this.symptom,
  // required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientname': patientname,
        'age': age,
        'date': date,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'symptom': symptom,
   // 'userId': userId,
      };

  static Appointment fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        patientname: json['patientname'],
        age: json['age'],
        date: json['date'],
        createdAt: json['createdAt'] != null ? (json['createdAt'] as Timestamp).toDate() : null,
        updatedAt: json['updatedAt'] != null ? (json['updatedAt'] as Timestamp).toDate() :  null,
        symptom: json['symptom'],
    //userId: json['userId'],
      );
}
