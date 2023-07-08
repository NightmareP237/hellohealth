import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/auth_provider.dart';
import '../../screens/home/login/login_page.dart';
import '../../screens/home/home_page.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

/*
  final bool isLoading;
  final void Function(
      String username,
      String email,
      String password,
      String confirmpassword,
      bool isRegister,
      BuildContext ctx,
      ) submitFnc;

  RegisterFormWidget(this.submitFnc, this.isLoading);
*/

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}
_makingPhoneCall() async {
  var url = Uri.parse("tel:677148646");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _userName = '';
  var _userEmail = '';
  var _userPassword = '';

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _cfp = TextEditingController();

  void _trySubmit() async {
    print(
        "enter new user-----------------.${_userEmail.trim()} ${_userName.trim()} ${_userPassword.trim()}");
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

        await authStateProvider.register(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName.trim(),
        );
        if (!mounted) return;
        if (authStateProvider.isAuthenticated == true) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        }
      } on FirebaseAuthException catch (e) {
        // On error
        // If user exists
        if (e.code == 'user already exists') {
          print("enter new user.");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("user already exists."),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
        // If password is wrong
        if (_cfp != _pass) {
          print(" password.do not match");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("password.do not match"),
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

/*  void _trySubmit() {
    final isValid = _formkey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      if(_pass.text==_cfp.text){
        _formkey.currentState?.save();
        widget.submitFnc(
            _userName.trim(),
            _userEmail.trim(),
            _userPassword.trim(),
            _userConfirmPassword.trim(),
            _isRegister,
            context
        );
      }
      else{
        return print('C\'est faux');
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              height: h / 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/stet.png',
                  width: 70,
                ),
                SizedBox(
                  width: 7,
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
              width: double.infinity,
              margin: EdgeInsets.only(top: 20, right: 16, left: 16),
              padding: EdgeInsets.all(20),
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
                      child: Text('Register With Us !',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              height: 2)),
                    ),
                    Center(
                      child: Text('Your information is safe with us!',
                          style: TextStyle(
                              color: Colors.black45, fontSize: 14, height: 2)),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Enter at leaast 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),

                        border: OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.solid)),
                        // icon:,
                        labelText: 'Username :',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                      ),
                      onSaved: (val) {
                        _userName = val!;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
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
                        border: OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.solid)),
                        prefixIcon: Icon(Icons.email),
                        // icon: ,
                        labelText: 'Enter your email address :',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                      ),
                      onSaved: (val) {
                        _userEmail = val!;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _pass,
                      key: ValueKey('password'),
                      validator: (val) => (val!.isEmpty || val.length < 7)
                          ? 'Password must be least 7 characters long!'
                          : null,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.solid)),
                        prefixIcon: Icon(Icons.lock),

                        // icon: ,
                        labelText: 'Password :',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                      ),
                      onSaved: (val) {
                        _userPassword = val!;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _cfp,
                      key: ValueKey('confirmpassword'),
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(style: BorderStyle.solid)),
                        prefixIcon: Icon(Icons.lock),

                        // icon:,
                        labelText: 'Confirm Your Password :',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                      ),
                    ),
                    if (_isLoading) CircularProgressIndicator(),
                    Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            _trySubmit();
                          },
                          child: Container(
                            width: 340,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange.withOpacity(.7),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // if(!_isLoading)
                    // Center(
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 16.0),
                    //     // ignore: deprecated_member_use
                    //     child:
                    //     // ignore: deprecated_member_use
                    //     ElevatedButton(
                    //       // color: ,
                    //       style: ButtonStyle(
                    //         // backgroundColor: Colors.blue,
                    //       ),
                    //       child: Text( 'Sign Up',
                    //           style: TextStyle(color: Colors.white)),
                    //       onPressed: () {
                    //         _trySubmit();
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 8,),
                    if (!_isLoading)
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 16),
                            ),
                            // ignore: deprecated_member_use
                            // SizedBox(width: ,),
                            TextButton(
                              child: Text(
                                'Sign In',
                               style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange,
                                    fontSize: 16),
                              ),
                              /*    onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },*/
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 10,),
GestureDetector(
                          onTap: () {
                            _makingPhoneCall();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange.withOpacity(.7),
                            ),
                            child: Center(
                              child: ListTile(
                                leading: Icon(Icons.add_ic_call_outlined,
                                    color: Colors.white),
                                title: Text(
                                  'You Need Help To SignUp ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
