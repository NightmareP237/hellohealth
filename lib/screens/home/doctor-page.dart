import 'package:flutter/material.dart';
import 'package:hellohealth/screens/home/home_page.dart';

import '../../ressources/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top container

              // tagline
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Hey Ainna !",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " Get your Appoinment ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: "with the \nSpecialist of heath",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // search bar
              // Row(
              //   children: [
              //     Container(
              //       height: 70,
              //       width: MediaQuery.of(context).size.width * 0.70,
              //       padding: const EdgeInsets.all(15.0),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         // boxShadow: boxShadow,
              //         borderRadius: BorderRadius.circular(30.0),
              //       ),
              //       child: Row(
              //         children: const [
              //           // Icon(
              //           //   FontAwesomeIcons.magnifyingGlass,
              //           //   size: 25,
              //           //   color: kPrimaryColor,
              //           // ),
              //           SizedBox(width: 15),
              //           Text(
              //             "Search pineapple",
              //             style: TextStyle(
              //               fontWeight: FontWeight.w300,
              //               fontSize: 16,
              //               color: Colors.black38,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const Spacer(),
              //     Container(
              //       height: 60,
              //       width: 60,
              //       decoration:  BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: primaryMain,
              //       ),
              //       child: const Icon(
              //         Icons.filter,
              //         color: Colors.white,
              // ),
              //     ),
              //   ],
              // ),

              // category list
              // SizedBox(
              //   height: 80,
              //   width: MediaQuery.of(context).size.width,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 5,
              //     padding: const EdgeInsets.only(top: 20.0),
              //     itemBuilder: (context, index) {
              //       // for internal padding of text
              //       return Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Text(
              //           "data[index].name",
              //           style: TextStyle(
              //             fontSize: 16,
              //             color: index == 0 ? primaryMain : Colors.black45,
              //             fontWeight:
              //                 index == 0 ? FontWeight.bold : FontWeight.w400,
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),

              // product grid view
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                ),
                shrinkWrap: true,
                primary: false,
                // data[0].products!.length
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Container()
                                // DetailsScreen(
                                //   product: data[0].products![index],
                                // ),
                                ),
                          ),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade300,
                          ),
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                          child: Container(
                              height: 300,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 170,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      // shape: BoxShape.circle
                                      color: Colors.black.withOpacity(.3)
                                    ),
                                    child: Image.asset(
                                      'assets/images/d5.png',
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ) //   product: data[0].products![index],
                              )));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
