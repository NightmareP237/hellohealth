import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/SplashScreen/Sp1.dart';
import 'package:hellohealth/SplashScreen/essai.dart';
import 'package:hellohealth/screens/informations/informationdeux_page.dart';
import 'package:hellohealth/screens/informations/informationun_page.dart';
import 'package:loop_page_view/loop_page_view.dart';

class LoopPage extends StatefulWidget {
  const LoopPage({super.key});

  @override
  State<LoopPage> createState() => _LoopPageState();
}


class _LoopPageState extends State<LoopPage> {
  @override
  void initState() {
    FirebaseAuth.instance.signInAnonymously();
    super.initState();
  }

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
