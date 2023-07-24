import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/search-result-page.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';

class SearchDoctor extends StatefulWidget {
  const SearchDoctor({super.key});

  @override
  State<SearchDoctor> createState() => _SearchDoctorState();
}

String Route1 = 'Ville'.i18n();
String Route2 = 'Doctor'.i18n();

// String currentRouteValue = 'road_label'.i18n();
// String selectedRouteValue = 'road_label'.i18n();
String? currentArea = 'start_point_label'.i18n();
String selectedArea = 'Entrer votre ville'.i18n();
String selectedDoc = 'Selectionner votre type'.i18n();
String? currentDoc = 'arrival_point_label'.i18n();
// String selectedArrivalPoint = 'arrival_point_label'.i18n();
bool errorCar1 = false;
bool choose2 = false;
bool errorCar = false;
bool errorCar2 = false;
bool errorCar3 = false;
bool choose1 = false;
bool change = false;
bool change1 = false;
bool selectcity = false;
bool selectdoctor = false;
bool selectdate = false;

class _SearchDoctorState extends State<SearchDoctor> {
  final dateInput = TextEditingController();
  // final doctor = TextEditingController();
  // final selectarea = TextEditingController();
  Widget ErrorMessage(String message) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: errorMain, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Text(
            message,
            style: bodyStyle(Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var resultList = mapdata
        .where((element) => ((element.location!.trim().toLowerCase())
                .contains(selectedArea.trim().toLowerCase()) &&
            (element.specialist!.trim().toLowerCase())
                .contains(selectedDoc.toLowerCase().trim())))
        .toList();
    print(resultList);
    ColorApp().init(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          CustomAppBar(label: 'Search', context: context),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Search Your ",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 3),
                        Text(
                          "Doctor",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // TextFormField(
                    //   cursorColor: Colors.orange,
                    //   key: ValueKey('area'),
                    //   validator: (val) => (val == null || val.length > 3)
                    //       ? 'Please select your area'
                    //       : null,
                    //   autofocus: false,
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     iconColor: Colors.orange,
                    //     prefixIcon: Icon(Icons.lock),
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.orange),
                    //     ),
                    //     labelText: 'Select Area',
                    //     contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    //   ),
                    //   onSaved: (val) {
                    //     // _userPassword = val!;
                    //   },
                    // ),
                    Text(
                      "Select your city ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQuery(context).width * .02),
                        child: Container(
                          height: mediaQuery(context).width * .12,
                          width: double.infinity,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: errorCar1
                                  ? Border.all(width: 1, color: primaryMain)
                                  : null,
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  hint: Row(
                                    children: [
                                      Icon(Icons.location_city_rounded,
                                          color: Colors.black38),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              selectedArea,
                                              style: bodyStyle(Colors.black54),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                                  items: [
                                    "Douala",
                                    "Yaounde",
                                    "Bafoussam",
                                    "Limbe",
                                    "Garoua",
                                    "Bertoua",
                                    "Kribi"
                                  ].map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: (item.trim().toLowerCase() ==
                                              selectedArea.trim().toLowerCase())
                                          ? Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              color: const Color.fromRGBO(
                                                  61, 214, 208, 0.2),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    item,
                                                    style: bodyStyle(
                                                        Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                item,
                                                style:
                                                    bodyStyle(Colors.black54),
                                              ),
                                            ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedArea = value as String;
                                      currentArea = selectedArea;
                                      change = true;
                                      errorCar1 = true;
                                      setState(() {
                                        choose1 = true;
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 3000), () {
                                        setState(() {
                                          errorCar1 = false;
                                        });
                                      });
                                    });
                                    Route1 = selectedArea;
                                    if (kDebugMode) {
                                      print(selectedArea);
                                    }
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                      color: Colors.grey.shade100,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 16,
                                    iconEnabledColor: Colors.black,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    maxHeight: 200,
                                    width:
                                        redimw(context) - redimw(context) * .08,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade200,
                                    ),
                                    offset: const Offset(0, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      // crossAxisMargin: 16,
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    if (selectcity) ErrorMessage('Please city is required ! '),
                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      "Select your doctor  ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: mediaQuery(context).width * .02),
                        child: Container(
                          height: mediaQuery(context).width * .12,
                          width: double.infinity,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: errorCar1
                                  ? Border.all(width: 1, color: primaryMain)
                                  : null,
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  hint: Row(
                                    children: [
                                      Icon(
                                        Ionicons.medical_outline,
                                        color: Colors.black38,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(selectedDoc,
                                            style: bodyStyle(Colors.black54)),
                                      ),
                                    ],
                                  ),
                                  isExpanded: true,
                                  items: [
                                    "Generalist",
                                    "Rheumatologist",
                                    "Generalist",
                                    'Neurologist',
                                    'Anesthesiologist',
                                    'Cardiologist',
                                    'Dermatologist',
                                    'Endocrinologist',
                                    'Gastroenterologist',
                                  ].map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: (item.trim().toLowerCase() ==
                                              selectedArea.trim().toLowerCase())
                                          ? Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              color: const Color.fromRGBO(
                                                  61, 214, 208, 0.2),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    item,
                                                    style: bodyStyle(
                                                        Colors.black54),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                item,
                                                style:
                                                    bodyStyle(Colors.black54),
                                              ),
                                            ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDoc = value as String;
                                      currentDoc = selectedDoc;
                                      change1 = true;
                                      errorCar2 = true;
                                      setState(() {
                                        choose2 = true;
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 3000), () {
                                        setState(() {
                                          errorCar2 = false;
                                        });
                                      });
                                    });
                                    Route2 = selectedDoc;
                                    if (kDebugMode) {
                                      print(selectedDoc);
                                    }
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 50,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.black38,
                                      ),
                                      color: Colors.grey.shade100,
                                    ),
                                    elevation: 2,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 16,
                                    iconEnabledColor: Colors.black,
                                    iconDisabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    padding:
                                        EdgeInsets.only(left: 16, right: 16),
                                    maxHeight: 200,
                                    width:
                                        redimw(context) - redimw(context) * .08,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade200,
                                    ),
                                    offset: const Offset(0, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      // crossAxisMargin: 16,
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                        EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    if (selectdoctor)
                      ErrorMessage('Please doctor is required ! '),
                    const SizedBox(
                      height: 6,
                    ),
                    Text("Select your date ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: dateInput,
                      //editing controller of this TextField
                      decoration: const InputDecoration(
                        iconColor: Colors.orange,
                        prefixIcon: Icon(
                          Icons.calendar_today,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        labelText: 'Select date',
                        labelStyle: TextStyle(color: Colors.black38),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        // icon: Icon(
                        //   Icons.calendar_today,
                        //   color: Colors.orange,
                        // ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        var today = DateTime.now();
                        var fiftyDaysFromNow = today.add(new Duration(days: 7));
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null &&
                            pickedDate.isAfter(today) &&
                            pickedDate.isBefore(fiftyDaysFromNow)) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ),
                    if (selectdate) ErrorMessage('Please date is required ! '),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectedArea != "Entrer votre ville" &&
                            selectedDoc != "Selectionner votre type" &&
                            dateInput.text.isNotEmpty) {
                          nav(
                              ResultPage(
                                resultSearch: resultList,
                                selectArea: selectedArea,
                                selectDoc: selectedDoc,
                              ),
                              context);
                        } else {
                          if (dateInput.text.isEmpty) {
                            setState(() {
                              selectdate = true;
                            });
                            Timer(Duration(seconds: 3), () {
                              setState(() {
                                selectdate = false;
                              });
                            });
                          }
                          if (selectedArea == "Entrer votre ville") {
                            setState(() {
                              selectcity = true;
                            });
                            Timer(Duration(seconds: 3), () {
                              setState(() {
                                selectcity = false;
                              });
                            });
                          }
                          if (selectedDoc == "Selectionner votre type") {
                            setState(() {
                              selectdoctor = true;
                            });
                          }
                          Timer(Duration(seconds: 3), () {
                            setState(() {
                              selectdoctor = false;
                            });
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange.withOpacity(.7),
                        ),
                        child: Center(
                          child: Text(
                            "Search",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
