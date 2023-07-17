import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

var email = false, phone = false;

class _ForgotPassPageState extends State<ForgotPassPage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  static String routeName = 'forgot-password';

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              CustomAppBar(
                  label: 'Reset Password', context: context, iconback: true),
              Padding(
                padding: EdgeInsets.only(top: redimh(context) / 12),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 4,
                          offset: Offset(-2, 10),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lotties/forgot.json',width: 200,height: 200,filterQuality: FilterQuality.high),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Choose Email or Phone Number to\n reset your password',
                            textAlign: TextAlign.center,
                            style: bodyBoldStyle(primaryMain),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RoundCheckBox(
                                isChecked: phone,
                                size: 25,
                                onTap: (selected) {
                                  setState(() {
                                    phone = selected!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Ionicons.call,
                                color: primaryMain,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Phone Number',
                                style: NameStyle(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RoundCheckBox(
                                isChecked: email,
                                size: 25,
                                onTap: (selected) {
                                  setState(() {
                                    email = selected!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Ionicons.mail,
                                color: primaryMain,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Adress Email',
                                style: NameStyle(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: phone
                                ? TextInputType.phone
                                : TextInputType.emailAddress,
                            controller: emailController,
                            cursorColor: primaryMain,
                            textInputAction: phone
                                ? TextInputAction.done
                                : TextInputAction.none,
                            decoration: InputDecoration(
                                labelText:
                                    ((phone == false && email == false) ||
                                            (phone == true && email == true))
                                        ? ''
                                        : phone
                                            ? 'Phone'
                                            : 'Email',
                                labelStyle: TextStyle(color: primaryMain),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.grey.shade400,
                                )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: primaryMain))),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? phone
                                        ? 'Enter a valid phone number'
                                        : 'Enter a valid email'
                                    : null,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: ((phone == false && email == false) ||
                                      (phone == true && email == true))
                                  ? Colors.grey
                                  : primaryMain,
                              minimumSize: Size.fromHeight(50),
                            ),
                            icon: Icon(((phone == false && email == false) ||
                                    (phone == true && email == true))
                                ? null
                                : phone
                                    ? Ionicons.call
                                    : Icons.email_outlined),
                            label: Text(
                              (phone == true && email == true)
                                  ? 'Choose Email or Password'
                                  : 'Reset Password',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              if (emailController.text.isNotEmpty) {
                                ((phone == false && email == false) ||
                                        (phone == true && email == true))
                                    ? null
                                    : resetPassword();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      //Utils.showSnackBar('Password Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      //  Utils.showSnackBar(e.message);
    }
  }
}
