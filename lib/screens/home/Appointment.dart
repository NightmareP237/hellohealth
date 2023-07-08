import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class Appoint extends StatefulWidget {
  const Appoint({super.key});

  @override
  State<Appoint> createState() => _AppointState();
}

class _AppointState extends State<Appoint> {
  var selectedday = 0;
  var selectedhour = 0;
  @override
  Widget build(BuildContext context) {
    var datetime = DateTime.now();
    return Scaffold(
      appBar: appbar(context, 'Appointment'),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(listofmonth[datetime.month - 1], style: NameStyle()),
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
                  spacing: redimw(context) / 12,
                  runSpacing: 20,
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
                  Row(children: [
                    RoundCheckBox(
                      size: 30,

              onTap: (selected) {},
            ),
            SizedBox(width: 5,),
            Text('Child',style: NameStyle(),)
                  ],),
                   Row(children: [
                    RoundCheckBox(
                      size: 30,
              onTap: (selected) {},
            ),
            SizedBox(width: 5,),
            Text('Adult',style: NameStyle(),)
                  ],), Row(children: [
                    RoundCheckBox(
                      size: 30,

              onTap: (selected) {},
            ),
            SizedBox(width: 5,),
            Text('old man',style: NameStyle(),)
                  ],),
                ],
              ),
              SizedBox(
                height: redimh(context) / 16,
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
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Confirm Appointment",
                      style: SubTitle(black: false),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
