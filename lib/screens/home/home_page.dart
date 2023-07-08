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

import 'package:flutter/material.dart';
import 'package:hellohealth/screens/home/search-doctor.dart';
import 'package:lottie/lottie.dart';
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
    Timer(
        const Duration(seconds: 5),
        () => setState(() {
              isloading = false;
              print('hello');
            }));
  }

  @override
  Widget build(BuildContext context) {
    final mapdata = [
      {
        "name": "Dr Ethan Ebode",
        "experience": "7 Years",
        "patients": "3.4 k",
        "description":"",
        'specialist': "Generalist",
        "image": "assets/images/d3.png"
      },
      {
        "name": "Dr Julio Francis ",
        "experience": "4 Years",
        "patients": "8.4 k",
        'specialist': "Dentist",
        "image": "assets/images/d5.png",
         "description":
          'Specialist dentist, he is known for his humor with patients,'
              ' young and passionate about his profession to take care of'
              ' our teeth and always keep them clean',
      },
      {
        "name": "Dr Debora Yvana",
        "experience": "8 Years",
        'specialist': "Generalist",
        "description":"",
        "patients": "4.4 k",
        "image": "assets/images/d6.jpeg"
      },
      {
        "name": "Dr Veronica Cantana",
        "experience": "5 Years",
        'specialist': "Veterinary",
         "description": 'ensure the health and well-being of all animal species and contribute '
          'to the improvement of public health, in particular with regard to diseases '
          'transmissible from animals to humans.',
        "patients": "6.4 k",
        "image": "assets/images/d7.jpeg"
      },
      {
        "name": "Dr Verclaire Simon",
        "experience": "6 Years",
        "patients": "8.4 k",
       'specialist': "Ophtamologist",
         "description": 'The queen of sight because she has dedicated her whole life '
          'to helping her patients by improving their vision',
        "image": "assets/images/d8.jpeg"
      },
      {
        "name": "Dr Juliette Estrella",
        'specialist': "Veterinary",
         "description": 'ensure the health and well-being of all animal species and contribute '
          'to the improvement of public health, in particular with regard to diseases '
          'transmissible from animals to humans.',
        "experience": "6 Years",
        "patients": "5.4 k",
        "image": "assets/images/d9.jpeg"
      },
      {
        "name": "Dr Jovanie Esther",
        'specialist': "Dermatologist",
         "description": 'is the expert in the diagnosis and treatment of skin pathologies'
          ' and general diseases affecting the skin',
        "experience": "4 Years",
        "patients": "7.4 k",
        "image": "assets/images/d10.jpeg"
      },
      {
        "name": "Dr Valerie Epie",
        'specialist': "Generalist",
        "description":"",
        "experience": "3 Years",
        "patients": "6.4 k",
        "image": "assets/images/d11.png"
      },
      {
        "name": "Dr Josiane Makuche",
        "experience": "6 Years",
        'specialist': "Rheumatologist",
        "patients": "5.4 k",
         "description": 'Specialist in diseases of the bones, joints, muscles and tendons.'
          ' It therefore treats and prevents pain in the neck, back, and all the joints'
          ' of the skeleton.',
        "image": "assets/images/d12.jpeg"
      },
      {
        "name": "Dr Dieudonne Eliote",
        'specialist': "Ophtamologist",
         "description": 'The queen of sight because she has dedicated her whole life '
          'to helping her patients by improving their vision',
        "experience": "5 Years",
        "patients": "7.4 k",
        "image": "assets/images/d13.png"
      },
      {
        "name": "Dr Estrella Ivonne",
        'specialist': "Surgeon",
        "experience": "5 Years",
        "patients": "3.4 k",
         "description": 'He started in his profession when he was still 27 years old. '
          'Very dedicated, he does not consider the risks during an operation'
          ' because he handled his tools well.',
        "image": "assets/images/d14.jpeg"
      },
    ];

    final pages = List.generate(
        10,
        (index) => GestureDetector(
              onTap: () {
                nav(DoctorView(doctorDetail: mapdata[index]), context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: primaryMain.withOpacity(.5),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                                SizedBox(height: 5),
                                Text(
                                  mapdata[index]['name'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Medecine Specialist",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Experience",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  mapdata[index]['experience'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Patients",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  mapdata[index]['patients'].toString(),
                                  style: TextStyle(
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
                        child: Image.asset(
                          mapdata[index]['image'].toString(),
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
    Future<void> getdata() async {
      setState(() {
        isloading = true;
      });
      Timer(
          const Duration(seconds: 5),
          () => setState(() {
                isloading = false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green[400],
                  content: const Text('Page is update !')));
              }));
    }
    double doublewidth = MediaQuery.of(context).size.width;
    double doubleheight = MediaQuery.of(context).size.height;
    return isloading
        ? const Homeloading()
        : Scaffold(
            body: RefreshIndicator(
              displacement: 50,
              color: primaryMain,
              onRefresh: () {
                return getdata();
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16),
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
                          SizedBox(
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
                            children: const [
                              Text(
                                "Welcome ,",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Ainna Petula",
                                style: TextStyle(
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
                              nav(SearchDoctor(), context);
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
                          SizedBox(
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
                            Text(
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
                              onTap: (){},
                              child: Container(
                                height: 100,
                                width: 120,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: primaryMain.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Lottie.asset(
                                      i == 0
                                          ? 'assets/lotties/Psychiatry.json'
                                          : 'assets/lotties/Cardiology.json',
                                      height: 70,
                                      width: 70,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      i == 0 ? 'Psychiatrist' : 'Cardiologist',
                                      style: TextStyle(
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
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryMain.withOpacity(.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                    i == 0
                                        ? 'assets/lotties/neurology.png'
                                        : 'assets/lotties/pharmacy.png',
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    i == 0 ? 'Neurosurge' : 'Mediatrician',
                                    style: TextStyle(
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
                              .getRange(4, 9)
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
                                                    e['experience'].toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                const  Text(
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
                                                    padding: EdgeInsets.all(10),
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
                                                          Icon(
                                                            Ionicons
                                                                .chatbox_ellipses_outline,
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
                                                            Colors.red.shade500,
                                                        // backgroundImage: AssetImage("assets/user.png"),
                                                        child: Center(
                                                          child: Icon(
                                                            size: 30,
                                                            Ionicons
                                                                .call_outline,
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
                                                            Ionicons
                                                                .videocam_outline,
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
                                              borderRadius:
                                                  BorderRadius.circular(16),
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
