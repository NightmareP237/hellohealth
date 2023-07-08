import 'package:flutter/material.dart';
import 'package:hellohealth/models/patient.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/home_page.dart';
import 'package:ionicons/ionicons.dart';

import 'Appointment.dart';

class DoctorView extends StatefulWidget {
  DoctorView({super.key, required this.doctorDetail});
  Map<String, String> doctorDetail;
  // final imageDoctor;
  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  @override
  Widget build(BuildContext context) {
    final listCall = List.generate(
        3,
        (index) => GestureDetector(
              onTap: () {
                print('hello');
              },
              child: Container(
                decoration: BoxDecoration(
                    color: primaryMain.withOpacity(.85),
                    borderRadius: BorderRadius.circular(5)),
                width: redimw(context) / 3.5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        (index == 1)
                            ? Ionicons.call
                            : (index == 2)
                                ? Ionicons.videocam
                                : Icons.message,
                        color: Colors.white,
                      ),
                      Text(
                        (index == 1)
                            ? "Voice Call"
                            : (index == 2)
                                ? 'Video Call'
                                : "Message",
                        style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ));
    return Scaffold(
      appBar: appbar(context, widget.doctorDetail['name']),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          // width: double.infinity,
          // height: double.infinity,
          child: Column(
            children: [
              Container(
                height: redimh(context) / 2.5,
                width: double.infinity,
                child: Image.asset(
                  width: 600,
                  height: 400,
                  widget.doctorDetail['image'].toString(),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: listCall,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Medecine & ${widget.doctorDetail['specialist'].toString()} Specialist",
                      style: SubTitle(),
                    ),
                    Text(
                      "Good Health Clinic. MBBS ,FCPS",
                      style: body(),
                    ),
                    Row(
                      children: [
                        for (var i = 0; i <= 5; i++)
                          Icon(
                            Ionicons.star,
                            color: Colors.yellow[400],
                          )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "About ${widget.doctorDetail['name'].toString().split('Dr')[1]}",
                      style: SubTitle(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.doctorDetail['description'].toString().isEmpty
                          ? "Lorem ipsum isk sdm ,.sdmm wjfkjkdmnd ,sdmjkjds klskdjdfhhkasjdajs asjdkasjdjasd jnddjnse lBDLdf bdsdjfba asdjfa slJDSDU  slajbsdf sJBF"
                          : widget.doctorDetail['description'].toString(),
                      textAlign: TextAlign.start,
                      style: body(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          3,
                          (index) => Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      index == 0
                                          ? "Patients"
                                          : index == 1
                                              ? "Specialist"
                                              : 'Years',
                                      style: body(),
                                    ),
                                    Text(
                                      index == 0
                                          ? widget.doctorDetail['patients']
                                              .toString()
                                          : index == 1
                                              ? widget
                                                  .doctorDetail['specialist']
                                                  .toString()
                                              : widget
                                                  .doctorDetail['experience']
                                                  .toString(),
                                      style: NameStyle(),
                                    ),
                                  ],
                                ),
                              )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        nav(Appoint(), context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: primaryMain,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Book An Appointment",
                            style: SubTitle(black: true),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
