import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/screens/home/bottom-bar.dart';

import '../../loop-page.dart';
import '../auth.dart';
import 'home_page.dart';

class Statut extends StatefulWidget {
  Statut({Key? key}) : super(key: key);
  @override
  State<Statut> createState() => _StatutState();
}

bool authentificated = false;

class _StatutState extends State<Statut> {
  User? user;
  AuthServices auth = AuthServices();
  Future<void> getuser() async {
    await auth.user.then((userResult) async => {
          (userResult != null)
              ? print('UID has been getted ?${userResult.uid}')
              : print('UID not found ?'),
          setState(() => user = userResult),
        });
  }

  @override
  initState() {
    // TODO: implement initState
    getuser();
    super.initState();
  }

  Widget build(BuildContext context) {
    return user != null ? BottomBar() : const LoopPage();
  }
}
