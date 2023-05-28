class User {
  String id;
  String? imagePath;
  String? name;
  String email;
  String? password;
  String? about;
  bool? isDarkMode;

  User({
    required this.id,
    this.imagePath,
     this.name,
    required this.email,
    this.password,
    this.about,
    this.isDarkMode,
  });

User copy({
    String? id,
    String? imagePath,
    String? name,
    String? email,
    String? password,
    String? about,

    bool? isDarkTheme,
  }) =>
      User(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        about: about ?? this.about,
        isDarkMode: isDarkTheme ?? isDarkMode,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        imagePath: json['imagePath'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        about: json['about'],
        /*  createdAt: json['createdAt'] != null
            ? (json['createdAt'] as Timestamp).toDate()
            : null,
        updatedAt: json['updatedAt'] != null
            ? (json['updatedAt'] as Timestamp).toDate()
            : null,*/
        isDarkMode: json['isDarkMode'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imagePath': imagePath,
        'name': name,
        'email': email,
        'password': password,
        'about': about,
        /* 'createdAt': createdAt,
        'updatedAt': updatedAt,*/
        'isDarkMode': isDarkMode,
      };
}
