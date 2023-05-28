import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hellohealth/screens/auth/login/login_page.dart';
//import 'package:hellohealth/login/login_page.dart';
import 'package:page_transition/page_transition.dart';

import 'Animations/FadeAnimation.dart';


/*void main() {
  runApp( MyApp());
}*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
 late  AnimationController _scaleController;
 late AnimationController _scale2Controller;
 late AnimationController _widthController;
 late AnimationController _positionController;

 late  Animation<double> _scaleAnimation;
 late  Animation<double> _scale2Animation;
 late  Animation<double> _widthAnimation;
 late Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState( (){
                hideIcon = true;
              }
              );
              _scale2Controller.forward();
            }
          });

    _scale2Controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition( type: PageTransitionType.fade,child: LoginPage()));
      }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFF),
              Color(0xFFFFFF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Positioned(
                top: 100,
                left: 100,
                child: Image.asset(
                  'assets/images/malette.png',
                  alignment: Alignment.centerRight,
                  width: 56.0,
                  height: 100.0,
                ),
              ),
              Positioned(
                top: 135,
                left: 160,
                child: Text(
                  'HelloHealth',
                  style: TextStyle(color: Colors.orange, fontSize: 30),
                ),
              ),
              Positioned(
                top: 200,
                left: 90,
                child: Directionality(
                  textDirection: TextDirection.ltr, // inverser limage si besoin
                  child: SvgPicture.asset(
                    'assets/images/undraw_doctor_kw-5-l.svg',
                    height: 150.0,
                    matchTextDirection: true,
                  ),
                ),
              ),
              Positioned(
                top: 400,
                left: 44,
                child: Text(
                  'Consult Specialist Doctors ',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 425,
                left: 70,
                child: Text(
                  'Securely and Privately',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 470,
                left: 85,
                child: Text(
                  'Your health,Our priority',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Positioned(
                top: 600,
                left: 150,
                child: FadeAnimation(
                  1.6,
                  AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _widthController,
                                builder: (context, child) => Container(
                                  width: _widthAnimation.value,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange.withOpacity(.4),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      _scaleController.forward();
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        AnimatedBuilder(
                                          animation: _positionController,
                                          builder: (context, child) => Positioned(
                                            left: _positionAnimation.value,
                                            child: AnimatedBuilder(
                                              animation: _scale2Controller,
                                              builder: (context, child) =>
                                                  Transform.scale(
                                                scale: _scale2Animation.value,
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.orange),
                                                  child: hideIcon == false? Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.white,
                                                  ) : Container(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
