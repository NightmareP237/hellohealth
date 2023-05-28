import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellohealth/widget/login/login_form_widget.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'loginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginFormWidget(),
    );
  }
}
