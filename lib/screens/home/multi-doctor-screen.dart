import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/doctors/CardWidget.dart';
import 'package:hellohealth/screens/home/home_page.dart';

import 'doctorswidget/generalists_widget.dart';
import 'doctorswidget/specialist_widget.dart';

// ignore: camel_case_types
class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen>
    with SingleTickerProviderStateMixin {
  final colorstheme = primaryMain;

  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var GeneralList = mapdata
        .where((element) => ((element.specialist!.trim().toLowerCase())
                .contains("Generalist".trim().toLowerCase())
            ))
        .toList();
        var SpecialistList = mapdata
        .where((element) => !((element.specialist!.trim().toLowerCase())
                .contains("Generalist".trim().toLowerCase())
            ))
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: appbar(context, 'Find Your Doctor', arrow: false),
      body: Column(
        children: [
          Container(
            height: redimh(context) * .035,
            color: primaryMain.withOpacity(.5),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: primaryMain.withOpacity(.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: TabBar(
                isScrollable: true,
                indicatorPadding: EdgeInsets.all(10),
                labelColor: primaryMain,
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 20),
                labelPadding:
                    EdgeInsets.only(left: 65, right: 65, top: 15, bottom: 15),
                indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                controller: _tabController,
                tabs: [
                  Text('Specialist'),
                  Text('Generalist'),
                ]),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SpecialistsWidget(items1: SpecialistList),
              GeneralistsWidget(items: GeneralList),

              // CardWidget(),
            ]),
          )
        ],
      ),
    );
  }
}
