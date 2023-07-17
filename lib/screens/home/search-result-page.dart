import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/doctor-info-view.dart';
import 'package:ionicons/ionicons.dart';

class ResultPage extends StatefulWidget {
  ResultPage({super.key, required this.selectArea});
  String selectArea;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final mapdata = [
      {
        "name": "Dr Ethan Ebode",
        "experience": "7 Years",
        "patients": "3.4 k",
        'location': "Ndogbon",
        'horaire': "12:00pm - 18:00pm",
        'specialist': "Cardiologist",
        "image": "assets/images/d3.png"
      },
      {
        "name": "Dr Julio Francis ",
        "experience": "4 Years",
        "patients": "8.4 k",
        'horaire': "10:30pm - 16:00pm",
        'location': "Dakar",
        'specialist': "Cardiologist",
        "image": "assets/images/d5.png"
      },
      {
        "name": "Dr Debora Yvana",
        "experience": "8 Years",
        'specialist': "Cardiologist",
        'location': "Logbessou",
        'horaire': "10:00pm - 18:00pm",
        "patients": "4.4 k",
        "image": "assets/images/d6.jpeg"
      },
      {
        "name": "Dr Veronica Cantana",
        "experience": "5 Years",
        'specialist': "Cardiologist",
        'location': "Bonaberry",
        'horaire': "12:30pm - 15:30pm",
        "patients": "6.4 k",
        "image": "assets/images/d7.jpeg"
      },
      {
        "name": "Dr Verclaire Simon",
        "experience": "6 Years",
        "patients": "8.4 k",
        'specialist': "Cardiologist",
        'location': "Dakar",
        'horaire': "10:30pm - 16:00pm",
        "image": "assets/images/d8.jpeg"
      },
      {
        "name": "Dr Juliette Estrella",
        'specialist': "Cardiologist",
        "experience": "6 Years",
        "patients": "5.4 k",
        'location': "Village",
        'horaire': "10:30pm - 18:00pm",
        "image": "assets/images/d9.jpeg"
      },
      {
        "name": "Dr Jovanie Esther",
        'specialist': "Cardiologist",
        "experience": "4 Years",
        'horaire': "10:30pm - 16:00pm",
        "patients": "7.4 k",
        'location': "Logbessou",
        "image": "assets/images/d10.jpeg"
      },
      {
        "name": "Dr Valerie Epie",
        'specialist': "Cardiologist",
        "experience": "3 Years",
        'location': "Dakar",
        'horaire': "10:30pm - 15:00pm",
        "patients": "6.4 k",
        "image": "assets/images/d11.png"
      },
      {
        "name": "Dr Josiane Makuche",
        "experience": "6 Years",
        'specialist': "Cardiologist",
        "patients": "5.4 k",
        'location': "Bonaberry",
        'horaire': "10:00pm - 17:00pm",
        "image": "assets/images/d12.jpeg"
      },
      {
        "name": "Dr Dieudonne Eliote",
        'specialist': "Cardiologist",
        "experience": "5 Years",
        "patients": "7.4 k",
        'horaire': "10:30pm - 16:00pm",
        'location': "Bonandjo",
        "image": "assets/images/d13.png"
      },
      {
        "name": "Dr Estrella Ivonne",
        'specialist': "Cardiologist",
        "experience": "5 Years",
        "patients": "3.4 k",
        'horaire': "10:30pm - 16:00pm",
        'location': "Dakar",
        "image": "assets/images/d14.jpeg"
      },
    ];

    var AllResult = List.generate(
        4,
        (index) => Column(
              children: [
                SizedBox(
                  height: redimh(context) * .02,
                ),
                GestureDetector(
                  onTap: () {
                    // nav(DoctorView(doctorDetail: mapdata[index]), context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: redimh(context) / 9,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primaryMain.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Image.asset(
                            mapdata[index]['image'].toString(),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        SizedBox(
                          width: redimw(context) * .075,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mapdata[index]['name'].toString(),
                              style: NameStyle(),
                            ),
                            Text(
                              mapdata[index]['specialist'].toString(),
                              style: SubTitle(),
                            ),
                            Row(
                              children: [
                                Text(
                                  mapdata[index]['horaire'].toString(),
                                  style: body(),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.location_city),
                                Text(
                                  mapdata[index]['location'].toString(),
                                  style: body(),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
    return Scaffold(
      appBar: appbar(context, "Douala"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Cardiologist",
                    style: SubTitle(),
                  ),
                  Text(
                    "See All",
                    style: SubTitle(),
                  ),
                ],
              ),
              Column(
                children: AllResult,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 8, left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Doctor',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    Text(
                      'Online',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: mapdata
                      .getRange(1, 3)
                      .map((e) => Container(
                            // height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: primaryMain.withOpacity(.5),
                            ),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            child: Container(
                              height: 280,
                              child: Row(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5),
                                          Text(
                                            e['name'].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          const Text(
                                            "Experience",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            e['experience'].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          const Text(
                                            "This Doctor is Online ...",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Message and Call are Open !",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            width: 200,
                                            height: 40,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color:
                                                  Colors.green.withOpacity(.7),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Ionicons
                                                        .chatbox_ellipses_outline,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "messages",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Text(
                                          //   "Call",
                                          //   style: TextStyle(
                                          //     color: Colors.black,
                                          //     fontSize: 16,
                                          //     fontWeight: FontWeight.w700,
                                          //   ),
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(
                                                width: 25,
                                              ),
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    Colors.red.shade500,
                                                // backgroundImage: AssetImage("assets/user.png"),
                                                child: Center(
                                                  child: Icon(
                                                    size: 30,
                                                    Ionicons.call_outline,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    Colors.red.shade500,
                                                // backgroundImage: AssetImage("assets/user.png"),
                                                child: Center(
                                                  child: Icon(
                                                    Ionicons.videocam_outline,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Image.asset(
                                      e['image'].toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
