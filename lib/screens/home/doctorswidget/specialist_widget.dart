import 'package:flutter/material.dart';
import 'package:hellohealth/models/doctor.dart';
import 'package:hellohealth/ressources/const.dart';

import '../../../models/CardItem.dart';
import '../carditem/cardItemWidget.dart';

class SpecialistsWidget extends StatefulWidget {
  SpecialistsWidget({Key? key, required this.items1}) : super(key: key);
  List<Doctor> items1 = [];

  @override
  State<SpecialistsWidget> createState() => _SpecialistsWidgetState();
}

class _SpecialistsWidgetState extends State<SpecialistsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: redimh(context) * .02,
            runAlignment: WrapAlignment.spaceBetween,
            runSpacing: redimh(context) * .02,
            children: List.generate(
                widget.items1.length, (index) => CardItemWidget(item: widget.items1[index])),
          ),
        ),
      ),
    );
  }
}
