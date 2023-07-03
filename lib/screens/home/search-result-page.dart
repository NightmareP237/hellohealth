import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';

class ResultPage extends StatefulWidget {
  ResultPage({super.key,required this.selectArea});
  String selectArea;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, widget.selectArea),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      )),
    );
  }
}
