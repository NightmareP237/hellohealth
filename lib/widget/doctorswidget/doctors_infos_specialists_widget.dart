import 'package:flutter/material.dart';

import '../../models/CardItem.dart';

class DoctorsInfosSpecialistsWidget extends StatefulWidget {
  final CardItem item;

  DoctorsInfosSpecialistsWidget({ required this.item});

  @override
  State<DoctorsInfosSpecialistsWidget> createState() => _DoctorsInfosSpecialistsWidgetState();
}

class _DoctorsInfosSpecialistsWidgetState extends State<DoctorsInfosSpecialistsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.item.urlImage),
                    fit: BoxFit.cover
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
