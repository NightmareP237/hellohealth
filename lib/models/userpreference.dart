import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hellohealth/models/user.dart' as model;

class UserPreference {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static  model.User myUser = model.User(
    id: '',
      imagePath: '',
      name: 'aina petula',
      email: 'ainapetula@gmail.com',
      about: 'dev mobile et web',
      password: '',
      isDarkMode: false,
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(model.User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static Object getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser: model.User.fromJson(jsonDecode(json));
  }
}
