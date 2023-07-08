import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Animations/FadeAnimation.dart';

class stack extends StatefulWidget {
  @override
  State<stack> createState() => _stackState();
}

class _stackState extends State<stack> with TickerProviderStateMixin {
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
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
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
        vsync: this, duration: Duration(milliseconds: 1000));

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
        vsync: this, duration: Duration(milliseconds: 1000));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.fade,
              //         child: InformationUnPage()));
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
                SizedBox(
                  width: 7,
                ),
                Text(
                  'HelloHealth',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
            Column(
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/images/undraw_doctor_kw-5-l.svg',
                    width: 200,
                    height: h / 3.2,
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Column(
              children: [
                Center(
                  child: Text(
                    'Consult Specialist Doctors ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Securely and Privately',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 15,
            ),
            Column(
              children: [
                Center(
                  child: Text('Your health,Our priority'),
                ),
              ],
            ),
            Container(
              height: 30,
            ),
            Column(
              children: [
                Lottie.asset('assets/lotties/Slidetwo.json',
                    height: 120, width: 120),
                SizedBox(
                  height: 35,
                ),
                SmoothIndicator(
                  offset: 0,
                  onDotClicked: (index) {},
                  size: Size(15, 15),
                  //  controller: controller,  // PageController
                  count: 3,
                  // forcing the indicator to use a specific direction
                  //  textDirection: TextDirection.rtl  ,
                  effect: WormEffect(
                    dotColor: Colors.grey.shade300,
                    activeDotColor: Colors.orange.shade300
                  ),
                )
                // Center(
                //   child: FadeAnimation(
                //     1.6,
                //     AnimatedBuilder(
                //         animation: _scaleController,
                //         builder: (context, child) => Transform.scale(
                //               scale: _scaleAnimation.value,
                //               child: AnimatedBuilder(
                //                 animation: _widthController,
                //                 builder: (context, child) => Container(
                //                   width: _widthAnimation.value,
                //                   height: 120,
                //                   padding: EdgeInsets.all(10),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(50),
                //                     // color: Colors.orange.withOpacity(.4),
                //                   ),
                //                   child: Stack(
                //                     children: <Widget>[
                //                       // ,
                //                       AnimatedBuilder(
                //                         animation: _positionController,
                //                         builder: (context, child) =>
                //                             Positioned(
                //                           // left: _positionAnimation.value,
                //                           child: AnimatedBuilder(
                //                             animation: _scale2Controller,
                //                             builder: (context, child) =>
                //                                 Transform.scale(
                //                               scale: _scale2Animation.value,
                //                               child:
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             )),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:page_transition/page_transition.dart';

// import '../Animations/FadeAnimation.dart';
// import '../screens/informations/informationun_page.dart';

// class stack extends StatefulWidget {
//   @override
//   State<stack> createState() => _stackState();
// }

// class _stackState extends State<stack> with TickerProviderStateMixin {

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Center(
//         child: Column(
//           children: [
//             Container(
//               height: 70,
//             ),
//             Row(
//               children: [
//                 Container(
//                   width: 60,
//                 ),
//                 Image.asset(
//                   'assets/images/stet.png',
//                   width: 70,
//                 ),
//                 SizedBox(width: 7,),
//                 Text(
//                   'HelloHealth',
//                   style: TextStyle(
//                     color: Colors.orange,
//                     fontSize: 25,
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               height: 30,
//             ),
//             Column(
//               children: [
//                 Center(
//                   child: SvgPicture.asset(
//                     'assets/images/undraw_doctor_kw-5-l.svg',
//                     width: 200,
//                     height: 170,
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               height: 10,
//             ),
//             Column(
//               children: [
//                 Center(
//                   child: Text(
//                     'Consult Specialist Doctors ',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 19,
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Text(
//                     'Securely and Privately',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 19,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               height: 15,
//             ),
//             Column(
//               children: [
//                 Center(
//                   child: Text('Your health,Our priority'),
//                 ),
//               ],
//             ),
//             Container(
//               height: 30,
//             ),
//             
//           ],
//         ),
//       ),
//     );
//   }
// }
