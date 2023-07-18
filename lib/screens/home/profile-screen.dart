// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:flutter/material.dart';

// import '../../ressources/const.dart';
// import '../../widget/profile_list_item.dart';

// class ProfileScreen extends StatelessWidget {
//   bool swicth = false;
//   @override
//   Widget build(BuildContext context) {
//     var profileInfo = Expanded(
//       child: Column(
//         children: <Widget>[
//           // Container(
//           // height: 100,
//           // width: 200,
//           // margin: EdgeInsets.only(top: 15),
//           // child: Stack(
//           // children: <Widget>[
//           // CircleAvatar(
//           // radius: 15,
//           // backgroundImage: AssetImage('assets/images/userProfile.png'),
//           // ),
//           // Align(
//           // alignment: Alignment.bottomRight,
//           // child: Container(
//           // height: 50,
//           // width: 150,
//           // decoration: BoxDecoration(
//           // color: Theme.of(context).accentColor,
//           // shape: BoxShape.circle,
//           // ),
//           // child: Center(
//           // heightFactor: 15,
//           // widthFactor:15,
//           // child: Icon(
//           // Icons.edit,
//           // color: primaryMain,
//           // size: 15,
//           // ),
//           // ),
//           // ),
//           // ),
//           // ],
//           // ),
//           // ),
//           SizedBox(height: 25),
//           Text(
//             'Frank Armel',
//             style: TextStyle(
//               fontSize: 12,
//             ),
//           ),
//           // SizedBox(height: kSpacingUnit.w * 0.5),
//           // Text(
//           //   'nicolasadams@gmail.com',
//           //   style: TextStyle(fontSize: 10, color: Colors.black),
//           // ),
//           SizedBox(height: 15),
//           Container(
//             height: 30,
//             width: 200,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Theme.of(context).accentColor,
//             ),
//             child: Center(
//               child: Text(
//                 'Mettre a jour son profil',
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );

//     var themeSwitcher = ThemeSwitcher(
//       builder: (context) {
//         return AnimatedCrossFade(
//           duration: Duration(milliseconds: 200),
//           crossFadeState: Theme.of(context).brightness == Brightness.dark
//               ? CrossFadeState.showFirst
//               : CrossFadeState.showSecond,
//           firstChild: GestureDetector(
//             onTap: () {
//               // ThemeSwitcher.of(context).changeTheme(theme: kLightTheme);
//             },
//             child: Icon(
//               Icons.spoke,
//               size: 20,
//             ),
//           ),
//           secondChild: GestureDetector(
//             onTap: () {
//               // ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme);
//             },
//             child: Icon(
//               Icons.sunny,
//               size: 20,
//             ),
//           ),
//         );
//       },
//     );

//     var header = Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(width: 15),
//         // Icon(
//         //   Icons.arrow_left,
//         //   size: ScreenUtil().setSp(kSpacingUnit.w * 3),
//         // ),
//         profileInfo,
//         themeSwitcher,
//         SizedBox(width: 15),
//       ],
//     );

//     return Builder(
//       builder: (context) {
//         return Scaffold(
//           body: Column(
//             children: <Widget>[
//               SizedBox(height: 15),
//               header,
//               Expanded(
//                 child: ListView(
//                   children: <Widget>[
//                     ProfileListItem(
//                       icon: Icons.person_pin,
//                       text: 'Donnees personnelles',
//                     ),
//                     ProfileListItem(
//                       icon: Icons.history,
//                       text: 'Suivit educatifs',
//                     ),
//                     ProfileListItem(
//                       icon: Icons.contacts,
//                       text: 'Contact et Aide academiques',
//                     ),
//                     ProfileListItem(
//                       icon: Icons.settings,
//                       text: 'Parametres',
//                     ),
//                     ProfileListItem(
//                       icon: Icons.person_add,
//                       text: 'Invite des amis',
//                     ),
//                     ProfileListItem(
//                       icon: Icons.apps_outlined,
//                       text: 'Deconnection',
//                       hasNavigation: false,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hellohealth/main.dart';
import 'package:hellohealth/screens/home/home_page.dart';
import 'package:hellohealth/screens/home/loading-page.dart';
import 'package:hellohealth/screens/home/personal.dart';
import 'package:hellohealth/screens/home/sign-to-doctor-mode.dart';
import 'package:hellohealth/screens/home/statut.dart';
import 'package:hellohealth/screens/home/update-to-premium.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ressources/const.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

bool loader = false;

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  getUrl() async {
    final SharedPreferences prefs = await _prefs;
    downloadUrl = prefs.getString('URL');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // finishMasterRoute = false;
    getUrl();
  }

  @override
  Widget build(BuildContext context) {
    (downloadUrl == null || downloadUrl != downloadUrl) ? getUrl() : null;
    ColorApp().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomAppBar(
                label: 'My Account', context: context, iconback: false),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 116.0,
                  horizontal: 16.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 4,
                        offset: Offset(-2, 10),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(8.0),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(-2, 10),
                                  ),
                                ],
                                color: Colors.grey[100],
                              ),
                              child: Center(
                                child: Icon(
                                  Ionicons.camera,
                                  color: primaryMain,
                                  size: 30,
                                ),
                              )),
                          if (downloadUrl != null)
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(-2, 10),
                                    ),
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        downloadUrl!,
                                      ),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome ,",
                            style: bodyStyle(Colors.black),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser!.displayName
                                .toString(),
                            style: bodyStyle(primaryMain),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(height: 1, color: Colors.black45),
                      ),
                      InkWell(
                        onTap: (() {
                          nav(SignDoctor(), context);
                        }),
                        child: SizedBox(
                          height: 88.0,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Icon(
                                    Ionicons.medical,
                                    color: primaryMain,
                                  )),
                              Text(
                                "Sign in Doctor Mode",
                                // style: bodyLightStyle(ColorApp.primaryText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Divider(height: 1, color: Colors.black54),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   SizeTransition1(const TripManagement()),
                      //     // );
                      //   },
                      //   child: Container(
                      //     height: 88.0,
                      //     width: double.infinity,
                      //     // color: primaryMain,
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(18.0),
                      //           child: Icon(Ionicons.calendar,color:primaryMain)
                      //         ),
                      //         Text(
                      //           "Management time",
                      //           // style: bodyLightStyle(ColorApp.primaryText),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Divider(height: 1, color: Colors.black54),
                      // ),
                      // InkWell(
                      //   onTap: () {
                      //     // nav(AddTripScreen(), context);
                      //   },
                      //   child: Container(
                      //     height: 88.0,
                      //     width: double.infinity,
                      //     // color: primaryMain,
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsets.all(18.0),
                      //           child: Icon(Ionicons.wallet,color: primaryMain,)
                      //         ),
                      //         Text(
                      //           'Wallets',
                      //           // style: bodyLightStyle(ColorApp.primaryText),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(height: 1, color: Colors.black45),
                      ),
                      InkWell(
                        onTap: () {
                          nav(UpdatePro(), context);
                        },
                        child: Container(
                          height: 88.0,
                          width: double.infinity,
                          // color: primaryMain,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Icon(
                                  Ionicons.star_half,
                                  color: primaryMain,
                                ),
                              ),
                              Text(
                                "Update to Premium",
                                // style: bodyLightStyle(ColorApp.primaryText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(height: 1, color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          nav(PersonnalSreen(), context);
                        },
                        child: Container(
                          height: 88.0,
                          width: double.infinity,
                          // color: primaryMain,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(18.0),
                                child: Icon(
                                  Ionicons.settings,
                                  color: primaryMain,
                                ),
                              ),
                              Text(
                                'Settings',
                                // style: bodyLightStyle(ColorApp.primaryText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(height: 1, color: Colors.black),
                      ),
                      InkWell(
                        onTap: () {
                          showDeleteUser(
                              context: context,
                              title: "Attention",
                              body:
                                  "Please do you want to delete your account ?",
                              methodYes: () {
                                Navigator.pop(context);
                                setState(() {
                                  loader = true;
                                });
                                logOut().then((value) => setState(() {
                                      loader = !value;
                                      nav(Statut(), context, close: true);
                                    }));
                              });
                        },
                        child: Container(
                          height: 88.0,
                          width: double.infinity,
                          // color: primaryMain,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Icon(
                                  Ionicons.trash,
                                  color: primaryMain,
                                ),
                              ),
                              Text(
                                "Delete Account",
                                // style: bodyLightStyle(errorHover),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider(height: 1, color: ColorApp.primaryText)
                    ],
                  ),
                ),
              ),
            ),
            // noReturnCustomAppBar(
            //   context: context,
            //   labelTranslation: "more_label",
            // ),
            // CustomAppBar(label: "More", context: context),
            if (loader) LoadingComponennt()
          ],
        ),
      ),
    );
  }
}
