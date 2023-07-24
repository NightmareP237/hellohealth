import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/doctor-info-view.dart';
import 'package:ionicons/ionicons.dart';

import '../../models/doctor.dart';

class ResultPage extends StatefulWidget {
  ResultPage(
      {super.key,
      required this.selectArea,
      required this.selectDoc,
      required this.resultSearch});
  String selectDoc;
  String selectArea;
  List<Doctor> resultSearch;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    var AllResult = List.generate(
        widget.resultSearch.length,
        (index) => Column(
              children: [
                SizedBox(
                  height: redimh(context) * .02,
                ),
                GestureDetector(
                  onTap: () {
                    nav(DoctorView(doctorDetail: widget.resultSearch[index]), context);
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
                          child: Image.network(
                            widget.resultSearch[index].image.toString(),
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
                              widget.resultSearch[index].name.toString(),
                              style: NameStyle(),
                            ),
                            Text(
                              widget.resultSearch[index].specialist.toString(),
                              style: SubTitle(),
                            ),
                            Row(
                              children: [
                                Text(
                                  "10:00pm - 18:00pm",
                                  style: body(),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.location_city),
                                Text(
                                  widget.resultSearch[index].location
                                      .toString()
                                      .split(',')[1],
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
      // appBar: appbar(context, "Douala"),
      body: SafeArea(
          child: Stack(
        children: [
          CustomAppBar(label: 'City : ${widget.selectArea}', context: context),
          Padding(
            padding:
                EdgeInsets.only(top: widget.resultSearch.isEmpty ? 0 : 70.0),
            child: widget.resultSearch.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/searching-error.svg',
                          width: 250,
                          height: 250,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text('No doctor available at the moment !',style:bodyBoldStyle(Colors.black87) ,)
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All ${widget.selectDoc}",
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
                              children: widget.resultSearch
                                  .getRange(1, widget.resultSearch.length)
                                  .map((e) => Container(
                                        // height: 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(height: 5),
                                                      Text(
                                                        e.name.toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      const Text(
                                                        "Experience",
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        e.experience.toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      const Text(
                                                        "This Doctor is Online ...",
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        "Message and Call are Open !",
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        width: 200,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: Colors.green
                                                              .withOpacity(.7),
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
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              Text(
                                                                "messages",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16),
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
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                        children: [
                                                          SizedBox(
                                                            width: 25,
                                                          ),
                                                          CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors.red
                                                                    .shade500,
                                                            // backgroundImage: AssetImage("assets/user.png"),
                                                            child: Center(
                                                              child: Icon(
                                                                size: 30,
                                                                Ionicons
                                                                    .call_outline,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Colors.red
                                                                    .shade500,
                                                            // backgroundImage: AssetImage("assets/user.png"),
                                                            child: Center(
                                                              child: Icon(
                                                                Ionicons
                                                                    .videocam_outline,
                                                                color: Colors
                                                                    .white,
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
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Image.network(
                                                  e.image.toString(),
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
                  ),
          ),
        ],
      )),
    );
  }
}
