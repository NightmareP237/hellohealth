import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import '../../ressources/const.dart';

class AddDoctor extends StatefulWidget {
  AddDoctor({
    Key? key,
  }) : super(key: key);

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

int? selectedTripIndex;
int pageIndex = 0;
String stepInfo = "step1_text".i18n();

List<String> tabs = ["Cash", "Mobile"];
String currentDestination = "";

bool isValidPhoneNumber = true;

List<String> mounthsMin = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];
List<String> mounthsLong = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
List<String> week = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
List<int> days1 = [1, 2, 3, 4, 5, 6, 7];
List<int> days2 = [
  8,
  9,
  10,
  11,
  12,
  13,
  14,
];
List<int> days3 = [
  15,
  16,
  17,
  18,
  19,
  20,
  21,
];
List<int> days4 = [22, 23, 24, 25, 26, 27, 28];
List<int> days5 = [29, 30, 31];
List<int> lastWeek = [29, 30, 31];
int selected = 0;
int defaultSelectedDay =
    int.parse(DateFormat('d').format(DateTime.now()).toString());
int selectedDay = defaultSelectedDay;

String defaultSelectedMounth =
    DateFormat('MMMM').format(DateTime.now()).toString();
String selectedMounth = defaultSelectedMounth;

int defaultSelectedYear =
    int.parse(DateFormat('y').format(DateTime.now()).toString());
int selectedYear = defaultSelectedYear;
String finalSelectedDate = "";

int currentMounthIndex = mounthsLong.indexOf(defaultSelectedMounth);

String currentTime = DateFormat('Hm').format(DateTime.now()).toString();
int firsthour = int.parse(currentTime[0]);
int secondhour = int.parse(currentTime[1]);
int firstminute = int.parse(currentTime[3]);
int secondminute = int.parse(currentTime[4]);

bool isTripSelected = false;
bool showBottomSheet = true;

String firstName = "";
String lastName = "";
String phoneNumb = "";

// List<Trip> tmpList = [];

class _AddDoctorState extends State<AddDoctor> {
  @override
  void dispose() {
    // TODO: implement dispose
    disposeAppVars();
    super.dispose();
  }

  disposeAppVars() {
    firstName = "";
    lastName = "";
    phoneNumb = "";
    currentDestination = "";
    Counter = 1;
    finalSelectedDate = "";
    isCash = true;
    time = "";
    selectedTripIndex = null;
    pageIndex = 0;
  }

  initState() {
    // tmpList = tripList;
    super.initState();
  }

  // getMasterRoutes() async {
  //   final FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;
  //   await firebaseInstance
  //       .collection("routes-$tenantName")
  //       .get()
  //       .then((QuerySnapshot routesQuerySnapshot) {
  //     masterRoutes = MasterRoutes.fromQuerySnapshot(routesQuerySnapshot);

  //     var departures = masterRoutes
  //         .where((element) => (element.depShortCut).contains(agencyCity))
  //         .map((e) {
  //       departureLocation = e.departure;
  //       print("Location final: " + e.departure);
  //       hasFinishLoadMasterRoute = true;
  //       return departureLocation;
  //     }).toList();
  //     print(masterRoutes);
  //   });
  // }

  int Counter = 1;
  bool isTyping = false;
  bool showDatePicker = false;
  String fieldinitValue = '';
  // List<Trip> tripList = [];

  CollectionReference trips =
      FirebaseFirestore.instance.collection('trips-$tenantName');

  void RemoveCounter() {
    if (Counter > 1) {
      setState(() {
        Counter--;
      });
    }
  }

  bool status = false;
  void AddCounter() {
    setState(() {
      Counter++;
    });
  }

  Widget datePicker() {
    return SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ColorApp.defaultBackgroundColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: ColorApp.shadowColor,
                blurRadius: 9,
                spreadRadius: 450,
                offset: Offset(2, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "choose_date_text".i18n(),
                      style: subtitleStyle(ColorApp.secondaryText),
                    ),
                    IconButton(
                      // ignore: prefer_const_constructors
                      icon: SvgPicture.asset(
                        "assets/icons/cancel.svg",
                        width: 20,
                      ),
                      onPressed: (() {
                        setState(() {
                          showDatePicker = false;
                          finalSelectedDate =
                              "$selectedDay.0${currentMounthIndex + 1}.2023";
                        });
                      }),
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                child: MounthSelection(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: days1.map((element) {
                        return DaySelection(element);
                      }).toList(),
                    ),
                    SizedBox(height: 38.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: days2.map((element) {
                        return DaySelection(element);
                      }).toList(),
                    ),
                    SizedBox(height: 38.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: days3.map((element) {
                        return DaySelection(element);
                      }).toList(),
                    ),
                    SizedBox(height: 38.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: days4.map((element) {
                        return DaySelection(element);
                      }).toList(),
                    ),
                    SizedBox(height: 38.0),
                    Row(
                      children: lastWeek.map((element) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 7.0),
                          child: DaySelection(element),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget DaySelection(int label) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedDay = label;
          if (kDebugMode) {
            print(defaultSelectedDay);
          }
          showDatePicker = false;
          if (currentMounthIndex > 9) {
            finalSelectedDate = "$selectedDay.${currentMounthIndex + 1}.2023";
          } else {
            finalSelectedDate = "$selectedDay.0${currentMounthIndex + 1}.2023";
          }
          if (kDebugMode) {
            print(finalSelectedDate);
          }
        });
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: selectedDay == label
            ? BoxDecoration(
                shape: BoxShape.circle, color: primaryMain.withOpacity(0.4))
            : null,
        child: Center(
          child: Text(label.toString()),
        ),
      ),
    );
  }

  Widget MounthSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: currentMounthIndex > 0
                    ? Colors.black
                    : ColorApp.defaultBackgroundColor),
            onPressed: () {
              if (currentMounthIndex > 0) {
                setState(() {
                  currentMounthIndex--;
                });

                if (currentMounthIndex % 2 == 0) {
                  setState(() {
                    lastWeek = [29, 30, 31];
                  });
                } else if (currentMounthIndex == 1) {
                  setState(() {
                    lastWeek = [];
                  });
                } else {
                  setState(() {
                    lastWeek = [29, 30];
                  });
                }
              } else {
                return;
              }
              if (kDebugMode) {
                print(currentMounthIndex);
              }
            }),
        Text(
          "${mounthsMin[currentMounthIndex]} $defaultSelectedYear",
          style: bodyBoldStyle(ColorApp.secondaryText),
        ),
        IconButton(
            icon: Icon(Icons.arrow_forward_ios_rounded,
                color: currentMounthIndex < 11
                    ? Colors.black
                    : ColorApp.defaultBackgroundColor),
            onPressed: () {
              if (currentMounthIndex < 11) {
                setState(() {
                  currentMounthIndex++;
                });

                if (currentMounthIndex % 2 == 0) {
                  setState(() {
                    lastWeek = [29, 30, 31];
                  });
                } else if (currentMounthIndex == 1) {
                  setState(() {
                    lastWeek = [];
                  });
                } else {
                  setState(() {
                    lastWeek = [29, 30];
                  });
                }
              } else {
                return;
              }
              if (kDebugMode) {
                print(currentMounthIndex);
              }
            }),
      ],
    );
  }

  ChooseDestination() => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        bool click = false;
        bool change = false;
        bool errorCar = false;
        String dropdownValue = currentDestination;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding:
                EdgeInsets.only(top: 0, bottom: 24, left: 24, right: 24),
            content: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'choose_destination_label'.i18n(),
                        textAlign: TextAlign.left,
                        style: subtitleStyle(ColorApp.secondaryText),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.clear_rounded,
                            color: ColorApp.disabledText,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              // ignore: dead_code
                              border: errorCar
                                  ? Border.all(width: 1, color: primaryMain)
                                  : null,
                              color: ColorApp.fieldColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: (!click)
                                      ? Text(
                                          dropdownValue,
                                          style:
                                              bodyStyle(ColorApp.secondaryText),
                                        )
                                      : Text("destination"),
                                  onMenuStateChange: (val) {
                                    setState(() {
                                      click = val;
                                    });
                                  },
                                  isExpanded: true,
                                  items: []
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.destShortCut,
                                            child: (item == dropdownValue)
                                                ? Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: Color.fromRGBO(
                                                        61, 214, 208, 0.2),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          item.destShortCut,
                                                          style: bodyStyle(
                                                              ColorApp
                                                                  .secondaryText),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Text(
                                                      item.destShortCut,
                                                      style: bodyStyle(ColorApp
                                                          .secondaryText),
                                                    ),
                                                  ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropdownValue = value as String;
                                      change = true;
                                      errorCar = true;
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        setState(() {
                                          errorCar = false;
                                        });
                                      });
                                    });
                                  },
                                  // icon: Icon(
                                  //   Icons.keyboard_arrow_down_rounded,
                                  //   color: ColorApp.secondaryText,
                                  // ),
                                  // iconSize: 30,

                                  // buttonDecoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(4),
                                  //   color: ColorApp.fieldColor,
                                  // ),
                                  // // buttonElevation: 2,
                                  // // itemHeight: 40,
                                  // itemPadding:
                                  //     EdgeInsets.symmetric(horizontal: 0),
                                  // dropdownMaxHeight: 200,
                                  // // dropdownWidth: 264,
                                  // dropdownPadding: EdgeInsets.all(0),
                                  // dropdownDecoration: BoxDecoration(
                                  //   color: ColorApp.defaultBackgroundColor,
                                  //   borderRadius: BorderRadius.circular(4),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: (dropdownValue.isNotEmpty)
                                ? () {
                                    setState(() {
                                      currentDestination = dropdownValue;
                                    });
                                    Navigator.of(context).pop();
                                  }
                                : null,
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: (dropdownValue.isNotEmpty)
                                      ? primaryMain
                                      : ColorApp.disabledText,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  'Save'.i18n(),
                                  style: buttonStyle(
                                    (ColorApp.defaultBackgroundColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
  String time = "";
  Timer() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              contentPadding: EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "choose_time_text".i18n(),
                                  textAlign: TextAlign.center,
                                  style: subtitleStyle(ColorApp.secondaryText),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/cancel.svg",
                                    width: 13,
                                    height: 13,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: ColorApp.secondaryText.withOpacity(0.5),
                          ),
                          IntrinsicHeight(
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 30),
                                height: 176,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (firsthour < 2) {
                                                  firsthour++;
                                                  if (secondhour > firsthour) {
                                                    secondhour = 0;
                                                  }
                                                }
                                              });
                                              if (kDebugMode) {
                                                print(firsthour.toString());
                                              }
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_up,
                                              size: 35,
                                              color: ColorApp.disabledText,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        IntrinsicHeight(
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: ColorApp
                                                            .disabledText))),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  firsthour.toString(),
                                                  style: titleStyle(
                                                      ColorApp.secondaryText),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (firsthour > 0) firsthour--;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 35,
                                              color: ColorApp.disabledText,
                                            ))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (firsthour > 1) {
                                                  if (secondhour < 3) {
                                                    secondhour++;
                                                  }
                                                } else {
                                                  if (secondhour < 9)
                                                    secondhour++;
                                                  if (secondminute == 9 &&
                                                      firstminute == 5) {
                                                    firstminute = 0;
                                                    secondminute = 0;
                                                  }
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_up,
                                              size: 35,
                                              color: ColorApp.disabledText,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        IntrinsicHeight(
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: ColorApp
                                                            .disabledText))),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  secondhour.toString(),
                                                  style: titleStyle(
                                                      ColorApp.secondaryText),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (secondhour > 0)
                                                  secondhour--;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 35,
                                              color: ColorApp.disabledText,
                                            ))
                                      ],
                                    ),
                                    Text(
                                      ":",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorApp.disabledText,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (firstminute < 5)
                                                  firstminute++;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_up,
                                              size: 35,
                                              color: ColorApp.disabledText,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        IntrinsicHeight(
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: ColorApp
                                                            .disabledText))),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  firstminute.toString(),
                                                  style: titleStyle(
                                                      ColorApp.secondaryText),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (firstminute > 0)
                                                  firstminute--;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 35,
                                              color: ColorApp.disabledText,
                                            ))
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (secondminute < 9)
                                                  secondminute++;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.keyboard_arrow_up,
                                              size: 35,
                                              color: ColorApp.disabledText,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        IntrinsicHeight(
                                          child: Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: ColorApp
                                                            .disabledText))),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  secondminute.toString(),
                                                  style: titleStyle(
                                                      ColorApp.secondaryText),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onLongPress: () {
                                            // setState(() {
                                            //   for (secondminute in 0)
                                            //     secondminute--;
                                            // });
                                          },
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (secondminute > 0)
                                                    secondminute--;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 35,
                                                color: ColorApp.disabledText,
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          ),
                          IntrinsicWidth(
                            child: Container(
                              height: 48,
                              width: 328,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                color: primaryMain,
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(
                                      () {
                                        time =
                                            "$firsthour$secondhour:$firstminute$secondminute";
                                      },
                                    );
                                  },
                                  child: Text(
                                    "done_text".i18n(),
                                    style: buttonStyle(
                                        ColorApp.defaultBackgroundColor),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Container page1() => Container(
        margin: EdgeInsets.only(
            left: mediaQuery(context).width * .05,
            right: mediaQuery(context).width * .05,
            top: 60),

        // margin: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: mediaQuery(context).width * .05),
              child: Text(
                'personnal_info_text'.i18n(),
                style: bodyBoldStyle(ColorApp.secondaryText),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: mediaQuery(context).width * .04),
              child: Container(
                  height: 296,
                  width: double.infinity,
                  child: Container(
                      decoration: BoxDecoration(
                        color: ColorApp.defaultBackgroundColor,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: ColorApp.shadowColor,
                            blurRadius: 9,
                            spreadRadius: 4,
                            offset: Offset(-3, 2),
                          ),
                        ],
                      ),
                      // padding: EdgeInsets.all(8),
                      child: Container(
                        padding:
                            EdgeInsets.all(mediaQuery(context).width * .05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text('first_name_text'.i18n(),
                                style: bodyStyle(ColorApp.secondaryText)),
                            SizedBox(
                              height: mediaQuery(context).width * .02,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ColorApp.fieldColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextFormField(
                                cursorColor: primaryMain,
                                initialValue: firstName,
                                obscureText: false,
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    isTyping = false;
                                  });
                                },
                                onChanged: ((value) => {
                                      if (value.isNotEmpty)
                                        {
                                          setState(() {
                                            fieldinitValue = value.trim();
                                            isTyping = true;
                                          })
                                        }
                                      else
                                        {
                                          setState(() {
                                            isTyping = false;
                                          })
                                        },
                                      setState(
                                        () {
                                          firstName = value.trim();
                                        },
                                      )
                                    }),
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: mediaQuery(context).width * .03,
                                      bottom: mediaQuery(context).width * .02),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        color: primaryMain,
                                        width: 1,
                                      )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        color: errorMain,
                                        width: 1,
                                      )),
                                  hintText: 'first_name_hint_text'.i18n(),
                                  hintStyle:
                                      bodyLightStyle(ColorApp.secondaryText),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery(context).width * .05,
                            ),
                            Text('last_name_text'.i18n(),
                                style: bodyStyle(ColorApp.secondaryText)),
                            SizedBox(
                              height: mediaQuery(context).width * .02,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ColorApp.fieldColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextFormField(
                                cursorColor: primaryMain,
                                initialValue: lastName,
                                obscureText: false,
                                onChanged: ((value) => {
                                      setState((() {
                                        lastName = value.trim();
                                      }))
                                    }),
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: mediaQuery(context).width * .03,
                                      bottom: mediaQuery(context).width * .02),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        color: primaryMain,
                                        width: 1,
                                      )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        color: errorMain,
                                        width: 1,
                                      )),
                                  hintText: 'last_name_hint_text'.i18n(),
                                  hintStyle:
                                      bodyLightStyle(ColorApp.secondaryText),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mediaQuery(context).width * .05,
                            ),
                            Text('phone_number_text'.i18n(),
                                style: bodyStyle(ColorApp.secondaryText)),
                            SizedBox(
                              height: mediaQuery(context).width * .02,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: ColorApp.fieldColor,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: TextFormField(
                                cursorColor: primaryMain,
                                initialValue: phoneNumb,
                                obscureText: false,
                                onChanged: ((value) => {
                                      if (value.length == 9)
                                        {
                                          setState((() {
                                            phoneNumb = value.trim();
                                          }))
                                        }
                                      else
                                        {
                                          setState(
                                            () {
                                              phoneNumb = "";
                                            },
                                          )
                                        }
                                    }),
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: false, decimal: true),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: mediaQuery(context).width * .03,
                                      bottom: mediaQuery(context).width * .02),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        color: primaryMain,
                                        width: 1,
                                      )),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        color: errorMain,
                                        width: 1,
                                      )),
                                  hintText: 'phone_number_hint_text'.i18n(),
                                  hintStyle:
                                      bodyLightStyle(ColorApp.secondaryText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaQuery(context).width * .01),
              child: Text(
                'number_of_place_text'.i18n(),
                style: bodyBoldStyle(ColorApp.secondaryText),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: mediaQuery(context).width * .04),
                height: 72,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorApp.defaultBackgroundColor,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: ColorApp.shadowColor,
                        blurRadius: 9,
                        spreadRadius: 4,
                        offset: Offset(-3, 2),
                      ),
                    ],
                  ),
                  // padding: EdgeInsets.all(8),
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: mediaQuery(context).width * .04,
                          horizontal: mediaQuery(context).width * .038),
                      child: Container(
                        height: mediaQuery(context).width * .12,
                        width: double.infinity,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                RemoveCounter();
                              },
                              child: Container(
                                height: mediaQuery(context).width * .12,
                                width: mediaQuery(context).width * .12,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: const Radius.circular(4),
                                    bottomLeft: const Radius.circular(4),
                                  ),
                                  color: Counter > 1
                                      ? primaryMain
                                      : ColorApp.disabledText,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: ColorApp.defaultBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorApp.fieldColor,
                                  ),
                                  child: TextFormField(
                                    style: bodyFieldStyle(primaryMain),
                                    textAlign: TextAlign.center,
                                    // key: Key(textContent.toString()),
                                    initialValue: "$Counter",
                                    key: Key(Counter.toString()),
                                    onChanged: ((value) => {
                                          if (kDebugMode)
                                            {
                                              print(value),
                                            },
                                          if (value.isNotEmpty)
                                            {Counter = int.parse(value)}
                                          else
                                            {Counter = 1},
                                        }),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: false, decimal: true),
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(0)),
                                          borderSide: BorderSide(
                                            color: primaryMain,
                                            width: 1,
                                          )),
                                      border: InputBorder.none,
                                    ),
                                  )
                                  // textField(planerConfigs[indexConfig]
                                  //     .timeTravelModList[ind]
                                  //     .price),
                                  // Center(
                                  //   child: Text("${timeTravelModel[index].price}",
                                  //       style: bodyStyle(primaryMain)),
                                  // ),
                                  ),
                            ),
                            InkWell(
                              onTap: () {
                                AddCounter();
                                // addPrice();
                              },
                              child: Container(
                                height: mediaQuery(context).width * .12,
                                width: mediaQuery(context).width * .12,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topRight: const Radius.circular(4),
                                    bottomRight: const Radius.circular(4),
                                  ),
                                  color: primaryMain,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: ColorApp.defaultBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                )),
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Text(
                'location_text'.i18n(),
                style: bodyBoldStyle(ColorApp.secondaryText),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(mediaQuery(context).width * .04),
              height: 80,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: ColorApp.defaultBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: ColorApp.shadowColor,
                    blurRadius: 9,
                    spreadRadius: 4,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Container(
                height: 48,
                width: double.infinity,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: separatedContainer(
                              choice: false,
                              label: 'departure_text'.i18n(),
                              value: "agencyCity"),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: Color(0xffF5F5F5),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              await ChooseDestination();
                              if (kDebugMode) {
                                print("Destination active");
                                print(currentDestination.toString());
                              }
                              setState(() {});
                            },
                            child: separatedContainer(
                                choice: true,
                                label: 'destination_text'.i18n(),
                                value: currentDestination.toString()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery(context).width * .05,
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Text(
                'departure_date_time_text'.i18n(),
                style: bodyBoldStyle(ColorApp.secondaryText),
              ),
            ),
            SizedBox(
              height: mediaQuery(context).width * .04,
            ),
            Container(
              padding: EdgeInsets.all(mediaQuery(context).width * .04),
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorApp.defaultBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: ColorApp.shadowColor,
                    blurRadius: 9,
                    spreadRadius: 4,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Container(
                height: 48,
                width: double.infinity,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (kDebugMode) {
                                print("Active date ");
                              }
                              setState(() {
                                showDatePicker = true;
                              });
                              // ChoseDate();
                            },
                            child: separatedContainer(
                                choice: true,
                                label: 'booking_date_label'.i18n(),
                                value: finalSelectedDate),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: Color(0xffF5F5F5),
                      ),
                      Expanded(
                          child: Center(
                              child: GestureDetector(
                        onTap: (() async {
                          if (kDebugMode) {
                            print("timer active");
                          }
                          await Timer();
                          setState((() {}));
                          if (kDebugMode) {
                            print(time.toString());
                          }
                        }),
                        child: separatedContainer(
                            choice: true,
                            label: 'booking_time_label'.i18n(),
                            value: time),
                      )))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery(context).height * 0.22,
            )
          ],
        ),
      );
  Widget page2(List<Widget> trip) => GestureDetector(
        onTap: (() {
          if (kDebugMode) {
            print(trip);
          }
        }),
        child: SingleChildScrollView(
          child: Column(
            children: trip,
          ),
        ),
      );
  // bool mobilepay = false;
  bool phoneNumber = false;
  bool isCash = true;
  String phoneInitValue = '';
  String selectedTab = tabs[0];
  Widget TabElement(String label) {
    return Expanded(
        child: InkWell(
      onTap: () {
        setState(() {
          selectedTab = label;
          if (label == 'Mobile') {
            // mobilepay = true;
            isCash = false;
            isTyping = false;
            phoneInitValue = "";
            isValidPhoneNumber = false;
          } else {
            // mobilepay = false;
            isCash = true;
            phoneNumber = true;
            isValidPhoneNumber = true;
          }
        });
      },
      child: Container(
        // margin: EdgeInsets.all(4),
        height: double.infinity,
        decoration: (selectedTab == label)
            ? BoxDecoration(
                color: ColorApp.defaultBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorApp.shadowColor,
                    blurRadius: 4,
                    offset: Offset(-2, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(4),
              )
            : null,
        child: Center(
          child: Text(
            (label == 'Cash') ? 'Cash' : 'Mobile',
            style: (selectedTab == label)
                ? bodyBoldStyle(ColorApp.secondaryText)
                : bodyStyle(ColorApp.defaultBackgroundColor),
          ),
        ),
      ),
    ));
  }

  Widget mobilepaybutton({required String label, required bool color}) {
    return Container(
      width: 140,
      height: 40,
      decoration: BoxDecoration(
          color: color ? ColorApp.defaultBackgroundColor : primaryMain,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              width: 1, color: primaryMain, style: BorderStyle.solid)),
      child: Center(
        child: Text(
          label,
          style: buttonStyle(
              color ? primaryMain : ColorApp.defaultBackgroundColor),
        ),
      ),
    );
  }

  String paymentNumber = phoneNumb;
  Widget page3() => Container(
        margin: EdgeInsets.only(
            // left: mediaQuery(context).width * .02,
            // right: mediaQuery(context).width * .02,
            top: 96),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: mediaQuery(context).width * 0.04,
              horizontal: mediaQuery(context).width * 0.04),
          child: Column(
            children: [
              !isCash
                  ? Padding(
                      padding:
                          EdgeInsets.only(top: mediaQuery(context).width * .02),
                      child: Container(
                        // width: 360,
                        // height: 80,
                        decoration: BoxDecoration(
                            color: primaryMain,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: mediaQuery(context).width * 0.06,
                              horizontal: mediaQuery(context).width * 0.05),
                          child: Text('message_ticket_create_text'.i18n(),
                              style:
                                  bodyStyle(ColorApp.defaultBackgroundColor)),
                        ),
                      ),
                    )
                  : SizedBox(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                padding: EdgeInsets.all(16),
                height: 105,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorApp.defaultBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: ColorApp.shadowColor,
                      blurRadius: 9,
                      spreadRadius: 4,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'ticket_name_text'.i18n(),
                              style: bodyLightStyle(ColorApp.secondaryText),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "x $Counter",
                              style: footnoteStyle(primaryMain),
                            ),
                            Spacer(),
                            Text("triplist",
                              // tripList.isNotEmpty
                              //     ? tripList[selectedTripIndex ?? 0]
                              //         .price
                              //         .toString()
                              //     : "",
                              style: bodyStyle(ColorApp.primaryText),
                            )
                          ],
                        ),
                      ),
                      // Spacer(),
                      Divider(
                        height: 1,
                        color: ColorApp.defaultBackgroundColor,
                      ),
                      // Spacer(),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'total_amount_text'.i18n(),
                              style: bodyLightStyle(ColorApp.secondaryText),
                            ),
                            Spacer(),
                            Text("30",
                              // "${tripList[selectedTripIndex ?? 0].price * Counter} XAF",
                              style: subtitleStyle(primaryMain),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 360,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: mediaQuery(context).width * 0.04,
                  ),
                  child: Text(
                    'choose_paiement_text'.i18n(),
                    style: bodyBoldStyle(ColorApp.secondaryText),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                padding: EdgeInsets.all(4),
                height: 40,
                width: double.infinity,
                color: ColorApp.fieldColor,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: tabs.map((element) {
                      return TabElement(element);
                    }).toList(),
                  ),
                ),
              ),
              !isCash
                  ? Column(
                      children: [
                        Container(
                          width: 360,
                          height: mediaQuery(context).width * .12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: mediaQuery(context).width * 0.01,
                            ),
                            child: Text(
                              !isTyping
                                  ? 'pay_this_phone_number_text'.i18n()
                                  : 'add_phone_number_text'.i18n(),
                              style: bodyBoldStyle(ColorApp.secondaryText),
                            ),
                          ),
                        ),
                        !isTyping
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16.0),
                                height: 105,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorApp.defaultBackgroundColor,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorApp.shadowColor,
                                      blurRadius: 9,
                                      spreadRadius: 4,
                                      offset: Offset(0, 12),
                                    ),
                                  ],
                                ),
                                child: IntrinsicWidth(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 52,
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  "assets/icons/momo.svg",
                                                  width: 30,
                                                  height: 20,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(phoneNumb,
                                                style: bodyStyle(
                                                    ColorApp.secondaryText))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isTyping = true;
                                                    phoneNumber = false;

                                                    isValidPhoneNumber = false;
                                                    // mobilepay = false;
                                                  });
                                                },
                                                child: mobilepaybutton(
                                                    label: 'no_text'.i18n(),
                                                    color: true)),
                                            // SizedBox(
                                            //   width:
                                            //       mediaQuery(context).width * .04,
                                            // ),
                                            GestureDetector(
                                                onTap: () async {
                                                  // Booking booking = Booking(
                                                  //   tickets: [],
                                                  //   //TODO - implement the product VIP/Classic in this value
                                                  //   product: "VIP",
                                                  //   seats: Counter.toString(),
                                                  //   amount: tripList[
                                                  //               selectedTripIndex!]
                                                  //           .price *
                                                  //       Counter,
                                                  //   bookingId: "undefined",
                                                  //   bookingNumber: "undefined",
                                                  //   channel: "app",
                                                  //   currency: "XAF",
                                                  //   vehicleType: "COSTER",
                                                  //   customerName:
                                                  //       '$firstName $lastName',
                                                  //   customerPhoneNumber:
                                                  //       phoneNumb,
                                                  //   departure: tripList[
                                                  //           selectedTripIndex!]
                                                  //       .departure,
                                                  //   destination: tripList[
                                                  //           selectedTripIndex!]
                                                  //       .destination,
                                                  //   passengers: [
                                                  //     '$firstName $lastName'
                                                  //   ],
                                                  //   payerPhoneNumber:
                                                  //       paymentNumber,
                                                  //   paymentCurrency: "XAF",
                                                  //   paymentProvider: "OM",
                                                  //   paymentReferenceId: "88",
                                                  //   price: tripList[
                                                  //           selectedTripIndex!]
                                                  //       .price,
                                                  //   status: "PENDING",
                                                  //   timestamp: int.parse((DateTime
                                                  //               .now()
                                                  //           .millisecondsSinceEpoch)
                                                  //       .toString()),
                                                  //   tripDepartureDateTime:
                                                  //       tripList[
                                                  //               selectedTripIndex!]
                                                  //           .stamp
                                                  //           .toString(),
                                                  //   tripId: tripList[
                                                  //           selectedTripIndex!]
                                                  //       .tripID,
                                                  //   tripName: "trip1",
                                                  //   unitPrice: tripList[
                                                  //           selectedTripIndex!]
                                                  //       .price,
                                                  // );
                                                  // String tmpLastName = lastName;
                                                  // String tmpFirstName =
                                                  //     firstName;
                                                  // String tmpDate = tripList[
                                                  //         selectedTripIndex!]
                                                  //     .date;
                                                  // String tmpTime = tripList[
                                                  //         selectedTripIndex!]
                                                  //     .time;

                                                  int tmpSelectedIndex =
                                                      selectedTripIndex!;
                                                  disposeAppVars();

                                                  // Map<String, String> headers =
                                                  //     {
                                                  //   'Content-Type':
                                                  //       'application/json',
                                                  //   'tenant-Domain':
                                                  //       tenantDomainApp,
                                                  //   // FirebaseRemoteConfig
                                                  //   //     .instance
                                                  //   //     .getString(
                                                  //   //         "domain"),
                                                  //   'business-process-id':
                                                  //       businessProcessId
                                                  // };
                                                  // String returnedValue =
                                                  //     await Navigator.push(
                                                  //   context,
                                                  //   SizeTransition1(
                                                  //     Summary_Quick(
                                                  //         mt: false,
                                                  //         mtn: false,
                                                  //         orange: true,
                                                  //         isCash:
                                                  //             false, //isCash
                                                  //         trip: tripList[
                                                  //             tmpSelectedIndex],
                                                  //         provider:
                                                  //             "Create ticket",
                                                  //         booking: booking,
                                                  //         headers:
                                                  //             await doHeaders()),
                                                  //   ),
                                                  // );
                                                  if (kDebugMode) {
                                                    // print(returnedValue);
                                                    // print(booking
                                                    //     .tripDepartureDateTime);
                                                  }

                                                  // if (returnedValue
                                                  //     .isNotEmpty) {
                                                  //   setState(() {
                                                  //     firstName = tmpFirstName;
                                                  //     lastName = tmpLastName;
                                                  //     phoneNumb = booking
                                                  //         .customerPhoneNumber;
                                                  //     phoneInitValue = booking
                                                  //         .payerPhoneNumber;
                                                  //     Counter = int.parse(
                                                  //         booking.seats);
                                                  //     pageIndex = 2;
                                                  //     finalSelectedDate =
                                                  //         tmpDate;
                                                  //     time = tmpTime;
                                                  //     selectedTripIndex =
                                                  //         tmpSelectedIndex;
                                                  //   });
                                                  // }
                                                  // setState(() {
                                                  //   isValidPhoneNumber = true;
                                                  // });
                                                },
                                                child: mobilepaybutton(
                                                    label: 'yes_text'.i18n(),
                                                    color: false)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : isTyping
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaQuery(context).width * .04,
                                        vertical:
                                            mediaQuery(context).width * .04),
                                    height: 104,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: ColorApp.defaultBackgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              145, 158, 171, 0.24),
                                          blurRadius: 9,
                                          spreadRadius: 4,
                                          offset: Offset(0, 12),
                                        ),
                                      ],
                                    ),
                                    child: IntrinsicWidth(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'phone_number_text'.i18n(),
                                            style: bodyStyle(
                                                ColorApp.secondaryText),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: mediaQuery(context)
                                                          .width *
                                                      .02,
                                                ),
                                                Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: ColorApp.fieldColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  child: TextFormField(
                                                    cursorColor: primaryMain,
                                                    // initialValue:
                                                    //     phoneInitValue,
                                                    obscureText: false,
                                                    onChanged: ((value) => {
                                                          setState(() {
                                                            phoneInitValue =
                                                                value;
                                                          }),
                                                          if (phoneInitValue
                                                                  .length ==
                                                              9)
                                                            {
                                                              setState(() {
                                                                isValidPhoneNumber =
                                                                    true;
                                                              })
                                                            }
                                                          else
                                                            {
                                                              setState(() {
                                                                isValidPhoneNumber =
                                                                    false;
                                                              })
                                                            }
                                                        }),
                                                    keyboardType: TextInputType
                                                        .numberWithOptions(
                                                            signed: false,
                                                            decimal: true),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: mediaQuery(
                                                                          context)
                                                                      .width *
                                                                  .03,
                                                              bottom: mediaQuery(
                                                                          context)
                                                                      .width *
                                                                  .02),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              4)),
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    primaryMain,
                                                                width: 1,
                                                              )),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              4)),
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    errorMain,
                                                                width: 1,
                                                              )),
                                                      hintText: "000 00 11 011",
                                                      hintStyle: bodyLightStyle(
                                                          ColorApp
                                                              .secondaryText),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                // ? Container(
                                //     width: 360,
                                //     height: mediaQuery(context).width * .12,
                                //     child: Padding(
                                //       padding: EdgeInsets.symmetric(
                                //         vertical:
                                //             mediaQuery(context).width * 0.01,
                                //       ),
                                //       child: Text(
                                //         mobilepay
                                //             ? 'pay_this_phone_number_text'.i18n()
                                //             : 'add_phone_number_text'.i18n(),
                                //         style: bodyBoldStyle(ColorApp.secondaryText),
                                //       ),
                                //     ),
                                //   )
                                : SizedBox(),
                        // mobilepay
                        // ? Column(
                        //     children: [
                        //       Container(
                        //         width: 360,
                        //         height: mediaQuery(context).width * .12,
                        //         child: Padding(
                        //           padding: EdgeInsets.symmetric(
                        //             vertical: mediaQuery(context).width * 0.01,
                        //           ),
                        //           child: Text(
                        //             'pay_this_phone_number_text'.i18n(),
                        //             style: bodyBoldStyle(ColorApp.secondaryText),
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 16, vertical: 16.0),
                        //         height: 105,
                        //         width: double.infinity,
                        //         decoration: BoxDecoration(
                        //           color: ColorApp.defaultBackgroundColor,
                        //           borderRadius: BorderRadius.circular(8),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: ColorApp.shadowColor,
                        //               blurRadius: 9,
                        //               spreadRadius: 4,
                        //               offset: Offset(0, 12),
                        //             ),
                        //           ],
                        //         ),
                        //         child: IntrinsicWidth(
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Expanded(
                        //                 child: Row(
                        //                   children: [
                        //                     Container(
                        //                       width: 50,
                        //                       height: 52,
                        //                       child: Center(
                        //                         child: SvgPicture.asset(
                        //                           "assets/icons/momo.svg",
                        //                           width: 30,
                        //                           height: 20,
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       width: 10,
                        //                     ),
                        //                     Text("011 000 11 00",
                        //                         style: bodyStyle(
                        //                             ColorApp.secondaryText))
                        //                   ],
                        //                 ),
                        //               ),
                        //               Expanded(
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     GestureDetector(
                        //                         onTap: (() {
                        //                           setState(() {
                        //                             phoneNumber = false;
                        //                             mobilepay = false;
                        //                           });
                        //                         }),
                        //                         child: mobilepaybutton(
                        //                             label: 'no_text'.i18n(),
                        //                             color: true)),
                        //                     // SizedBox(
                        //                     //   width:
                        //                     //       mediaQuery(context).width * .04,
                        //                     // ),
                        //                     GestureDetector(
                        //                         onTap: (() {}),
                        //                         child: mobilepaybutton(
                        //                             label: 'yes_text'.i18n(),
                        //                             color: false)),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   )
                        // : SizedBox(),
                      ],
                    )
                  : SizedBox(),
              // (!phoneNumber)
              // ? Container(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: mediaQuery(context).width * .04,
              //         vertical: mediaQuery(context).width * .04),
              //     height: 104,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       color: ColorApp.defaultBackgroundColor,
              //       borderRadius: BorderRadius.circular(8),
              //       boxShadow: [
              //         BoxShadow(
              //           color: ColorApp.shadowColor,
              //           blurRadius: 9,
              //           spreadRadius: 4,
              //           offset: Offset(0, 12),
              //         ),
              //       ],
              //     ),
              //     child: IntrinsicWidth(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'phone_number_text'.i18n(),
              //             style: bodyStyle(ColorApp.secondaryText),
              //           ),
              //           Expanded(
              //             child: Column(
              //               children: [
              //                 SizedBox(
              //                   height: mediaQuery(context).width * .02,
              //                 ),
              //                 Container(
              //                   height: 40,
              //                   decoration: BoxDecoration(
              //                     color: ColorApp.fieldColor,
              //                     borderRadius: BorderRadius.circular(4.0),
              //                   ),
              //                   child: TextFormField(
              //                     cursorColor: primaryMain,
              //                     initialValue: "",
              //                     obscureText: false,
              //                     onChanged: ((value) => {}),
              //                     keyboardType:
              //                         TextInputType.visiblePassword,
              //                     decoration: InputDecoration(
              //                       contentPadding: EdgeInsets.only(
              //                           left:
              //                               mediaQuery(context).width * .03,
              //                           bottom: mediaQuery(context).width *
              //                               .02),
              //                       border: InputBorder.none,
              //                       focusedBorder: OutlineInputBorder(
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(4)),
              //                           borderSide: BorderSide(
              //                             color: primaryMain,
              //                             width: 1,
              //                           )),
              //                       errorBorder: OutlineInputBorder(
              //                           borderRadius: BorderRadius.all(
              //                               Radius.circular(4)),
              //                           borderSide: BorderSide(
              //                             color: errorMain,
              //                             width: 1,
              //                           )),
              //                       hintText: "000 00 11 011",
              //                       hintStyle:
              //                           bodyLightStyle(ColorApp.secondaryText),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   )
              // : SizedBox(),
              SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      );

  String timestamp = "";
  @override
  Widget build(BuildContext context) {
    // setState(() {});
    // if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
    //   print("visible stepper");
    //   showBottomSheet = false;
    //   print(showBottomSheet);
    // } else {
    //   print("Invisible stepper");
    //   showBottomSheet = true;
    //   print(showBottomSheet);
    // }
    List<Widget> pages = [
      page1(),
      page2(List.generate(
          // tripList
          //     .where((element) =>
          //         (element.route!.split("-")[0]).contains(agencyCity))
          //     .toList()
          //     .where((element) =>
          //         (element.startPoint.trim()).contains(agencyLocation))
          //     .where((element) =>
          //         (element.date.trim() + " " + element.time.trim())
          //             .contains(timestamp))
          //     .toList()
          //     .length,
          3,
          (index) => GestureDetector(
                onTap: () {
                  if (kDebugMode) {
                    // print(tripList[index].time);
                  }
                  setState(() {
                    selectedTripIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: primaryMain,
                    boxShadow: [
                      BoxShadow(
                        color: ColorApp.shadowColor,
                        blurRadius: 3,
                        offset: Offset(-8, 16),
                      ),
                    ],
                    border: (selectedTripIndex == index)
                        ? Border.all(width: 2.0, color: primaryMain)
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:Container()
                  //  TripTicket(
                  //     trip: tripList
                  //         .where((element) => (element.route!.split("-")[0])
                  //             .contains(agencyCity))
                  //         .toList()
                  //         .where((element) => (element.startPoint.trim())
                  //             .contains(agencyLocation))
                  //         // .where((element) => (element.date.trim()).contains(timestamp))
                  //         .toList()[index]),
                ),
              )
              )),

//           page2(tripList
//             .where((element) =>
//                 (element.route!.split("-")[0]).contains(agencyCity))
//             .toList()
//             .where((element) =>
//                 (element.startPoint.trim()).contains(agencyLocation))
//             // .where((element) => (element.date.trim()).contains(timestamp))
//             .toList()
//             .map((Trip trip) {
//           return TripTicket(trip: trip);
//         }).toList(),
// ),

      page3()
    ];
    return Scaffold(
      backgroundColor: ColorApp.defaultBackgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          // setState(() {});
        },
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: pageIndex == 0
                      ? pages[0]
                      : pageIndex == 1
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 100,
                                  horizontal:
                                      MediaQuery.of(context).size.width * .04),
                              child: Column(
                                children: [
                                  pages[1],
                                ],
                              ),
                            )
                          : pages[2],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: CustomAppBar(
                    iconback: true,
                    label: 'Doctor Account'.i18n(),
                    context: context,
                    search: pageIndex == 1 ? true : false,
                    searchTyping: ((value) {
                      int prevValue = 0;
                      // if(value.length)
                      // print(value.length);
                      setState(() {
                        if (value.isEmpty) {
                          // tripList = tmpList;
                          // print(tmpList);
                        }
                        if (prevValue < value.length - 1) {
                          if (kDebugMode) {
                            print(value.length);
                          }
                          // tripList = tmpList
                          //     .where((element) => element.destination
                          //         .toLowerCase()
                          //         .contains(value.toLowerCase()))
                          //     .toList();
                        }
                        prevValue = value.length;
                        // tripList = tripList
                        //     .where((element) => element.destination
                        //         .toLowerCase()
                        //         .contains(value.toLowerCase()))
                        //     .toList();
                      });
                    })),
              ),
              showBottomSheet
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        )),
                        backgroundColor: ColorApp.defaultBackgroundColor,
                        enableDrag: false,
                        onClosing: () {},
                        builder: ((context) {
                          return Container(
                            height: 150.0,
                            padding: EdgeInsets.only(top: 16.0),
                            child: Column(
                              children: [
                                Text(
                                  stepInfo,
                                  style: bodyStyle(primaryMain),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 109.0,
                                      vertical: mediaQuery(context).height * .02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: pageIndex >= 0
                                                ? primaryMain
                                                : ColorApp.defaultBackgroundColor,
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: Divider(
                                          height: 20.0,
                                          color: pageIndex > 0
                                              ? primaryMain
                                              : ColorApp.defaultBackgroundColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: pageIndex >= 1
                                                ? primaryMain
                                                : ColorApp.defaultBackgroundColor,
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: Divider(
                                          height: 20.0,
                                          color: pageIndex > 1
                                              ? primaryMain
                                              : ColorApp.defaultBackgroundColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: pageIndex >= 2
                                                ? primaryMain
                                                : ColorApp.defaultBackgroundColor,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (pageIndex > 0) {
                                          setState(() {
                                            pageIndex--;
                                          });
                                        } else {
                                          return;
                                        }
                                        if (pageIndex == 0) {
                                          setState(() {
                                            stepInfo = "step1_text".i18n();
                                          });
                                        } else if (pageIndex == 1) {
                                          setState(() {
                                            stepInfo = "step2_text".i18n();
                                          });
                                        } else {
                                          setState(() {
                                            stepInfo = "step3_text".i18n();
                                          });
                                        }
                                        if (kDebugMode) {
                                          print(pageIndex);
                                        }
                                      },
                                      child: ticketButton(
                                        buttonName: 'back_text'.i18n(),
                                        buttonColor: primaryMain,
                                        icon: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: ColorApp.defaultBackgroundColor,
                                        ),
                                        position: true,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (pageIndex == 0 &&
                                            (firstName.isEmpty ||
                                                lastName.isEmpty ||
                                                phoneNumb.isEmpty ||
                                                currentDestination.isEmpty ||
                                                Counter < 0 ||
                                                finalSelectedDate.isEmpty ||
                                                time.isEmpty) &&
                                            pageIndex < 2) {
                                          return;
                                        }
                                        if (pageIndex == 1 &&
                                            selectedTripIndex == null) {
                                          return;
                                        }
                                        if (pageIndex == 2 &&
                                            (isCash || isValidPhoneNumber)) {}
                                        if (pageIndex < 2) {
                                          // DateTime tempDate = DateFormat(
                                          //         "dd.MM.yyyy hh:mm")
                                          //     .parse("$finalSelectedDate $time");
                                          // timestamp = Timestamp.fromDate(tempDate)
                                          //     .seconds
                                          //     .toString();
                                          // print(timestamp);
                                          timestamp = "$finalSelectedDate $time";
                                          setState(() {
                                            pageIndex++;
                                          });
                                        } else {
                                          if (isValidPhoneNumber) {
                                            if (isValidPhoneNumber) {
                                              // Booking booking = Booking(
                                              //   tickets: [],
                                              //   //TODO - implement the product VIP/Classic in this value
                                              //   product: "VIP",
        
                                              //   vehicleType: "COSTER",
                                              //   amount:
                                              //       tripList[selectedTripIndex!]
                                              //               .price *
                                              //           Counter,
                                              //   bookingId: "shfjdh",
                                              //   bookingNumber: "sjbhs",
                                              //   channel: "app",
                                              //   currency: "XAF",
                                              //   customerName:
                                              //       '$firstName $lastName',
                                              //   customerPhoneNumber: phoneNumb,
                                              //   departure:
                                              //       tripList[selectedTripIndex!]
                                              //           .departure,
                                              //   destination:
                                              //       tripList[selectedTripIndex!]
                                              //           .destination,
                                              //   passengers: [
                                              //     '$firstName $lastName'
                                              //   ],
                                              //   payerPhoneNumber: phoneInitValue,
                                              //   paymentCurrency: "XAF",
                                              //   paymentProvider:
                                              //       isCash ? "Cash" : "OM",
                                              //   paymentReferenceId: "88",
                                              //   price:
                                              //       tripList[selectedTripIndex!]
                                              //               .price *
                                              //           Counter,
                                              //   status: "PENDING",
                                              //   seats: Counter.toString(),
                                              //   timestamp: int.parse((DateTime
                                              //               .now()
                                              //           .millisecondsSinceEpoch)
                                              //       .toString()),
                                              //   tripDepartureDateTime:
                                              //       tripList[selectedTripIndex!]
                                              //           .stamp
                                              //           .toString(),
                                              //   tripId:
                                              //       tripList[selectedTripIndex!]
                                              //           .tripID,
                                              //   tripName:
                                              //       "${tripList[selectedTripIndex!].departure}-${tripList[selectedTripIndex!].destination}",
                                              //   unitPrice:
                                              //       tripList[selectedTripIndex!]
                                              //           .price,
                                              // );
                                              // setState(() {
                                              // String returnedValue =
                                              //     await Navigator.push(
                                              //   context,
                                              //   SizeTransition1(
                                              //     Summary_Quick(
                                              //       mt: false,
                                              //       mtn: false,
                                              //       orange: true,
                                              //       isCash: isCash,
                                              //       trip: tripList[
                                              //           selectedTripIndex!],
                                              //       provider: "Create ticket",
                                              //       booking: booking,
                                              //       headers: await doHeaders(),
                                              //     ),
                                              //   ),
                                              // );
                                              if (kDebugMode) {
                                                // print(returnedValue);
                                              }
        
                                              String tmpLastName = lastName;
                                              String tmpFirstName = firstName;
                                              // String tmpDate =
                                              //     tripList[selectedTripIndex!]
                                              //         .date;
                                              // String tmpTime =
                                              //     tripList[selectedTripIndex!]
                                              //         .time;
                                              // int tmpSelectedIndex =
                                              //     selectedTripIndex!;
                                              // disposeAppVars();
                                              // if (returnedValue.isNotEmpty) {
                                              //   setState(() {
                                              //     firstName = tmpFirstName;
                                              //     lastName = tmpLastName;
                                              //     phoneNumb =
                                              //         booking.customerPhoneNumber;
                                              //     phoneInitValue =
                                              //         booking.payerPhoneNumber;
                                              //     currentDestination =
                                              //         booking.destination;
                                              //     Counter =
                                              //         int.parse(booking.seats);
                                              //     pageIndex = 2;
                                              //     finalSelectedDate = tmpDate;
                                              //     time = tmpTime;
                                              //     selectedTripIndex =
                                              //         tmpSelectedIndex;
                                              //   });
                                              // }
                                              // nav(
                                              //     Summary_Quick(
                                              //       isCash: isCash,
                                              //       provider:
                                              //           "quick_booking_text".i18n(),
                                              //       booking: booking,
                                              //     ),
                                              //     context);
                                              // nav(
                                              //     Summary_Quick(
                                              //       isCash: isCash,
                                              //       provider: "Create ticket",
                                              //     ),
                                              //     context);
                                            }
                                          }
                                          if (pageIndex == 0) {
                                            setState(() {
                                              stepInfo = "step1_text".i18n();
                                            });
                                          } else if (pageIndex == 1) {
                                            setState(() {
                                              stepInfo = "step2_text".i18n();
                                            });
                                          } else {
                                            setState(() {
                                              stepInfo = "step3_text".i18n();
                                            });
                                          }
                                        }
                                        // print(pageIndex);
                                      },
                                      child: ticketButton(
                                          buttonName: 'next_text'.i18n(),
                                          buttonColor: pageIndex == 0 &&
                                                  (firstName.isEmpty ||
                                                      lastName.isEmpty ||
                                                      phoneNumb.isEmpty ||
                                                      currentDestination
                                                          .isEmpty ||
                                                      Counter < 0 ||
                                                      finalSelectedDate.isEmpty ||
                                                      time.isEmpty)
                                              ? ColorApp.disabledText
                                              : (isCash || isValidPhoneNumber)
                                                  ? primaryMain
                                                  : pageIndex >= 0 || isCash
                                                      ? ColorApp.disabledText
                                                      : primaryMain,
                                          icon: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color:
                                                ColorApp.defaultBackgroundColor,
                                          ),
                                          position: false),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  : SizedBox(),
              showDatePicker
                  ? Align(
                      alignment: Alignment.center,
                      child: datePicker(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Container ticketButton(
          {required String buttonName,
          required Color buttonColor,
          required Icon icon,
          bool position = true}) =>
      Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            position ? icon : SizedBox(),
            SizedBox(
              width: 10,
            ),
            Text(buttonName,
                style: buttonStyle(ColorApp.defaultBackgroundColor)),
            SizedBox(
              width: 10,
            ),
            !position ? icon : SizedBox(),
          ],
        ),
      );
}