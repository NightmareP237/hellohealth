import 'package:flutter/material.dart';
import 'package:hellohealth/SplashScreen/Sp1.dart';
import 'package:hellohealth/ressources/const.dart';
import 'dart:math' as math;

class CardWidget extends StatelessWidget {
  List data = [
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
  ];

  final colorblack = Colors.white;
  final colorwhite = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // crossAxisSpacing: 10
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Card(
              color: data[math.Random.secure().nextInt(12)]["color"],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '  Heart Rate',
                          style: TextStyle(color: colorwhite, fontSize: 16),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              color: Color.fromRGBO(255, 255, 255, 0.38)),
                          child: Icon(
                            Icons.favorite,
                            color: colorblack,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 10, bottom: 2),
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/d3.png',
                              width: 70,
                              height: 70,
                            ),
                            Text(
                              '144 bpm',
                              style: TextStyle(fontSize: 27, color: colorwhite),
                            ),
                          ],
                        )),
                    Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Text(
                              'Healthy',
                              style: TextStyle(fontSize: 18, color: colorwhite),
                            ),
                            Text(
                              '50-120',
                              style: TextStyle(fontSize: 18, color: colorwhite),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
