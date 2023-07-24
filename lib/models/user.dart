import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String? imagePath;
  String? name;
  String phone;
  String? password;
  String? role;
  String? about;
  String? updatedAt;
  String? createdAt;
  bool? isDarkMode;
  String? iscall;

  User({
    required this.id,
    this.imagePath,
    required this.name,
    required this.createdAt,
    required this.phone,
    this.updatedAt,
    this.password,
    required this.role,
    this.about,
    this.isDarkMode,
  });

  User copy({
    String? id,
    String? imagePath,
    String? name,
    String? phone,
    String? password,
    String? about,
    String? updatedAt,
    String? createdAt,
    String? role,
    bool? isDarkTheme,
  }) =>
      User(
          id: id ?? this.id,
          imagePath: imagePath ?? this.imagePath,
          name: name ?? this.name,
          phone: phone ?? this.phone,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          password: password ?? this.password,
          about: about ?? this.about,
          isDarkMode: isDarkTheme ?? isDarkMode,
          role: role ?? this.role);

  static User fromJson(Map<String, dynamic> json) => User(
        role: json['role'],
        id: json['id'],
        imagePath: json['imagePath'] ?? '',
        name: json['name'],
        phone: json['phone'],
        password: json['password'],
        about: json['about'] ?? '',
        createdAt: json['createdAt'] != null ? (json['createdAt']) : '',
        updatedAt: json['updatedAt'] != null ? (json['updatedAt']) : '',
        isDarkMode: json['isDarkMode'] ?? false,
      );
  static User fromDocumentSnapshot(DocumentSnapshot doc) {
    // final firebaseStorage = FirebaseStorage.instance;
    // List<Doctor> doctors = [];
    // for (final doc in querySnapshot.docs) {
    final user = User(
      role: doc['role'],
      id: doc['id'],
      imagePath: doc['imagePath'] ?? '',
      name: doc['name'],
      phone: doc['phone'],
      password: doc['password'],
      about: doc['about'] ?? '',
      createdAt: doc['createdAt'] != null ? (doc['createdAt']) : '',
      updatedAt: doc['updatedAt'] != null ? (doc['updatedAt']) : '',
      isDarkMode: doc['isDarkMode'] ?? false,
    );
    // doctors.add(doctor);
    // }
    // end for
    return user;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'name': name,
        'phone': phone,
        'password': password,
        'about': about,
        'createdAt': DateTime.now().toString(),
        "role": role,
        'updatedAt': updatedAt,
        'isDarkMode': isDarkMode,
      };
}
