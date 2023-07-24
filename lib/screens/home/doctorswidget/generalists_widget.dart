import 'package:flutter/material.dart';
import 'package:hellohealth/models/doctor.dart';
import '../../../models/CardItem.dart';
import '../../../ressources/const.dart';
import '../carditem/cardItemWidget.dart';

class GeneralistsWidget extends StatefulWidget {
  GeneralistsWidget({Key? key, required this.items}) : super(key: key);
  List<Doctor> items = [];
  @override
  State<GeneralistsWidget> createState() => _GeneralistsWidgetState();
}

class _GeneralistsWidgetState extends State<GeneralistsWidget> {
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
          children: List.generate(widget.items.length,
              (index) => CardItemWidget(item: widget.items[index])),
        ),
      ),
    ));
  }
}
