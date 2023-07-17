import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hellohealth/screens/home/bottom-bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Animations/FadeAnimation.dart';
import '../login/login_page.dart';

class InformationDeuxFormWidget extends StatefulWidget {
  const InformationDeuxFormWidget({Key? key}) : super(key: key);

  @override
  State<InformationDeuxFormWidget> createState() =>
      _InformationDeuxFormWidgetState();
}

class _InformationDeuxFormWidgetState extends State<InformationDeuxFormWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;
  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    // print('ready in 3...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('ready in 2...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('ready in 1...');
    // await Future.delayed(const Duration(seconds: 1));
    // print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    initialization();
    super.initState();
    initialization();
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
        vsync: this, duration: Duration(milliseconds: 500));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
        height: h / 7,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/stet.png',
            width: 70,
          ),
          SizedBox(width: 7,),
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
        height: 20,
      ),
            Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/d17.png',
                    width: 500,
                    height: h/3,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Center(
                  child: Text(
                    'We are a platform that brings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      // color: Colors.orange,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Smiles back and want to keep it',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    textAlign:TextAlign.justify,
                    'That way for as long as possible.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      // color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
            Column(
              children: [
                Center(
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
                                            builder: (context, child) =>
                                                Positioned(
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
                                                    child: hideIcon == false
                                                        ? Icon(
                                                            Icons.arrow_forward,
                                                            color: Colors.white,
                                                          )
                                                        : Container(),
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
              ],
            ),
            SizedBox(
            height: 65,
          ),
          SmoothIndicator(
            offset: 2,
            onDotClicked: (index) {},
            size: Size(15, 15),
            //  controller: controller,  // PageController
            count: 3,
            // forcing the indicator to use a specific direction
            //  textDirection: TextDirection.rtl  ,
            effect: WormEffect(
                dotColor: Colors.grey.shade300,
                activeDotColor: Colors.orange.shade300),
          ),
          ],
        ),
      ),
    );
  }
}
