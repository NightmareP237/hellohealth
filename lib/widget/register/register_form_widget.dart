import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/auth_provider.dart';
import '../../screens/auth/login/login_page.dart';
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

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  var _userName = '';
  var _userEmail = '';
  var _userPassword = '';

 final TextEditingController _pass = TextEditingController();
 final TextEditingController _cfp = TextEditingController();

  void _trySubmit() async {

    print("enter new user-----------------.${_userEmail.trim()} ${_userName.trim()} ${_userPassword.trim()}");
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


        await authStateProvider.register(_userEmail.trim(), _userPassword.trim(),_userName.trim(),);
        if (!mounted) return;
        if (authStateProvider.isAuthenticated == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()));
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
                Image.asset('assets/images/stet.png',width: 80,height: 80,),
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
                            color: Colors.orange,
                              fontSize: 14,
                              height: 2)),
                    ),
                    Center(
                      child: TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if(value == null || value.length < 4) {
                            return 'Enter at leaast 4 characters';
                          }return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Username :',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        ),
                        onSaved: (val) {
                          _userName = val!;
                        },
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
                    Center(
                      child: TextFormField(
                        controller: _pass,
                        key:  ValueKey('password'),
                        validator: (val) => (val!.isEmpty || val.length < 7)
                            ? 'Password must be least 7 characters long!'
                            : null,
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password :',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        ),
                       onSaved: (val) {
                          _userPassword = val!;
                        },
                      ),
                    ),
                    Center(
                      child: TextFormField(
                        controller: _cfp,
                        key: ValueKey('confirmpassword'),
                        autofocus: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Confirm Your Password :',
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        ),
                      ),
                    ),
                    if(_isLoading) CircularProgressIndicator(),
                    if(!_isLoading)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        // ignore: deprecated_member_use
                        child:
                        // ignore: deprecated_member_use
                        ElevatedButton(
                          // color: ,
                          style: ButtonStyle(
                            // backgroundColor: Colors.blue,
                          ),
                          child: Text( 'Sign Up',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            _trySubmit();
                          },
                        ),
                      ),
                    ),
                    if(!_isLoading)
                    Center(
                      child: Row(
                        children: [
                          Text(
                            '           Already have an account ?',
                          ),
                          // ignore: deprecated_member_use
                          TextButton(
                            child: Text(
                                   'Sign In'
                                  ,
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            /*    onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },*/
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                          ),
                        ],
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
