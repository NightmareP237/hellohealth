import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/loading-appointment.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

bool loading = true;

class _PlanningState extends State<Planning> {
  Future<void> getAppointment() async {
    setState(() {
      loading = true;
    });
    Timer(
        const Duration(seconds: 5),
        () => setState(() {
              loading = false;
              // print('hello');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green[400],
                  content: const Text('Planning is update !')));
            }));
  }

  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => setState(() {
              loading = false;
              print('hello');
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'My Appointment', arrow: false),
      body: RefreshIndicator(
        displacement: 50,
        color: primaryMain,
        onRefresh: () {
          return getAppointment();
        },
        child: loading
            ? AppointmentLoading()
            : SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        myappointment.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                          color: primaryMain.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Date',
                                                        style: body(),
                                                      ),
                                                      Text(
                                                        myappointment[index]
                                                                ['date']
                                                            .toString(),
                                                        style: SubTitle(),
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
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Type',
                                                        style: body(),
                                                      ),
                                                      Text(
                                                        myappointment[index]
                                                                ['type']
                                                            .toString(),
                                                        style: SubTitle(),
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
                                                  CrossAxisAlignment.start,
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
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Time',
                                                        style: body(),
                                                      ),
                                                      Text(
                                                        myappointment[index]
                                                                ['time']
                                                            .toString(),
                                                        style: SubTitle(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Doctor',
                                                        style: body(),
                                                      ),
                                                      Text(
                                                        myappointment[index]
                                                                ['doctor']
                                                            .toString(),
                                                        style: SubTitle(),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Place',
                                                        style: body(),
                                                      ),
                                                      Text(
                                                        myappointment[index]
                                                                ['place']
                                                            .toString(),
                                                        style: SubTitle(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              title: Text(
                                                                'Alert !',
                                                                style:
                                                                    SubTitle(),
                                                              ),
                                                              content: Text(
                                                                  'are you sure you want to delete this appointment ?'),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child: Text(
                                                                        'Cancel')),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                          backgroundColor: Colors.green[
                                                                              400],
                                                                          content:
                                                                              const Text('You have successfully deleted this appointment !')));
                                                                    },
                                                                    child: Text(
                                                                        'Ok')),
                                                              ],
                                                            ),
                                                          );

                                                          // nav(Appoint(), context);
                                                        },
                                                        child: Container(
                                                          width:
                                                              redimw(context) /
                                                                  4.5,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .red[900],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Center(
                                                            child: Text(
                                                              "Cancel",
                                                              style: SubTitle(
                                                                  black: true),
                                                            ),
                                                          ),
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
                                    )
                                  ],
                                ),
                              ),
                            )),
                  ),
                ),
              ),
      ),
    );
  }
}
