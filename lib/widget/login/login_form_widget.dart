import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/auth_provider.dart';
import '../../screens/auth/register/forgotpasspage.dart';
import '../../screens/auth/register/register_page.dart';
import '../../screens/home/home_page.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

_makingPhoneCall() async {
  var url = Uri.parse("tel:677148646");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _userEmail = '';
  var _userPassword = '';

  void _trySubmit() async {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      _formkey.currentState?.save();
      try {
        setState(() {
          _isLoading = true;
        });
        final AuthProvider authStateProvider =
            Provider.of<AuthProvider>(context, listen: false);
        await authStateProvider.login(_userEmail.trim(), _userPassword.trim());
        if (!mounted) return;
        if (authStateProvider.isAuthenticated == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()));
        }
      } on FirebaseAuthException catch (e) {
        // On error
        // If user is not found
        if (e.code == 'user-not-found') {
          print("No user found for that email.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("No user found for that email."),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
        // If password is wrong
        if (e.code == 'wrong-password') {
          print("Wrong password.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Wrong password"),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }

        setState(() {
          _isLoading = false;
        });
      } on PlatformException catch (err) {
        var message = 'An error occured, please check your credentials !';
        if (err.message != null) {
          message = err.message!;
        }

        // ignore: deprecated_member_use
        // Scaffold.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(message),
        //     backgroundColor: Theme.of(context).errorColor,
        //   ),
        // );

        setState(() {
          _isLoading = false;
        });
      } catch (err) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                ),
                Image.asset(
                  'assets/images/stet.png',
                  width: 70,
                ),
                Text(
                  'HelloHealth',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Container(
              height: 600,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
                color: Colors.black12,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Center(
                      child: Text('Welcome Back !',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              height: 2)),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/undraw_Access_account_re_8spm-removebg-preview.png',
                        width: 150,
                      ),
                    ),
                    Center(
                      child: TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if (value!.isEmpty ||
                              (!value.contains('@') && !value.contains('.'))) {
                            return 'Enter a valid email address !';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email),
                          labelText: 'Enter your email address :',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        ),
                        onSaved: (val) {
                          _userEmail = val!;
                        },
                      ),
                    ),
                    // if (!_isLogin)

                    Center(
                      child: TextFormField(
                        key: ValueKey('password'),
                        validator: (val) => (val == null || val.length < 7)
                            ? 'Password must be least 7 characters long!'
                            : null,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Enter Your Password :',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        ),
                        onSaved: (val) {
                          _userPassword = val!;
                        },
                      ),
                    ),
                    if (_isLoading) CircularProgressIndicator(),
                    if (!_isLoading)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          // ignore: deprecated_member_use
                          child: TextButton(
                            // color: Colors.blue,
                            child: Text('Sign In',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              _trySubmit();
                            },
                          ),
                        ),
                      ),
                    if (!_isLoading)
                      // ignore: deprecated_member_use
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPassPage()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.orange, fontSize: 12),
                        ),
                      ),
                    Center(
                      child: Row(
                        children: [
                          Text(
                            '        You do not have an account ?',
                          ),
                          // ignore: deprecated_member_use
                          TextButton(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          ),
                          // ignore: deprecated_member_use
                          /*    FlatButton(
                            child: Text(
                              'You Need Help To SignIn?  Type Here',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            onPressed: () {
                              _makingPhoneCall();
                            },
                          ),*/
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.add_ic_call_outlined),
                      title: Text(
                        'You Need Help To SignIn?',
                        style: TextStyle(color: Colors.orange),
                      ),
                      onTap: () {
                        _makingPhoneCall();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
