import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:models/user.dart' as model;
import 'package:hellohealth/models/user.dart' as model;


class Response {
  int? code;
  String? message;

  Response({this.code, this.message});
}

class AuthProvider with ChangeNotifier {
  model.User? _authUser;

  model.User? get authUser => _authUser;

  AuthProvider();

  bool get isAuthenticated {
    return authUser != null;
  }

  /*set authUser(  model.User? value) {
  _authUser  = value as model.User?;
  }*/

  FirebaseAuth authInstance = FirebaseAuth.instance;

  // Our Function will take email,password, username and buildcontext
  Future<void> register(String email, String password, String name) async {
    print("enter new user-----------------.$email $name $password");
    // Get back usercredential future from createUserWithEmailAndPassword method
    UserCredential userCred = await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Save username name
    await userCred.user!.updateDisplayName(name);
    await userCred.user!.sendEmailVerification();

    await login(email, password);
    await createUser(_authUser!);
    // notify listeneres
    notifyListeners();
  }

  Future createUser(model.User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    authUser?.id = docUser.id;
    final json = authUser?.toJson();
    print('-----------------------------------------------------------');
    print(json);
    print('-----------------------------------------------------------');
    await docUser.set(json!);

    notifyListeners();
  }

  Future<void> updateUser(model.User user) async {
    print(user.toJson());
    Response response = Response();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update((user.toJson()))
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated user";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    if (response.code != 200) {
      print(response.message);
    } else {
      _authUser = model.User(
        id: user.id,
        imagePath: user.imagePath ?? '',
        name: user.name,
        email: user.email,
        about: user.about ?? '',
      );

      notifyListeners();
    }
  }

  // Our Function will take email, password and build context

  Future<void> login(String email, String password) async {
    UserCredential userCred = await authInstance.signInWithEmailAndPassword(
        email: email, password: password);

    if (userCred.user != null) {
      _authUser = model.User(
        id: userCred.user!.uid,
        imagePath: userCred.user?.photoURL,
        name: userCred.user?.displayName,
        //
        email: userCred.user!.email!,
        password: password,
      );
    }

    // notify the listeners.
    notifyListeners();
  }

  void logOut() async {
    await authInstance.signOut();
    notifyListeners();
  }
}
