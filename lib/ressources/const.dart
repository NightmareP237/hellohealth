import 'package:flutter/material.dart';
import 'package:hellohealth/screens/home/home_page.dart';
import 'package:ionicons/ionicons.dart';

Color primaryMain = Colors.orange;
Color background = Colors.white;
nav(Widget navigate, BuildContext context, {bool close = false}) {
  close
      ? Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => navigate), (route) => false)
      : Navigator.push(
          context,
          SizeTransition5(
            navigate,
          ),
        );
}

List listofhour = ['10: 10', '10: 30', '10: 50', '14: 10', '14: 50'];
List listofmonth = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
List listofday = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];
NameStyle() => TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
SubTitle({bool black = false}) => TextStyle(
      color: black ? Colors.white : Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
body() => TextStyle(
      color: Colors.black54,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

redimh(BuildContext context) {
  double _h = MediaQuery.of(context).size.height;
  return _h;
}

redimw(BuildContext context) {
  double _w = MediaQuery.of(context).size.width;
  return _w;
}
 final myappointment = [
      {
        "date": "08/07/2023",
        "time": "10:30",
        "symptom":"",
        "doctor": "Dr Darel Ebode",
        'type': "Neurosurge",
        "place": "Bonaberry"
      },
      {
        "date": "09/07/2023",
        "time": "12:30",
        "symptom":"",
        "doctor": "Dr Simon Pierre",
        'type': "Cardiologist",
        "place": "New Bell"
      },
      {
        "date": "10/07/2023",
        "time": "10:30",
        "symptom":"",
        "doctor": "Dr Darel Ebode ",
        'type': "Neurosurge",
        "place": "Bonandjo"
      },
     {
        "date": "11/07/2023",
        "time": "12:30",
        "symptom":"",
        "doctor": "Dr Darel Ebode",
        'type': "Cardiologist",
        "place": "Bonaberry"
      },
     {
        "date": "12/07/2023",
        "time": "13:30",
        "symptom":"",
        "doctor": "Dr Elias Tchana ",
        'type': "Psychiatrist",
        "place": "New Bell"
      },
     
    ];

AppBar appbar(BuildContext context, var txt,{bool arrow=true}) => AppBar(
  
      elevation: 0,
      backgroundColor: Colors.white,
      leading: arrow? GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Ionicons.arrow_back,
          color: Colors.black,
        ),
      ):null,
      title: Text(
        txt,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );

class SizeTransition5 extends PageRouteBuilder {
  final Widget page;

  SizeTransition5(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: Duration(milliseconds: 1000),
          reverseTransitionDuration: Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.centerRight,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}
