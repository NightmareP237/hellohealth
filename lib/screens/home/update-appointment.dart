import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/models/Appointment.dart';
import 'package:hellohealth/screens/home/bottom-bar.dart';
import 'package:hellohealth/screens/home/planning-appointments.dart';
import 'package:ionicons/ionicons.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../ressources/const.dart';
import 'loading-page.dart';

class UpdateAppointment extends StatefulWidget {
  UpdateAppointment({super.key, required this.rdv});
  Appointment rdv;
  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

var selectedday = 0;
var selectedhour = 0;
bool child = false, adult = false, old = false, loading = false;
String day = '', name = '', symptom = '';

class _UpdateAppointmentState extends State<UpdateAppointment> {
  @override
  void initState() {
    selectedhour = 9;
    selectedday = 6;
    super.initState();
  }

  var datetime = DateTime.now();
  Widget appointmentItem(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Please enter your name ', style: SubTitle()),
            Text('Appointment', style: SubTitle()),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          cursorColor: Colors.orange,
          key: ValueKey('name'),
          initialValue: widget.rdv.patientname,
          onChanged: (value) {
            setState(() {
              name = value;
            });
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter your name';
            }
            return null;
          },
          keyboardType: TextInputType.text,
          autofocus: false,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            iconColor: primaryMain,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: primaryMain)),
            fillColor: Colors.orange,
            prefixIcon: Icon(
              Ionicons.person_add,
              color: primaryMain,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.solid)),
            labelText: 'Enter your name ',
            labelStyle: TextStyle(color: primaryMain),
            contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          ),
          onSaved: (val) {
            // name = val!;
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text('Please discribe your symptoms ', style: SubTitle()),
        SizedBox(
          height: 16,
        ),
        TextFormField(
          initialValue: widget.rdv.symptom,
          minLines: 2,
          maxLines: 5,
          cursorColor: Colors.orange,
          key: ValueKey('description'),
          onChanged: (value) {
            setState(() {
              symptom = value;
            });
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter your description';
            }
            return null;
          },
          keyboardType: TextInputType.multiline,
          autofocus: false,
          textCapitalization: TextCapitalization.none,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: primaryMain)),

            fillColor: Colors.orange,
            prefixIcon: Icon(
              Icons.medical_information,
              color: primaryMain,
            ),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: primaryMain)),
            labelText: 'discribe your symptoms... ',
            labelStyle: TextStyle(color: primaryMain),

            // contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
          ),
          onSaved: (val) {
            setState(() {
              symptom = val!;
            });
          },
        ),
        SizedBox(
          height: 16,
        ),
        Text('Choose your appointment day !', style: SubTitle()),
        SizedBox(
          height: 16,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedday = index;
                    day = listofday[index];
                  });
                  print(index);
                },
                child: Container(
                  width: redimw(context) / 7,
                  height: 70,
                  decoration: BoxDecoration(
                      color: (selectedday == index)
                          ? primaryMain.withOpacity(.75)
                          : Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((datetime.day + index).toString(),
                            style: SubTitle()),
                        Text(listofday[index].toString().substring(0, 3),
                            style: body())
                      ],
                    ),
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 16,
        ),
        Text('Choose your appointment hours !', style: SubTitle()),
        SizedBox(
          height: 16,
        ),
        Wrap(
            spacing: redimw(context) / 12,
            runSpacing: 20,
            runAlignment: WrapAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedhour = index;
                    // time = ;
                  });
                  print(index);
                },
                child: Container(
                  width: redimw(context) / 4,
                  height: 40,
                  decoration: BoxDecoration(
                      color: (selectedhour == index)
                          ? primaryMain.withOpacity(.75)
                          : Colors.grey[400],
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(listofhour[index], style: SubTitle()),
                        // Text(listofday[index].toString().substring(0, 3),
                        //     style: body())
                      ],
                    ),
                  ),
                ),
              ),
            )),
        SizedBox(
          height: 16,
        ),
        Text('Choose your Age !', style: SubTitle()),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RoundCheckBox(
                  isChecked: (child) ? true : false,
                  size: 25,
                  onTap: (selected) {
                    setState(() {
                      child = selected!;
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Child',
                  style: NameStyle(),
                )
              ],
            ),
            Row(
              children: [
                RoundCheckBox(
                  isChecked: (adult) ? true : false,
                  size: 25,
                  onTap: (selected) {
                    setState(() {
                      adult = selected!;
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Adult',
                  style: NameStyle(),
                )
              ],
            ),
            Row(
              children: [
                RoundCheckBox(
                  isChecked: (old) ? true : false,
                  size: 25,
                  onTap: (selected) {
                    setState(() {
                      old = selected!;
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'old man',
                  style: NameStyle(),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> UpdateAppoint(Appointment app, String docId) async {
    try {
      setState(() {
        loading = true;
      });
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(docId)
          .update(app.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

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
                                : Ionicons.logo_whatsapp,
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
      body: SafeArea(
          child: Stack(
        children: [
          // CustomAppBar(
          //     label: 'Update Appointment', context: context, iconback: true),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: redimh(context) / 2.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1,
                          color: primaryMain,
                          style: BorderStyle.solid),
                      image: DecorationImage(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.rdv.docImage,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: listCall,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: primaryMain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                height: 40,
                                width: widget.rdv.specialistof.length >= 11
                                    ? redimw(context) / 3
                                    : redimw(context) / 3.2,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.7),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(widget.rdv.specialistof,
                                        style: bodyBoldStyle(primaryMain))),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Appointment with: ",
                          style: bodyStyle(Colors.black)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.rdv.doctorName,
                        style: subtitleStyle(primaryMain),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  for (var i = 1; i <= 1; i++) appointmentItem(i),
                  SizedBox(
                    height: redimh(context) / 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      var date =
                          "${datetime.day.toInt() + selectedday}/${datetime.month}/${datetime.year}";

                      if ((child == false && adult == false && old == false) ||
                          (child == true && adult == true) ||
                          (child == true && old == true) ||
                          (adult == true && old == true)) {
                        showAlertDialog(
                            isError: false,
                            context: context,
                            title: "Attention",
                            body:
                                'Choisissez une seule tranche d\'age et validez !');
                      } else if (listofday[selectedday].toString().isNotEmpty &&
                          // symptom.isNotEmpty &&
                          // name.isNotEmpty &&
                          listofhour[selectedhour].isNotEmpty) {
                        var date = "${day}/${datetime.month}/${datetime.year}";
                        Appointment app = Appointment(
                            docImage: widget.rdv.docImage,
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            doctorPhone: widget.rdv.doctorPhone,
                            whatsappDoctorPone: widget.rdv.whatsappDoctorPone,
                            symptom: symptom.isNotEmpty
                                ? symptom
                                : widget.rdv.symptom,
                            patientname:
                                name.isNotEmpty ? name : widget.rdv.doctorName,
                            age: child
                                ? AGE[0]
                                : adult
                                    ? AGE[1]
                                    : old
                                        ? AGE[2]
                                        : '',
                            DoctorUid: widget.rdv.DoctorUid,
                            doctorName: widget.rdv.doctorName,
                            time: listofhour[selectedhour],
                            location: widget.rdv.location,
                            specialistof: widget.rdv.specialistof,
                            createAt: widget.rdv.createAt,
                            updateAt: date);
                        // print();
                        // print(app.docId);
                        UpdateAppoint(app, widget.rdv.docId).then((value) {
                          setState(() {
                            load = !value;
                          });
                          nav(BottomBar(), context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green[400],
                              content: const Text(
                                  'Appointment succesfully update !')));
                        });
                      } else {
                        showAlertDialog(
                            isError: false,
                            context: context,
                            title: "Alert",
                            body:
                                ' Informations incorrect ou abscent. Ressayer !');
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: primaryMain,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          "Update Appointment",
                          style: SubTitle(black: false),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          loading ? LoadingComponennt() : SizedBox()
        ],
      )),
    );
  }
}
