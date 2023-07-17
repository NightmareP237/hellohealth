import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hellohealth/screens/home/loading-page.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:shared_preferences/shared_preferences.dart';
import '../../ressources/const.dart';

class AddDoctorScreen extends StatefulWidget {
  AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

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
bool showBottomSheet = true;
String jwToken = "";

bool isLoading = false;

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  String Route = 'road_text'.i18n();
  String currentRouteValue = 'road_label'.i18n();
  String selectedRouteValue = 'road_label'.i18n();
  String? currentStartPoint = 'start_point_label'.i18n();
  String selectedStartPoint = 'start_point_label'.i18n();
  String? currentArrivalPoint = 'arrival_point_label'.i18n();
  String selectedArrivalPoint = 'arrival_point_label'.i18n();
  bool change = false;

  void dispose() {
    super.dispose();
    isLoading = false;
  }

  @override
  void initState() {
    // CrashUserIdentifier(currentUserId!);
    // TODO: implement initState
    super.initState();
    ;
  }

  bool showDatePicker = false;

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
                          setState(() {
                            // selectedDay = label;
                            if (kDebugMode) {
                              print(defaultSelectedDay);
                            }
                            showDatePicker = false;

                            if (selectedDay < 10) {
                              finalDay = "0$selectedDay";
                            } else {
                              finalDay = "$selectedDay";
                            }
                            if (currentMounthIndex < 9) {
                              finalMonth = "0";
                            } else {
                              finalMonth = "";
                            }
                            finalSelectedDate =
                                "$finalDay.$finalMonth${currentMounthIndex + 1}.2023";
                            if (kDebugMode) {
                              print(finalSelectedDate);
                            }
                          });
                          finalSelectedDate = selectedDay.toString() +
                              ".0" +
                              (currentMounthIndex + 1).toString() +
                              ".2023";
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

  String finalDay = "";
  String finalMonth = "";
  Widget DaySelection(int label) {
    return InkWell(
      onTap: () {
        setState(() {
          String val;
          selectedDay = label;
          if (kDebugMode) {
            print(defaultSelectedDay);
          }
          (currentMounthIndex >= 9) ? val = '' : val = "0";
          finalSelectedDate = selectedDay.toString() +
              ".$val" +
              (currentMounthIndex + 1).toString() +
              ".2023";
          if (kDebugMode) {
            print(finalSelectedDate.length);
          }
          // getDate!();
          // Navigator.pop(context);
          (finalSelectedDate.length <= 9)
              ? finalSelectedDate = '0$finalSelectedDate'
              : finalSelectedDate = '$finalSelectedDate';
          if (kDebugMode) {
            print(finalSelectedDate);
          }
          showDatePicker = false;
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
          mounthsMin[currentMounthIndex] + " " + defaultSelectedYear.toString(),
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

  bool loader = true;
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
                                              color: ColorApp.blackWhiteColor,
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
                                                            .defaultBackgroundColor))),
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
                                              color: ColorApp.blackWhiteColor,
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
                                              color: ColorApp.blackWhiteColor,
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
                                                            .defaultBackgroundColor))),
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
                                              color: ColorApp.blackWhiteColor,
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
                                              color: ColorApp.blackWhiteColor,
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
                                                            .defaultBackgroundColor))),
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
                                              color: ColorApp.blackWhiteColor,
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
                                              color: ColorApp.blackWhiteColor,
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
                                                            .defaultBackgroundColor))),
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
                                                color: ColorApp.blackWhiteColor,
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
                                        time = firsthour.toString() +
                                            secondhour.toString() +
                                            ":" +
                                            firstminute.toString() +
                                            secondminute.toString();
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

//TODO this place required a translation in french and English
  // String currentRouteValue = 'road_label'.i18n();
  // String selectedRouteValue = 'road_label'.i18n();
  // String Route = 'road_text'.i18n();
  String? currentbusnumber = 'choose_Car_bus_number_text'.i18n();
  String selectedbusnumber = 'choose_Car_bus_number_text'.i18n();
  String? currentTriptype = 'please_choose_type_text'.i18n();
  String selectedTriptype = 'please_choose_type_text'.i18n();
  String rout = "DLA-YDE";
  bool click = false;
  bool choose = false;
  bool choose1 = false;
  bool errorCar1 = false;
  bool choose2 = false;
  bool errorCar = false;
  bool errorCar2 = false;
  bool errorCar3 = false;
  bool swich = true;
  bool swich1 = true;
  String price = '';
  @override
  Widget build(BuildContext context) {
    // int Counter = 30;
    // var valueint = masterOptions
    //     .where((element) => (element.id).contains(selectedTriptype))
    //     .map((e) {
    //   Counter = e.capacity;
    //   if (kDebugMode) {
    //     print(Counter);
    //   }
    //   return Counter;
    // }).toList();
    // String? departure;
    // String? destination;
    // var departures = masterRoutes
    //     .where((element) => (element.routeId).contains(selectedRouteValue))
    //     .map((e) {
    //   departure = e.departure;
    //   destination = e.destination;
    //   if (kDebugMode) {
    //     print(departure! + " " + destination!);
    //   }
    //   return departure;
    // }).toList();
    // if (kDebugMode) {
    //   print(destination);
    //   print(valueint.isEmpty ? "30" : valueint[0].toString());
    // }
    // void RemoveCounter() {
    //   if (Counter > 1) {
    //     setState(() {
    //       valueint.isEmpty ? Counter-- : valueint[0]--;
    //     });
    //   }
    //   // print(valueint[0]);
    // }

    // bool status = false;
    // void AddCounter() {
    //   setState(() {
    //     valueint.isEmpty ? Counter++ : valueint[0]++;
    //   });
    //   if (kDebugMode) {
    //     print(valueint.isEmpty ? "30" : valueint[0].toString());
    //   }
    // }

    // var Voyage = currentRouteValue.split('-');
    // var startpoint = masterRoutes
    //     .where((element) => (element.routeId).contains(selectedRouteValue))
    //     .map((item) {
    //   String start = '';
    //   start = item.startPoint;
    //   // print(start);
    //   return start;
    // }).toList();
    // var arivalpoint = masterRoutes
    //     .where((element) => (element.routeId).contains(selectedRouteValue))
    //     .map((item) {
    //   String end = '';
    //   end = item.arrivalPoint;
    //   // print(end);
    //   return end;
    // }).toList();
    // var OptionList = masterOptions.map((item) {
    //   return item.id;
    // }).toList();
    ColorApp().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 96),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: mediaQuery(context).width * 0.04,
                        horizontal: mediaQuery(context).width * 0.04),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: mediaQuery(context).width * .02),
                            child: Text(
                              'Entrer  votre nom'.i18n(),
                              style: bodyBoldStyle(ColorApp.secondaryText),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: mediaQuery(context).width * .04),
                          child: Container(
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
                                    padding: EdgeInsets.all(
                                        mediaQuery(context).width * .029),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IntrinsicHeight(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: ColorApp.fieldColor,
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: TextFormField(
                                              cursorColor: primaryMain,
                                              initialValue: "",
                                              obscureText: false,
                                              onChanged: ((value) => {
                                                    setState(() {
                                                      price = value;
                                                    }),
                                                    if (kDebugMode)
                                                      {
                                                        print(price),
                                                      }
                                                  }),
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      signed: false,
                                                      decimal: true),
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                  left: mediaQuery(context)
                                                          .width *
                                                      .03,
                                                ),
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        borderSide: BorderSide(
                                                          color: primaryMain,
                                                          width: 1,
                                                        )),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                    borderSide: BorderSide(
                                                      color: errorMain,
                                                      width: 1,
                                                    )),
                                                hintText:
                                                    'enter_price_text'.i18n(),
                                                hintStyle: bodyLightStyle(
                                                    ColorApp.secondaryText),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: mediaQuery(context).width * .04),
                          child: IntrinsicHeight(
                            child: Container(
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaQuery(context).width * .04,
                                        vertical:
                                            mediaQuery(context).height * .02,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("route_label".i18n(),
                                              style: bodyStyle(
                                                  ColorApp.secondaryText)),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: mediaQuery(context)
                                                          .width *
                                                      .02),
                                              child: Container(
                                                height:
                                                    mediaQuery(context).width *
                                                        .12,
                                                width: double.infinity,
                                                child: Container(
                                                  height: 40,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    // ignore: dead_code
                                                    border: errorCar
                                                        ? Border.all(
                                                            width: 1,
                                                            color: primaryMain)
                                                        : null,
                                                    color: ColorApp.fieldColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2(
                                                        style: TextStyle(
                                                          color: primaryMain,
                                                          background: Paint()
                                                            ..color,
                                                        ),
                                                        // dropdownFullScreen:
                                                        //     true,
                                                        // dropdownWidth: 200,
                                                        hint: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: Text(
                                                            selectedRouteValue,
                                                            style: bodyStyle(
                                                                ColorApp
                                                                    .secondaryText),
                                                          ),
                                                        ),
                                                        onMenuStateChange:
                                                            (val) {
                                                          setState(() {
                                                            click = val;
                                                          });
                                                        },

                                                        isExpanded: true,
                                                        items: []
                                                            .map((item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                                  value: item
                                                                      .routeId,
                                                                  child: (item.routeId
                                                                              .trim()
                                                                              .toLowerCase() ==
                                                                          selectedRouteValue
                                                                              .trim()
                                                                              .toLowerCase())
                                                                      ? Container(
                                                                          height:
                                                                              double.infinity,
                                                                          width:
                                                                              double.infinity,
                                                                          color: const Color.fromRGBO(
                                                                              61,
                                                                              214,
                                                                              208,
                                                                              0.2),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                              child: Text(
                                                                                item.routeId,
                                                                                style: bodyStyle(ColorApp.secondaryText),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 8.0),
                                                                          child:
                                                                              Text(
                                                                            item.routeId,
                                                                            style:
                                                                                bodyStyle(ColorApp.secondaryText),
                                                                          ),
                                                                        ),
                                                                ))
                                                            .toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedRouteValue =
                                                                value as String;
                                                            currentRouteValue =
                                                                selectedRouteValue;
                                                            change = true;
                                                            errorCar = true;
                                                            setState(() {
                                                              choose = true;
                                                            });
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        3000),
                                                                () {
                                                              setState(() {
                                                                choose = true;
                                                                errorCar =
                                                                    false;
                                                              });
                                                            });
                                                          });
                                                          bool news = false;
                                                          [].where((element) =>
                                                              (element.routeId)
                                                                      .contains(
                                                                          selectedRouteValue)
                                                                  ? news = true
                                                                  : news =
                                                                      false);
                                                          news
                                                              ? setState(() {
                                                                  selectedRouteValue =
                                                                      value
                                                                          as String;
                                                                  currentRouteValue =
                                                                      selectedRouteValue;
                                                                  change = true;
                                                                  errorCar =
                                                                      true;
                                                                  setState(() {
                                                                    choose =
                                                                        true;
                                                                  });
                                                                  Future.delayed(
                                                                      const Duration(
                                                                          milliseconds:
                                                                              3000),
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      choose =
                                                                          true;
                                                                      errorCar =
                                                                          false;
                                                                    });
                                                                  });
                                                                })
                                                              : setState(() {
                                                                  selectedArrivalPoint =
                                                                      'arrival_point_label'
                                                                          .i18n();
                                                                  selectedStartPoint =
                                                                      'start_point_label'
                                                                          .i18n();
                                                                });
                                                          Route =
                                                              selectedRouteValue;
                                                          if (kDebugMode) {
                                                            print(
                                                                selectedRouteValue);
                                                          }
                                                        },
                                                        // icon: Icon(
                                                        //   Icons
                                                        //       .keyboard_arrow_down_rounded,
                                                        //   color: ColorApp
                                                        //       .secondaryText,
                                                        // ),
                                                        // iconSize: 30,
                                                        // buttonDecoration:
                                                        //     BoxDecoration(
                                                        //   borderRadius:
                                                        //       BorderRadius
                                                        //           .circular(4),
                                                        //   color: ColorApp
                                                        //       .fieldColor,
                                                        // ),
                                                        // // buttonElevation: 2,
                                                        // // itemHeight: 40,
                                                        // itemPadding: EdgeInsets
                                                        //     .symmetric(
                                                        //         horizontal: 0),
                                                        // dropdownMaxHeight: 200,
                                                        // // dropdownWidth: 264,
                                                        // dropdownPadding:
                                                        //     EdgeInsets.all(0),
                                                        // dropdownDecoration:
                                                        //     BoxDecoration(
                                                        //         borderRadius:
                                                        //             BorderRadius
                                                        //                 .circular(
                                                        //                     4),
                                                        //         color: ColorApp
                                                        //             .defaultBackgroundColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height:
                                                mediaQuery(context).width * .02,
                                          ),
                                          Text('sum_start_point_label'.i18n(),
                                              style: bodyStyle(
                                                  ColorApp.secondaryText)),
                                          SizedBox(
                                            height:
                                                mediaQuery(context).width * .02,
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: mediaQuery(context)
                                                          .width *
                                                      .02),
                                              child: Container(
                                                height:
                                                    mediaQuery(context).width *
                                                        .12,
                                                width: double.infinity,
                                                child: Container(
                                                  height: 40,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: errorCar1
                                                        ? Border.all(
                                                            width: 1,
                                                            color: primaryMain)
                                                        : null,
                                                    color: ColorApp.fieldColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2<
                                                          String>(
                                                        hint: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: Text(
                                                            selectedStartPoint,
                                                            style: bodyStyle(
                                                                ColorApp
                                                                    .secondaryText),
                                                          ),
                                                        ),
                                                        // onMenuStateChange:
                                                        //     (val) {
                                                        //   setState(() {
                                                        //     click = val;
                                                        //     // print(val);
                                                        //   });
                                                        //   if (kDebugMode) {
                                                        //     print(click);
                                                        //   }
                                                        // },
                                                        isExpanded: true,
                                                        items: [].isEmpty
                                                            ? []
                                                            : [][0]
                                                                .split(",")
                                                                .map((item) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: item,
                                                                  child: (item
                                                                              .trim()
                                                                              .toLowerCase() ==
                                                                          selectedStartPoint
                                                                              .trim()
                                                                              .toLowerCase())
                                                                      ? Container(
                                                                          height:
                                                                              double.infinity,
                                                                          width:
                                                                              double.infinity,
                                                                          color: const Color.fromRGBO(
                                                                              61,
                                                                              214,
                                                                              208,
                                                                              0.2),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                                              child: Text(
                                                                                item,
                                                                                style: bodyStyle(ColorApp.secondaryText),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 8.0),
                                                                          child:
                                                                              Text(
                                                                            item,
                                                                            style:
                                                                                bodyStyle(ColorApp.secondaryText),
                                                                          ),
                                                                        ),
                                                                );
                                                              }).toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedStartPoint =
                                                                value as String;
                                                            currentStartPoint =
                                                                selectedStartPoint;
                                                            change = true;
                                                            errorCar1 = true;
                                                            setState(() {
                                                              choose1 = true;
                                                            });
                                                            Future.delayed(
                                                                Duration(
                                                                    milliseconds:
                                                                        3000),
                                                                () {
                                                              setState(() {
                                                                errorCar1 =
                                                                    false;
                                                              });
                                                            });
                                                          });
                                                          Route =
                                                              selectedStartPoint;
                                                          if (kDebugMode) {
                                                            print(
                                                                selectedStartPoint);
                                                          }
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 50,
                                                          width: 160,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 14,
                                                                  right: 14),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                            ),
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          elevation: 2,
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.yellow,
                                                          iconDisabledColor:
                                                              Colors.grey,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          maxHeight: 200,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          offset: const Offset(
                                                              -20, 0),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                MaterialStateProperty
                                                                    .all(6),
                                                            thumbVisibility:
                                                                MaterialStateProperty
                                                                    .all(true),
                                                          ),
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 40,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 14,
                                                                  right: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height:
                                                mediaQuery(context).width * .02,
                                          ),
                                          Text('arrival_point_label'.i18n(),
                                              style: bodyStyle(
                                                  ColorApp.secondaryText)),
                                          SizedBox(
                                            height:
                                                mediaQuery(context).width * .02,
                                          ),
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: mediaQuery(context)
                                                          .width *
                                                      .02),
                                              child: Container(
                                                height:
                                                    mediaQuery(context).width *
                                                        .12,
                                                width: double.infinity,
                                                child: Container(
                                                  height: 40,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    // ignore: dead_code
                                                    border: errorCar3
                                                        ? Border.all(
                                                            width: 1,
                                                            color: primaryMain)
                                                        : null,
                                                    color: ColorApp.fieldColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2<
                                                          String>(
                                                        hint: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12),
                                                          child: Text(
                                                            selectedArrivalPoint,
                                                            style: bodyStyle(
                                                                ColorApp
                                                                    .secondaryText),
                                                          ),
                                                        ),
                                                        onMenuStateChange:
                                                            (val) {
                                                          setState(() {
                                                            click = val;
                                                            // print(val);
                                                          });
                                                        },
                                                        isExpanded: true,
                                                        items: [].isEmpty
                                                            ? []
                                                            : [][0]
                                                                .split(",")
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          item,
                                                                      child: (item.trim().toLowerCase() ==
                                                                              selectedArrivalPoint.trim().toLowerCase())
                                                                          ? Container(
                                                                              height: double.infinity,
                                                                              width: double.infinity,
                                                                              color: Color.fromRGBO(61, 214, 208, 0.2),
                                                                              child: Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                                                  child: Text(
                                                                                    item,
                                                                                    style: bodyStyle(ColorApp.secondaryText),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                                              child: Text(
                                                                                item,
                                                                                style: bodyStyle(ColorApp.secondaryText),
                                                                              ),
                                                                            ),
                                                                    ))
                                                                .toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedArrivalPoint =
                                                                value as String;
                                                            currentArrivalPoint =
                                                                selectedArrivalPoint;
                                                            change = true;
                                                            errorCar3 = true;
                                                            setState(() {
                                                              choose2 = true;
                                                            });
                                                            Future.delayed(
                                                                Duration(
                                                                    milliseconds:
                                                                        3000),
                                                                () {
                                                              setState(() {
                                                                errorCar3 =
                                                                    false;
                                                              });
                                                            });
                                                          });
                                                          Route =
                                                              selectedArrivalPoint;
                                                          if (kDebugMode) {
                                                            print(
                                                                selectedArrivalPoint);
                                                          }
                                                        },
                                                        buttonStyleData:
                                                            ButtonStyleData(
                                                          height: 50,
                                                          width: 160,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 14,
                                                                  right: 14),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                            border: Border.all(
                                                              color: Colors
                                                                  .black26,
                                                            ),
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          elevation: 2,
                                                        ),
                                                        iconStyleData:
                                                            const IconStyleData(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_forward_ios_outlined,
                                                          ),
                                                          iconSize: 14,
                                                          iconEnabledColor:
                                                              Colors.yellow,
                                                          iconDisabledColor:
                                                              Colors.grey,
                                                        ),
                                                        dropdownStyleData:
                                                            DropdownStyleData(
                                                          maxHeight: 200,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                            color: Colors
                                                                .redAccent,
                                                          ),
                                                          offset: const Offset(
                                                              -20, 0),
                                                          scrollbarTheme:
                                                              ScrollbarThemeData(
                                                            radius: const Radius
                                                                .circular(40),
                                                            thickness:
                                                                MaterialStateProperty
                                                                    .all(6),
                                                            thumbVisibility:
                                                                MaterialStateProperty
                                                                    .all(true),
                                                          ),
                                                        ),
                                                        menuItemStyleData:
                                                            const MenuItemStyleData(
                                                          height: 40,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 14,
                                                                  right: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ))),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: mediaQuery(context).width * .01),
                            child: Text(
                              'price_text'.i18n(),
                              style: bodyBoldStyle(ColorApp.secondaryText),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: mediaQuery(context).width * .04),
                          child: Container(
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
                                    padding: EdgeInsets.all(
                                        mediaQuery(context).width * .029),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IntrinsicHeight(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: ColorApp.fieldColor,
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: TextFormField(
                                              cursorColor: primaryMain,
                                              initialValue: "",
                                              obscureText: false,
                                              onChanged: ((value) => {
                                                    setState(() {
                                                      price = value;
                                                    }),
                                                    if (kDebugMode)
                                                      {
                                                        print(price),
                                                      }
                                                  }),
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      signed: false,
                                                      decimal: true),
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                  left: mediaQuery(context)
                                                          .width *
                                                      .03,
                                                ),
                                                border: InputBorder.none,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4)),
                                                        borderSide: BorderSide(
                                                          color: primaryMain,
                                                          width: 1,
                                                        )),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(4)),
                                                    borderSide: BorderSide(
                                                      color: errorMain,
                                                      width: 1,
                                                    )),
                                                hintText:
                                                    'enter_price_text'.i18n(),
                                                hintStyle: bodyLightStyle(
                                                    ColorApp.secondaryText),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: mediaQuery(context).width * .01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'chose_type_text'.i18n(),
                                style: bodyBoldStyle(ColorApp.secondaryText),
                              ),
                              FlutterSwitch(
                                  width: 44.0,
                                  height: 22.0,
                                  toggleSize: 15.0,
                                  value: swich1,
                                  borderRadius: 20.0,
                                  padding: 2.0,
                                  toggleColor: swich1
                                      ? primaryMain
                                      : ColorApp.primaryText,
                                  switchBorder: Border.all(
                                    color: swich1
                                        ? primaryMain
                                        : ColorApp.primaryText,
                                    width: 2.0,
                                  ),
                                  toggleBorder: Border.all(
                                    color: swich1
                                        ? primaryMain
                                        : ColorApp.primaryText,
                                    width: 5.0,
                                  ),
                                  activeColor: ColorApp.defaultBackgroundColor,
                                  inactiveColor:
                                      ColorApp.defaultBackgroundColor,
                                  onToggle: (val) {
                                    swich1 = val;
                                    if (kDebugMode) {
                                      print(swich1);
                                    }

                                    setState(() {
                                      swich1 != swich1;
                                    });
                                  })
                            ],
                          ),
                        ),
                        swich1
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: mediaQuery(context).width * .035),
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
                                          vertical:
                                              mediaQuery(context).width * .04,
                                          horizontal:
                                              mediaQuery(context).width * .038),
                                      child: Container(
                                        height: mediaQuery(context).width * .12,
                                        width: double.infinity,
                                        child: Container(
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            // ignore: dead_code
                                            border: errorCar2
                                                ? Border.all(
                                                    width: 1,
                                                    color: primaryMain)
                                                : null,
                                            color: ColorApp.fieldColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                hint: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    selectedTriptype,
                                                    style: bodyStyle(
                                                        ColorApp.secondaryText),
                                                  ),
                                                ),
                                                onMenuStateChange: (val) {
                                                  setState(() {
                                                    click = val;
                                                    // print(val);
                                                  });
                                                },
                                                isExpanded: true,
                                                items: []
                                                    .map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item.id,
                                                              child: (item.id
                                                                          .trim()
                                                                          .toLowerCase() ==
                                                                      selectedTriptype
                                                                          .trim()
                                                                          .toLowerCase())
                                                                  ? Container(
                                                                      height: double
                                                                          .infinity,
                                                                      width: double
                                                                          .infinity,
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          61,
                                                                          214,
                                                                          208,
                                                                          0.2),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 8.0),
                                                                          child:
                                                                              Text(
                                                                            item.id,
                                                                            style:
                                                                                bodyStyle(ColorApp.secondaryText),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        item.id,
                                                                        style: bodyStyle(
                                                                            ColorApp.secondaryText),
                                                                      ),
                                                                    ),
                                                            ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedTriptype =
                                                        value as String;
                                                    currentTriptype =
                                                        selectedTriptype;
                                                    change = true;
                                                    errorCar2 = true;
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 3000),
                                                        () {
                                                      setState(() {
                                                        errorCar2 = false;
                                                      });
                                                    });
                                                  });
                                                  Route = selectedTriptype;
                                                  if (kDebugMode) {
                                                    print(selectedTriptype);
                                                  }
                                                },
                                                buttonStyleData:
                                                    ButtonStyleData(
                                                  height: 50,
                                                  width: 160,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 14, right: 14),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    border: Border.all(
                                                      color: Colors.black26,
                                                    ),
                                                    color: Colors.redAccent,
                                                  ),
                                                  elevation: 2,
                                                ),
                                                iconStyleData:
                                                    const IconStyleData(
                                                  icon: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                  ),
                                                  iconSize: 14,
                                                  iconEnabledColor:
                                                      Colors.yellow,
                                                  iconDisabledColor:
                                                      Colors.grey,
                                                ),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                  maxHeight: 200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.redAccent,
                                                  ),
                                                  offset: const Offset(-20, 0),
                                                  scrollbarTheme:
                                                      ScrollbarThemeData(
                                                    radius:
                                                        const Radius.circular(
                                                            40),
                                                    thickness:
                                                        MaterialStateProperty
                                                            .all(6),
                                                    thumbVisibility:
                                                        MaterialStateProperty
                                                            .all(true),
                                                  ),
                                                ),
                                                menuItemStyleData:
                                                    const MenuItemStyleData(
                                                  height: 40,
                                                  padding: EdgeInsets.only(
                                                      left: 14, right: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ))
                            : Container(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: mediaQuery(context).width * .01),
                            child: Text(
                              'available_capacity_text'.i18n(),
                              style: bodyBoldStyle(ColorApp.secondaryText),
                            ),
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
                                      horizontal:
                                          mediaQuery(context).width * .038),
                                  child: Container(
                                    height: mediaQuery(context).width * .12,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // RemoveCounter();
                                          },
                                          child: Container(
                                            height:
                                                mediaQuery(context).width * .12,
                                            width:
                                                mediaQuery(context).width * .12,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                bottomLeft: Radius.circular(4),
                                              ),
                                              color: primaryMain,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: ColorApp
                                                    .defaultBackgroundColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height:
                                                mediaQuery(context).width * .12,
                                            width:
                                                mediaQuery(context).width * .58,
                                            decoration: BoxDecoration(
                                              color: ColorApp.fieldColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                  // valueint.isEmpty
                                                  //     ? "30"
                                                  //     : valueint[0].toString(),
                                                  "30",
                                                  style:
                                                      bodyStyle(primaryMain)),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            // AddCounter();
                                          },
                                          child: Container(
                                            height:
                                                mediaQuery(context).width * .12,
                                            width:
                                                mediaQuery(context).width * .12,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(4),
                                                bottomRight: Radius.circular(4),
                                              ),
                                              color: primaryMain,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.add,
                                                color: ColorApp
                                                    .defaultBackgroundColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: mediaQuery(context).width * .01),
                              child: Text(
                                'departure_date_time_text'.i18n(),
                                style: bodyBoldStyle(ColorApp.secondaryText),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mediaQuery(context).width * .04,
                        ),
                        Container(
                          padding:
                              EdgeInsets.all(mediaQuery(context).width * .04),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: mediaQuery(context).width * .05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'car_bus_number_text'.i18n(),
                                style: bodyBoldStyle(ColorApp.secondaryText),
                              ),
                              FlutterSwitch(
                                  width: 44.0,
                                  height: 22.0,
                                  toggleSize: 15.0,
                                  value: swich,
                                  borderRadius: 20.0,
                                  padding: 2.0,
                                  toggleColor: swich
                                      ? primaryMain
                                      : ColorApp.primaryText,
                                  switchBorder: Border.all(
                                    color: swich
                                        ? primaryMain
                                        : ColorApp.primaryText,
                                    width: 2.0,
                                  ),
                                  toggleBorder: Border.all(
                                    color: swich
                                        ? primaryMain
                                        : ColorApp.primaryText,
                                    width: 5.0,
                                  ),
                                  activeColor: ColorApp.defaultBackgroundColor,
                                  inactiveColor:
                                      ColorApp.defaultBackgroundColor,
                                  onToggle: (val) {
                                    swich = val;
                                    if (kDebugMode) {
                                      print(swich);
                                    }

                                    setState(() {
                                      swich != swich;
                                    });
                                  })
                            ],
                          ),
                        ),
                        swich
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: mediaQuery(context).width * .035),
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
                                          vertical:
                                              mediaQuery(context).width * .04,
                                          horizontal:
                                              mediaQuery(context).width * .038),
                                      child: Container(
                                        height: mediaQuery(context).width * .12,
                                        width: double.infinity,
                                        child: Container(
                                          height: 40,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 1,
                                          ),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            // ignore: dead_code
                                            border: errorCar1
                                                ? Border.all(
                                                    width: 1,
                                                    color: primaryMain)
                                                : null,
                                            color: ColorApp.fieldColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4)),
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2(
                                                hint: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12),
                                                  child: Text(
                                                    selectedbusnumber,
                                                    style: bodyStyle(
                                                        ColorApp.secondaryText),
                                                  ),
                                                ),
                                                onMenuStateChange: (val) {
                                                  setState(() {
                                                    click = val;
                                                    // print(val);
                                                  });
                                                },
                                                isExpanded: true,
                                                items: []
                                                    .map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item
                                                                  .fleetsName,
                                                              child: (item.fleetsName
                                                                          .trim()
                                                                          .toLowerCase() ==
                                                                      selectedbusnumber
                                                                          .trim()
                                                                          .toLowerCase())
                                                                  ? Container(
                                                                      height: double
                                                                          .infinity,
                                                                      width: double
                                                                          .infinity,
                                                                      color: const Color
                                                                              .fromRGBO(
                                                                          61,
                                                                          214,
                                                                          208,
                                                                          0.2),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 8.0),
                                                                          child:
                                                                              Text(
                                                                            item.fleetsName,
                                                                            style:
                                                                                bodyStyle(ColorApp.secondaryText),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        item.fleetsName,
                                                                        style: bodyStyle(
                                                                            ColorApp.secondaryText),
                                                                      ),
                                                                    ),
                                                            ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedbusnumber =
                                                        value as String;
                                                    currentbusnumber =
                                                        selectedbusnumber;
                                                    change = true;
                                                    errorCar1 = true;
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 3000),
                                                        () {
                                                      setState(() {
                                                        errorCar1 = false;
                                                      });
                                                    });
                                                  });
                                                  Route = selectedbusnumber;
                                                  if (kDebugMode) {
                                                    print(selectedbusnumber);
                                                  }
                                                },
                                                // icon: Icon(
                                                //   Icons
                                                //       .keyboard_arrow_down_rounded,
                                                //   color: ColorApp.secondaryText,
                                                // ),
                                                // iconSize: 30,
                                                // buttonDecoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(4),
                                                //   color: ColorApp.fieldColor,
                                                // ),
                                                // // buttonElevation: 2,
                                                // // itemHeight: 40,
                                                // itemPadding:
                                                //     EdgeInsets.symmetric(
                                                //         horizontal: 0),
                                                // dropdownMaxHeight: 200,
                                                // // dropdownWidth: 264,
                                                // dropdownPadding:
                                                //     EdgeInsets.all(0),
                                                // dropdownDecoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             4),
                                                //     color: ColorApp
                                                //         .defaultBackgroundColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ))
                            : Container(),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: mediaQuery(context).width * .01),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'chose_type_text'.i18n(),
                        //         style: bodyBoldStyle(ColorApp.secondaryText),
                        //       ),
                        //       FlutterSwitch(
                        //           width: 44.0,
                        //           height: 22.0,
                        //           toggleSize: 15.0,
                        //           value: swich1,
                        //           borderRadius: 20.0,
                        //           padding: 2.0,
                        //           toggleColor: swich1
                        //               ? primaryMain
                        //               : ColorApp.primaryText,
                        //           switchBorder: Border.all(
                        //             color: swich1
                        //                 ? primaryMain
                        //                 : ColorApp.primaryText,
                        //             width: 2.0,
                        //           ),
                        //           toggleBorder: Border.all(
                        //             color: swich1
                        //                 ? primaryMain
                        //                 : ColorApp.primaryText,
                        //             width: 5.0,
                        //           ),
                        //           activeColor: ColorApp.defaultBackgroundColor,
                        //           inactiveColor:
                        //               ColorApp.defaultBackgroundColor,
                        //           onToggle: (val) {
                        //             swich1 = val;
                        //             print(swich1);

                        //             setState(() {
                        //               swich1 != swich1;
                        //             });
                        //           })
                        //     ],
                        //   ),
                        // ),
                        // swich1
                        //     ? Container(
                        //         margin: EdgeInsets.symmetric(
                        //             vertical: mediaQuery(context).width * .035),
                        //         height: 72,
                        //         width: double.infinity,
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             color: ColorApp.defaultBackgroundColor,
                        //             borderRadius: BorderRadius.circular(4),
                        //             boxShadow: [
                        //               BoxShadow(
                        //                 color: ColorApp.shadowColor,
                        //                 blurRadius: 9,
                        //                 spreadRadius: 4,
                        //                 offset: Offset(-3, 2),
                        //               ),
                        //             ],
                        //           ),
                        //           // padding: EdgeInsets.all(8),
                        //           child: Container(
                        //               margin: EdgeInsets.symmetric(
                        //                   vertical:
                        //                       mediaQuery(context).width * .04,
                        //                   horizontal:
                        //                       mediaQuery(context).width * .038),
                        //               child: Container(
                        //                 height: mediaQuery(context).width * .12,
                        //                 width: double.infinity,
                        //                 child: Container(
                        //                   height: 40,
                        //                   padding: EdgeInsets.symmetric(
                        //                       horizontal: 1),
                        //                   width: double.infinity,
                        //                   decoration: BoxDecoration(
                        //                     // ignore: dead_code
                        //                     border: errorCar2
                        //                         ? Border.all(
                        //                             width: 1,
                        //                             color: primaryMain)
                        //                         : null,
                        //                     color: ColorApp.fieldColor,
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(4)),
                        //                   ),
                        //                   child: Align(
                        //                     alignment: Alignment.centerLeft,
                        //                     child: DropdownButtonHideUnderline(
                        //                       child: DropdownButton2(
                        //                         hint: Padding(
                        //                           padding: EdgeInsets.symmetric(
                        //                               horizontal: 12),
                        //                           child: Text(
                        //                             selectedTriptype,
                        //                             style: bodyStyle(
                        //                                 ColorApp.secondaryText),
                        //                           ),
                        //                         ),
                        //                         onMenuStateChange: (val) {
                        //                           setState(() {
                        //                             click = val;
                        //                             // print(val);
                        //                           });
                        //                         },
                        //                         isExpanded: true,
                        //                         items: masterOptions
                        //                             .map(
                        //                                 (MasterOptions item) =>
                        //                                     DropdownMenuItem<
                        //                                         String>(
                        //                                       value: item.id,
                        //                                       child: (item.id
                        //                                                   .trim()
                        //                                                   .toLowerCase() ==
                        //                                               selectedTriptype
                        //                                                   .trim()
                        //                                                   .toLowerCase())
                        //                                           ? Container(
                        //                                               height: double
                        //                                                   .infinity,
                        //                                               width: double
                        //                                                   .infinity,
                        //                                               color: const Color
                        //                                                       .fromRGBO(
                        //                                                   61,
                        //                                                   214,
                        //                                                   208,
                        //                                                   0.2),
                        //                                               child:
                        //                                                   Align(
                        //                                                 alignment:
                        //                                                     Alignment.centerLeft,
                        //                                                 child:
                        //                                                     Padding(
                        //                                                   padding:
                        //                                                       const EdgeInsets.symmetric(horizontal: 8.0),
                        //                                                   child:
                        //                                                       Text(
                        //                                                     item.id,
                        //                                                     style:
                        //                                                         bodyStyle(ColorApp.secondaryText),
                        //                                                   ),
                        //                                                 ),
                        //                                               ),
                        //                                             )
                        //                                           : Padding(
                        //                                               padding: const EdgeInsets
                        //                                                       .symmetric(
                        //                                                   horizontal:
                        //                                                       8.0),
                        //                                               child:
                        //                                                   Text(
                        //                                                 item.id,
                        //                                                 style: bodyStyle(
                        //                                                     ColorApp.secondaryText),
                        //                                               ),
                        //                                             ),
                        //                                     ))
                        //                             .toList(),
                        //                         onChanged: (value) {
                        //                           setState(() {
                        //                             selectedTriptype =
                        //                                 value as String;
                        //                             currentTriptype =
                        //                                 selectedTriptype;
                        //                             change = true;
                        //                             errorCar2 = true;
                        //                             Future.delayed(
                        //                                 Duration(
                        //                                     milliseconds: 3000),
                        //                                 () {
                        //                               setState(() {
                        //                                 errorCar2 = false;
                        //                               });
                        //                             });
                        //                           });
                        //                           Route = selectedTriptype;
                        //                           print(selectedTriptype);
                        //                         },
                        //                         icon: Icon(
                        //                           Icons
                        //                               .keyboard_arrow_down_rounded,
                        //                           color: ColorApp.secondaryText,
                        //                         ),
                        //                         iconSize: 30,
                        //                         buttonDecoration: BoxDecoration(
                        //                           borderRadius:
                        //                               BorderRadius.circular(4),
                        //                           color: ColorApp.fieldColor,
                        //                         ),
                        //                         // buttonElevation: 2,
                        //                         // itemHeight: 40,
                        //                         itemPadding:
                        //                             EdgeInsets.symmetric(
                        //                                 horizontal: 0),
                        //                         dropdownMaxHeight: 200,
                        //                         // dropdownWidth: 264,
                        //                         dropdownPadding:
                        //                             EdgeInsets.all(0),
                        //                         dropdownDecoration: BoxDecoration(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     4),
                        //                             color: ColorApp
                        //                                 .defaultBackgroundColor),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               )),
                        //         ))
                        //     : Container(),
                        GestureDetector(
                          onTap: () async {
                            if (kDebugMode) {
                              print(time +
                                  " " +
                                  finalSelectedDate +
                                  " " +
                                  currentbusnumber! +
                                  " " +
                                  currentRouteValue +
                                  " " +
                                  price);
                            }
                            if (price.isNotEmpty &&
                                currentRouteValue.isNotEmpty &&
                                currentbusnumber!.isNotEmpty &&
                                finalSelectedDate.isNotEmpty &&
                                time.isNotEmpty) {
                              setState(() {
                                loader = false;
                              });
                              var valuedate = finalSelectedDate.split(".");
                              var finalDateTime = "${finalSelectedDate}T$time";
                              if (kDebugMode) {
                                print(finalDateTime);
                                print(selectedRouteValue);
                                print(selectedArrivalPoint +
                                    "  " +
                                    selectedStartPoint);
                              }
                              // print()
                              String vehicule = '';
                              var vehiculeType = []
                                  .where((element) => (element.optionId)
                                      .contains(selectedTriptype))
                                  .map((e) {
                                vehicule = e.vehicle;
                                return vehicule;
                              }).toList();
                              // Trip trip = Trip(
                              //     date: finalDateTime,
                              //     time: time,
                              //     route: selectedRouteValue,
                              //     vehiculeType: vehicule,
                              //     option: selectedTriptype,
                              //     distance: 500,
                              //     price: int.parse(price),
                              //     tripID: '',
                              //     departure: departure!,
                              //     destination: destination!,
                              //     availableSeats: Counter,
                              //     capacity: Counter,
                              //     startPoint: selectedStartPoint,
                              //     arrivalPoint: selectedArrivalPoint,
                              //     status: 'OPEN',
                              //     onboardedPerson: 0,
                              //     driverId: currentbusnumber.toString());
                              // print(finalDateTime);
                              setState(() {
                                loader = false;
                              });
                              if (kDebugMode) {
                                // print("departure " + trip.departure);
                                // print("destination " + trip.destination);
                              }
                              var response;
                              try {
                                // response = await APIService.createTrip(
                                //     trip: trip, headers: await doHeaders());
                                // response =
                                //     await APIService.createTrips(trips);
                                setState(() {
                                  loader = true;
                                });
                                if (response.error == false) {
                                  // nav(BottomNavBar(), context, close: true);
                                  showAlertDialog(
                                    isError: false,
                                      context: context,
                                      title: 'dialog_success'.i18n(),
                                      body: 'created_new_trip_text'.i18n());
                                  if (kDebugMode) {
                                    print("create new Trip !");
                                  }
                                  finalSelectedDate = '';
                                } else {
                                  setState(() {
                                    loader = true;
                                  });
                                  showAlertDialog(
                                    isError: false,

                                      context: context,
                                      title: 'dialog_error'.i18n(),
                                      body: 'trip_creation_error'.i18n());
                                  if (kDebugMode) {
                                    print("Api service error!");
                                  }
                                }
                              } catch (e, s) {
                                // CrashAsyncFunction(e, s,'trip_creation_error'.i18n(), currentUserId!);
                                setState(() {
                                  loader = true;
                                });
                                showAlertDialog(
                                    isError: false,

                                    context: context,
                                    title: 'dialog_error'.i18n(),
                                    body: 'trip_creation_error'.i18n());
                                if (kDebugMode) {
                                  print(e.toString());
                                }
                              }
                            } else {
                              setState(() {
                                loader = true;
                              });
                              (price.isEmpty)
                                  ? showAlertDialog(
                                    isError: false,

                                      context: context,
                                      title: 'dialog_error'.i18n(),
                                      body: "price_undefined".i18n())
                                  : showAlertDialog(
                                    isError: false,

                                      context: context,
                                      title: 'dialog_error'.i18n(),
                                      body: 'all_fields_required_text'.i18n());

                              if (kDebugMode) {
                                print("Error !");
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: mediaQuery(context).width * .04,
                            ),
                            height: 48,
                            decoration: BoxDecoration(
                                color: primaryMain,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text('create_text'.i18n(),
                                  style: buttonStyle(white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery(context).height * .01,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomAppBar(label: 'Ideentificationion'.i18n(), context: context),
            showDatePicker
                ? Align(
                    alignment: Alignment.center,
                    child: datePicker(),
                  )
                : Container(),
            if (!loader) LoadingComponennt()
          ],
        ),
      ),
    );
  }
}
