// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../models/auth_provider.dart';
// import '../../widget/home/home_form_widget.dart';
// import '../appointment/user_appointment_page.dart';
// import '../auth/login/login_page.dart';
// import '../profile/aproposdenous_page.dart';
// import '../profile/edit_profile_page.dart';
// import '../profile/profile_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// _makingPhoneCall() async {
//   var url = Uri.parse("tel:677148646");
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// class _HomePageState extends State<HomePage> {
//   int currentIndex = 0;
//   final screens = [
//     HomeFormWidget(),
//     ProfilePage(),
//   ];
//   void initialization() async {
//     // This is where you can initialize the resources needed by your app while
//     // the splash screen is displayed.  Remove the following example because
//     // delaying the user experience is a bad design practice!
//     // ignore_for_file: avoid_print
//     print('ready in 3...');
//     await Future.delayed(const Duration(seconds: 1));
//     print('ready in 2...');
//     await Future.delayed(const Duration(seconds: 1));
//     print('ready in 1...');
//     await Future.delayed(const Duration(seconds: 1));
//     print('go!');
//     FlutterNativeSplash.remove();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     initialization();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthProvider authProvider = Provider.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HelloHealth'),
//         actions: [
//           DropdownButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: Colors.orange,
//             ),
//             items: [
//               DropdownMenuItem(
//                 child: Row(
//                   children: [
//                     Icon(Icons.exit_to_app),
//                     SizedBox(width: 8),
//                     Text('LogOut'),
//                   ],
//                 ),
//                 value: 'LogOut',
//               )
//             ],
//             onChanged: (itemIdentifier) {
//               if (itemIdentifier == 'LogOut') {
//                 authProvider.logOut();
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                     LoginPage.routeName, (Route<dynamic> route) => false);
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: NavigationDrawer(),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         onTap: (index) => setState(() => currentIndex = index),
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//             backgroundColor: Colors.orange,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//             backgroundColor: Colors.blue,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Feed',
//             backgroundColor: Colors.red,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat),
//             label: 'Chat',
//             backgroundColor: Colors.green,
//           ),
//         ],
//       ),
//       body: screens[currentIndex],
//     );
//   }
// }

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final AuthProvider authStateProvider =
//         Provider.of<AuthProvider>(context, listen: false);

//     Widget buildHeader(BuildContext context) {
//       return Material(
//         color: Colors.orange,
//         child: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Container(
//             color: Colors.orange,
//             padding: EdgeInsets.only(
//               top: MediaQuery.of(context).padding.top,
//             ),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 52,
//                   //  backgroundImage: ,
//                 ),
//                 SizedBox(
//                   height: 12,
//                 ),
//                 Text(
//                   authStateProvider.authUser?.name ?? '',
//                   style: TextStyle(fontSize: 28, color: Colors.white),
//                 ),
//                 Text(
//                   authStateProvider.authUser?.email ?? '',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     Widget buildMenuItems(BuildContext context) {
//       final AuthProvider authStateProvider = Provider.of<AuthProvider>(context);
//       return Container(
//         padding: EdgeInsets.all(24),
//         child: Wrap(
//           runSpacing: 16,
//           children: [
//             ListTile(
//               leading: Icon(Icons.favorite_border),
//               title: Text('Favourites'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.corporate_fare),
//               title: Text('Appointments'),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => UserAppointmentPage()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.create_new_folder),
//               title: Text('Search Lab'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.border_color),
//               title: Text('Edit Profile'),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => EditProfilePage(
//                               authUser: authStateProvider.authUser!,
//                             )));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.add_ic_call_outlined),
//               title: Text('Call HelloHealthCenter'),
//               onTap: () {
//                 _makingPhoneCall();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.share),
//               title: Text('Share'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.bedtime),
//               title: Text('day/night'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.mail_outline_rounded),
//               title: Text('Languages'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.article),
//               title: Text('About Us'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => AProposDeNous()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.exit_to_app),
//               title: Text('Exit'),
//               onTap: () {
//                 authStateProvider.logOut();
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                     LoginPage.routeName, (Route<dynamic> route) => false);
//               },
//             ),
//           ],
//         ),
//       );
//     }

//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             buildHeader(context),
//             buildMenuItems(context),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/models/doctor.dart';
import 'package:hellohealth/screens/home/search-doctor.dart';
import 'package:hellohealth/screens/home/video-call.dart';
import 'package:hellohealth/screens/home/voice-call-doctor.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletons/skeletons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../ressources/const.dart';
import 'package:ionicons/ionicons.dart';

import 'doctor-info-view.dart';
import 'loading-home-page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool isloading = true;

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  void initState() {
    super.initState();
    getDoctor();
  }

  List<Doctor> mapdata = [];
  Future<bool> getDoctor() async {
    try {
      setState(() {
        isloading = true;
      });
      await FirebaseFirestore.instance
          .collection('doctors')
          .limit(10)
          .get(GetOptions(source: Source.server))
          .then((value) async {
        mapdata = Doctor.fromQuerySnapshot(value);
        print(mapdata.length);
        setState(() {
          isloading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green[400],
              content: const Text('Page is update !')));
        });
        return false;
      });
    } catch (e) {
      setState(() {
        isloading = true;
      });
      print(e);
      setState(() {
        isloading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red[400],
            content: const Text('Network Connection !')));
      });
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        mapdata.length,
        (index) => GestureDetector(
              onTap: () {
                (mapdata[index].image.isEmpty)
                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red[300],
                        content: const Text('Please wait loading image...')))
                    : nav(DoctorView(doctorDetail: mapdata[index]), context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: primaryMain.withOpacity(.5),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Container(
                  height: 280,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text(
                                  mapdata[index].name.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Medecine Specialist",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Experience",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  mapdata[index].experience.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Patients",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  mapdata[index].patients.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.network(
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ));
                          },
                          mapdata[index].image,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));

    double doublewidth = MediaQuery.of(context).size.width;
    double doubleheight = MediaQuery.of(context).size.height;
    return (isloading && mapdata.isEmpty)
        ? const Homeloading()
        : Scaffold(
            body: RefreshIndicator(
              displacement: 50,
              color: primaryMain,
              onRefresh: () {
                return getDoctor();
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               const Text(
                      //                 "Welcome, you are a health staff then register !",
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.bold,
                      //                     fontStyle: FontStyle.italic),
                      //               ),
                      //               SizedBox(
                      //                 height: 8,
                      //               ),
                      //               Row(
                      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   GestureDetector(
                      //                     onTap: () {
                      //                       // _trySubmit();
                      //                     },
                      //                     child: Container(
                      //                       width: doublewidth / 2.25,
                      //                       height: 40,
                      //                       padding: EdgeInsets.all(10),
                      //                       decoration: BoxDecoration(
                      //                         borderRadius: BorderRadius.circular(5),
                      //                         color: Colors.green.withOpacity(.7),
                      //                       ),
                      //                       child: Center(
                      //                         child: Text(
                      //                           "Sign In",
                      //                           style: TextStyle(
                      //                               fontWeight: FontWeight.w600,
                      //                               color: Colors.white,
                      //                               fontSize: 16),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   GestureDetector(
                      //                     onTap: () {
                      //                       // _trySubmit();
                      //                     },
                      //                     child: Container(
                      //                       width: doublewidth / 2.25,
                      //                       height: 40,
                      //                       padding: EdgeInsets.all(10),
                      //                       decoration: BoxDecoration(
                      //                         borderRadius: BorderRadius.circular(5),
                      //                         color: Colors.orange.withOpacity(.7),
                      //                       ),
                      //                       child: Center(
                      //                         child: Text(
                      //                           "Sign Up",
                      //                           style: TextStyle(
                      //                               fontWeight: FontWeight.w600,
                      //                               color: Colors.white,
                      //                               fontSize: 16),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade400,
                            // backgroundImage: AssetImage("assets/user.png"),
                            child: const Center(
                              child: Icon(
                                Ionicons.person,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome ,",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                FirebaseAuth.instance.currentUser!.displayName
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // iconWidget(FontAwesomeIcons.bagShopping, true),
                          GestureDetector(
                            onTap: () {
                              nav(const SearchDoctor(), context);
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.shade400,
                              // backgroundImage: AssetImage("assets/user.png"),
                              child: const Center(
                                child: Icon(
                                  Ionicons.search,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade400,
                            // backgroundImage: AssetImage("assets/user.png"),
                            child: const Center(
                                child: Icon(
                              Ionicons.notifications,
                              color: Colors.black87,
                            )),
                          ),
                          const SizedBox(
                            width: 12,
                          )
                        ],
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        height: 240,
                        child: PageView.builder(
                          controller: controller,
                          // itemCount: pages.length,
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 12),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Find Your ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "Doctor",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              // TextSpan(
                              //   text: "Hay Markets",
                              //   style: TextStyle(
                              //     fontSize: 35,
                              //     color: Colors.black87,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: WormEffect(
                          dotHeight: 16,
                          dotWidth: 16,
                          dotColor: Colors.grey.shade400,
                          activeDotColor: primaryMain,
                          type: WormType.thinUnderground,
                        ),
                      ),
                      //
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, bottom: 8, left: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Categories',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(children: [
                          for (int i = 0; i <= 1; i++)
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 100,
                                width: 120,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: primaryMain.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Lottie.asset(
                                      i == 0
                                          ? 'assets/lotties/Psychiatry.json'
                                          : 'assets/lotties/Cardiology.json',
                                      height: 70,
                                      width: 70,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      i == 0 ? 'Psychiatrist' : 'Cardiologist',
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          for (int i = 0; i <= 1; i++)
                            Container(
                              height: 100,
                              width: 120,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryMain.withOpacity(.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                    i == 0
                                        ? 'assets/lotties/neurology.png'
                                        : 'assets/lotties/pharmacy.png',
                                    height: 70,
                                    width: 70,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    i == 0 ? 'Neurosurge' : 'Mediatrician',
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 8, left: 16, right: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Available Doctor',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            const Text(
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
                              .getRange(4, 9)
                              .map((e) => Container(
                                    // height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: primaryMain.withOpacity(.5),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Container(
                                      height: 280,
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    e.name.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
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
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    "This Doctor is Online ...",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    "Message and Call are Open !",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    width: 200,
                                                    height: 40,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.green
                                                          .withOpacity(.7),
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          const Icon(
                                                            Ionicons
                                                                .logo_whatsapp,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "messages",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
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
                                                      const SizedBox(
                                                        width: 25,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          nav(const VoiceCall(),
                                                              context);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade500,
                                                          // backgroundImage: AssetImage("assets/user.png"),
                                                          child: const Center(
                                                            child: Icon(
                                                              size: 30,
                                                              Ionicons
                                                                  .call_outline,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          // nav( VideoCall(),
                                                          //     context);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 30,
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade500,
                                                          // backgroundImage: AssetImage("assets/user.png"),
                                                          child: const Center(
                                                            child: Icon(
                                                              Ionicons
                                                                  .videocam_outline,
                                                              color:
                                                                  Colors.white,
                                                              size: 30,
                                                            ),
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
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Colors.white,
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ));
                                              },
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

                      // Container(
                      //   child: SmoothPageIndicator(
                      //     controller: controller,
                      //     count: pages.length,
                      //     effect: JumpingDotEffect(
                      //       dotHeight: 16,
                      //       dotWidth: 16,
                      //       jumpScale: .7,
                      //       verticalOffset: 15,
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 16, bottom: 12),
                      //   child: Text(
                      //     'Scrolling Dots',
                      //     style: TextStyle(color: Colors.black54),
                      //   ),
                      // ),
                      // SmoothPageIndicator(
                      //     controller: controller,
                      //     count: pages.length,
                      //     effect: ScrollingDotsEffect(
                      //       activeStrokeWidth: 2.6,
                      //       activeDotScale: 1.3,
                      //       maxVisibleDots: 5,
                      //       radius: 8,
                      //       spacing: 10,
                      //       dotHeight: 12,
                      //       dotWidth: 12,
                      //     )),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 16, bottom: 16),
                      //   child: Text(
                      //     'Customizable Effect',
                      //     style: TextStyle(color: Colors.black54),
                      //   ),
                      // ),
                      // Container(
                      //   // color: Colors.red.withOpacity(.4),
                      //   child: SmoothPageIndicator(
                      //     controller: controller,
                      //     count: pages.length,
                      //     effect: CustomizableEffect(
                      //       activeDotDecoration: DotDecoration(
                      //         width: 32,
                      //         height: 12,
                      //         color: Colors.indigo,
                      //         rotationAngle: 180,
                      //         verticalOffset: -10,
                      //         borderRadius: BorderRadius.circular(24),
                      //         // dotBorder: DotBorder(
                      //         //   padding: 2,
                      //         //   width: 2,
                      //         //   color: Colors.indigo,
                      //         // ),
                      //       ),
                      //       dotDecoration: DotDecoration(
                      //         width: 24,
                      //         height: 12,
                      //         color: Colors.grey,
                      //         // dotBorder: DotBorder(
                      //         //   padding: 2,
                      //         //   width: 2,
                      //         //   color: Colors.grey,
                      //         // ),
                      //         // borderRadius: BorderRadius.only(
                      //         //     topLeft: Radius.circular(2),
                      //         //     topRight: Radius.circular(16),
                      //         //     bottomLeft: Radius.circular(16),
                      //         //     bottomRight: Radius.circular(2)),
                      //         borderRadius: BorderRadius.circular(16),
                      //         verticalOffset: 0,
                      //       ),
                      //       spacing: 6.0,
                      //       // activeColorOverride: (i) => colors[i],
                      //       inActiveColorOverride: (i) => colors[i],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

final colors = [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
