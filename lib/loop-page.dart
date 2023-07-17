import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/screens/home/SplashScreen/Sp1.dart';
import 'package:hellohealth/screens/home/SplashScreen/essai.dart';
import 'package:hellohealth/screens/home/informations/informationdeux_page.dart';
import 'package:hellohealth/screens/home/informations/informationun_page.dart';
import 'package:loop_page_view/loop_page_view.dart';

class LoopPage extends StatefulWidget {
  const LoopPage({super.key});

  @override
  State<LoopPage> createState() => _LoopPageState();
}


class _LoopPageState extends State<LoopPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return PageView.builder(
        itemCount: 3,
        itemBuilder: (_, index) {
          return index == 0
              ? Splash()
              : index == 1
                  ? InformationUnPage()
                  : InformationDeuxPage();
        });
  }
}
