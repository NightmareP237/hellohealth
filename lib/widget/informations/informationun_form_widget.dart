import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../screens/informations/informationdeux_page.dart';

class InformationUnFormWidget extends StatefulWidget {
  const InformationUnFormWidget({Key? key}) : super(key: key);

  @override
  State<InformationUnFormWidget> createState() =>
      _InformationUnFormWidgetState();
}

class _InformationUnFormWidgetState extends State<InformationUnFormWidget> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Center(
            child: Column(children: [
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
              'assets/images/d16.png',
              width: 500,
              height: h / 3,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Center(
            child: Text(
              textAlign: TextAlign.justify,
              'Your well-being starts here ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
          Center(
            child: Text(
              textAlign: TextAlign.justify,
              'Enjoy With Us And',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
          Center(
            child: Text(
              textAlign: TextAlign.justify,
              'Talk About Experience',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
      Container(
        height: 50,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/lotties/Slidetwo.json', height: 120, width: 120),
          SizedBox(
            height: 45,
          ),
          SmoothIndicator(
            offset: 1,
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
      )
    ])));
  }
}
