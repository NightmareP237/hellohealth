import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/home_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class Appoint extends StatefulWidget {
  const Appoint({super.key});

  @override
  State<Appoint> createState() => _AppointState();
}

class _AppointState extends State<Appoint> {
  var selectedday = 0;
  var selectedhour = 0;
  int add = 1;

  @override
  Widget build(BuildContext context) {
    var datetime = DateTime.now();
    Widget appointmentItem(int i) {
      return Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: i != 1 ? 16 : 0,
              ),
              i != 1
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              color:
                                  // (selectedhour == index)
                                  //     ? primaryMain.withOpacity(.75)
                                  //     :
                                  Colors.green[500],
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("New Appointment",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    )),
                                // Text(listofday[index].toString().substring(0, 3),
                                //     style: body())
                              ],
                            ),
                          ),
                        ),
                        Container(),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    )
                  : SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Please enter your name ', style: SubTitle()),
                  i == 1 ? Text('Appointment', style: SubTitle()) : SizedBox(),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                cursorColor: Colors.orange,
                key: ValueKey('name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                autofocus: false,
                textCapitalization: TextCapitalization.none,
                decoration: const InputDecoration(
                  fillColor: Colors.orange,
                  prefixIcon: Icon(Ionicons.person_add),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.solid)),
                  labelText: 'Enter your name ',
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
                minLines: 2,
                maxLines: 5,
                cursorColor: Colors.orange,
                key: ValueKey('description'),
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
                  fillColor: Colors.orange,
                  prefixIcon: Icon(Icons.medical_information),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid, color: primaryMain)),
                  labelText: 'discribe your symptoms... ',
                  // contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                ),
                onSaved: (val) {
                  // name = val!;
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
                  spacing: redimw(context) / 14,
                  runSpacing: redimw(context) / 15,
                  runAlignment: WrapAlignment.spaceBetween,
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedhour = index;
                        });
                        print(index);
                      },
                      child: Container(
                        width: redimw(context) / 4.2,
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
                        size: 25,
                        onTap: (selected) {},
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
                        size: 25,
                        onTap: (selected) {},
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
                        size: 25,
                        onTap: (selected) {},
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
          ),
        ),
      );
    }

    ColorApp().init(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: redimh(context) / 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Month: " + listofmonth[datetime.month - 1],
                            style: NameStyle()),
                        Row(
                          children: [
                            add <= 1
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        add--;
                                      });
                                      print(add);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.red[800],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Ionicons.remove_circle,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            // SizedBox(width: 5,),
                                            Text(
                                              'Remove',
                                              style: SubTitle(black: true),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              width: add <= 1 ? 0 : 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  add++;
                                });
                                print(add);
                              },
                              child: Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green[800],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Ionicons.add_circle,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      // SizedBox(width: 5,),
                                      Text(
                                        'Add',
                                        style: SubTitle(black: true),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    for (var i = 1; i <= add; i++) appointmentItem(i),
                    SizedBox(
                      height: redimh(context) / 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        // nav(Appoint(), context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: primaryMain,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            "Confirm Appointment",
                            style: SubTitle(black: false),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomAppBar(label: "Appointment", context: context, iconback: true),
        ],
      )),
    );
  }
}
