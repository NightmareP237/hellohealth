import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Doctor {
  String DoctorId;
  String uid;
  String? name;
  String? experience;
  String? patients;
  String? description;
  String? location;
  String? whatsapPhone;
  String? phoneNumber;
  String? videoId;
  String? specialist;
  String image;

  Doctor({
    this.uid = '',
    this.DoctorId = '',
    required this.name,
    required this.description,
    required this.experience,
    this.image = '',
    required this.location,
    required this.patients,
    required this.phoneNumber,
    required this.specialist,
    required this.videoId,
    required this.whatsapPhone,
  });

  static Doctor fromJson(Map<String, dynamic> data) => Doctor(
        description: data['description'],
        experience: data['experience'],
        location: data['location'],
        name: data['name'],
        uid: data['uid'],
        patients: data['patients'],
        specialist: data['specialist'],
        phoneNumber: data['phoneNumber'],
        videoId: data['videoId'],
        whatsapPhone: data['whatsapPhone'],
      );

  static List<Doctor> fromQuerySnapshot(QuerySnapshot querySnapshot)  {
    final firebaseStorage = FirebaseStorage.instance;
    List<Doctor> doctors = [];
    for (final doc in querySnapshot.docs) {
      final doctor = Doctor(
          DoctorId: doc.id,
          description: doc['description'],
          experience: doc['experience'],
          uid: doc['uid'],
          location: doc['location'],
          name: doc['name'],
          patients: doc['patients'],
          specialist: doc['specialist'],
          phoneNumber: doc['phoneNumber'],
          videoId: doc['videoId'],
          whatsapPhone: doc['whatsapPhone'],
          image: doc['image']
          );
      doctors.add(doctor);
    }
    // end for
    return doctors;
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "experience": experience,
        "patients": patients,
        "description": description,
        "location": location,
        "whatsapPhone": whatsapPhone,
        "phoneNumber": phoneNumber,
        "videoId": videoId,
        'specialist': specialist,
        "uid": uid
      };
}
