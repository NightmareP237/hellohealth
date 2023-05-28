import 'package:flutter/material.dart';
import 'package:hellohealth/widget/register/register_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

/*  void _submitRegister(
    String username,
    String email,
    String password,
    String confirmpassword,
    bool isRegister,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState( () {
        _isLoading = true;
      });
      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'username': username,
        'email': email,
      });
    } on PlatformException catch (err) {
      var message = 'An error occured, please check your credentials !';
      if (err.message != null) {
        message = err.message!;
      }

      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState( () {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState( () {
        _isLoading = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterFormWidget(),
    );
  }
}
