import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> get user async {
    final user = auth.currentUser;
    return user;
  }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await sendEmailVerification(context);
      return true;
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return false;
      }
      return false;
      // showSnackBar(
      //     context, e.message!); // Displaying the usual firebase error message
    }
  }

  Future<bool> signIn(String email, String pass) async {
    // var result;
    // if (kIsWeb) {
    //   print('Login web environnement');
    //   await auth.setPersistence(Persistence.SESSION).then(
    //       (value) async => {
    //             result = await auth.signInWithEmailAndPassword(
    //                 email: email, password: pass),
    //                 print("Done Set Session")
    //           });
    //   if (result.user != null) {
    //     // await FirebaseAuth.instance.currentUser!.reload();
    //     return true;
    //   }
    //   return false;
    //   // );
    // } else {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (result.user != null) {
        await FirebaseAuth.instance.currentUser!.reload();
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      // log(e.toString());
      return false;
    }
    // }
  }

  Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<bool> signAnonymous() async {
    try {
      await auth.signInAnonymously();
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      auth.currentUser!.sendEmailVerification();
      // showSnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      // showSnackBar(context, e.message!); // Display error message
    }
  }
}
