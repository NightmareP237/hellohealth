import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/loading-appointment.dart';
import 'package:hellohealth/screens/home/update-appointment.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

import '../../models/Appointment.dart';
import 'loading-page.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

bool loading = true, load = true;
// List<Appointment> appoint = [];
List<Appointment> myappointment = [];

class _PlanningState extends State<Planning> {
  Future<bool> getAppointments() async {
    try {
      FirebaseFirestore.instance
          .collection('appointments')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        setState(() {
          myappointment = Appointment.fromQuerySnapshot(value);
        });
        print(myappointment.length);
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteAppointments(Appointment index) async {
    try {
      setState(() {
        load = false;
      });
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(index.docId)
          .delete();
      setState(() {
        load = true;
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    Timer(Duration(milliseconds: 500), () {
      getAppointments().then((value) => setState(() {
            loading = !value;
            myappointment.isNotEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green[400],
                    content: const Text('Planning is update !')))
                : null;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorApp().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        // appBar: appbar(context, 'My Appointment', arrow: false),
        body: RefreshIndicator(
          displacement: 50,
          color: primaryMain,
          onRefresh: () {
            return getAppointments();
          },
          child: (loading)
              ? AppointmentLoading()
              : SafeArea(
                  child: Stack(
                    children: [
                      CustomAppBar(
                          label: 'My Appointments',
                          context: context,
                          iconback: false),
                      Padding(
                        padding: EdgeInsets.only(
                            top: myappointment.isEmpty
                                ? redimh(context) / 8
                                : redimh(context) / 13),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: myappointment.isEmpty
                              ? Column(
                                  children: [
                                    LottieBuilder.asset(
                                        'assets/lotties/planapp.json'),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      'No appointment ,\n Please create your appointment !',
                                      style: TextStyle(
                                        color: primaryMain,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'SignikaNegative',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        // height: 0.56,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )
                              : Column(
                                  children: myappointment
                                      .map((index) => Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        color: primaryMain
                                                            .withOpacity(.3),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: primaryMain
                                                                .withOpacity(
                                                                    .3),
                                                            blurRadius: 4,
                                                            offset:
                                                                Offset(-2, 10),
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Date',
                                                                      style:
                                                                          body(),
                                                                    ),
                                                                    Text(
                                                                      index
                                                                          .createAt
                                                                          .toString(),
                                                                      style:
                                                                          SubTitle(),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Type',
                                                                      style:
                                                                          body(),
                                                                    ),
                                                                    Text(
                                                                      index.specialistof.toString().length >=
                                                                              6
                                                                          ? "${index.specialistof.toString().substring(0, 6)}..."
                                                                          : index
                                                                              .specialistof
                                                                              .toString(),
                                                                      style:
                                                                          SubTitle(),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Time',
                                                                      style:
                                                                          body(),
                                                                    ),
                                                                    Text(
                                                                      index.time
                                                                          .toString(),
                                                                      style:
                                                                          SubTitle(),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Doctor',
                                                                      style:
                                                                          body(),
                                                                    ),
                                                                    Text(
                                                                      index
                                                                          .doctorName
                                                                          .toString(),
                                                                      style:
                                                                          SubTitle(),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Place',
                                                                      style:
                                                                          body(),
                                                                    ),
                                                                    Text(
                                                                      index.location.toString().length >=
                                                                              13
                                                                          ? "${index.location.toString().substring(0, 13)}..."
                                                                          : index
                                                                              .location
                                                                              .toString(),
                                                                      style:
                                                                          SubTitle(),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: redimw(
                                                                        context) /
                                                                    4,
                                                                height: 45,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        nav(UpdateAppointment(rdv: index),
                                                                            context);

                                                                        // nav(Appoint(), context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: redimw(context) /
                                                                            9.5,
                                                                        height:
                                                                            40,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.grey[400],
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        child: Center(
                                                                            child: Icon(
                                                                          Ionicons
                                                                              .pencil,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            title:
                                                                                Text(
                                                                              'Alert !',
                                                                              style: SubTitle(),
                                                                            ),
                                                                            content:
                                                                                Text('are you sure you want to delete this appointment ?'),
                                                                            actions: [
                                                                              TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                    setState(() {
                                                                                      load = false;
                                                                                    });
                                                                                    Timer(Duration(milliseconds: 700), () {
                                                                                      deleteAppointments(index).then((value) {
                                                                                        setState(() {
                                                                                          load = value;
                                                                                          myappointment.remove(index);
                                                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green[400], content: const Text('You have successfully deleted this appointment !')));
                                                                                        });
                                                                                      });
                                                                                    });
                                                                                  },
                                                                                  child: Text('Ok')),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: redimw(context) /
                                                                            9.5,
                                                                        height:
                                                                            40,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.red[400],
                                                                            borderRadius: BorderRadius.circular(5)),
                                                                        child: Center(
                                                                            child: Icon(
                                                                          Ionicons
                                                                              .trash,
                                                                          color:
                                                                              Colors.white,
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                        ),
                      ),
                      !load ? LoadingComponennt() : SizedBox()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
