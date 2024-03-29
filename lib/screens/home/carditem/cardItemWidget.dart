import 'package:flutter/material.dart';
import 'package:hellohealth/models/doctor.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/doctor-info-view.dart';

import '../../../models/CardItem.dart';
import '../doctorswidget/doctors_infos_generalists_widget.dart';

class CardItemWidget extends StatefulWidget {
  final Doctor item;
  const CardItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();

  toList() {}
}

class _CardItemWidgetState extends State<CardItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                child: Ink.image(
                  image: NetworkImage(widget.item.image),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorView(doctorDetail: 
                          widget.item,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            widget.item.name!,
            style: SubTitle(),
          ),
          Text(widget.item.specialist!,),
        ],
      ),
    );
  }
}
