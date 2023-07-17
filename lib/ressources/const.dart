import 'package:flutter/material.dart';
import 'package:hellohealth/screens/home/home_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellohealth/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';

import '../models/Appointment.dart';

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

List AGE = ['Child', 'Adult', 'Old'];
const String appId = "fe0402efdded41f59f5209511cb1e0d9";

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

// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

String tenantName = '';
String tenantID = '';
String tenantDomainApp = 'numcloud.cm';
// String TRIPS_SERVICE_API_URL = "";
// String BOOKINGS_SERVICE_API_URL = "";
// String USERS_SERVICE_API_URL = "";

// String TRIPS_SERVICE_API_URL = dotenv.env['TRIPS_SERVICE_API_URL']!;
// String BOOKINGS_SERVICE_API_URL = dotenv.env['BOOKINGS_SERVICE_API_URL']!;
// String USERS_SERVICE_API_URL = dotenv.env['USERS_SERVICE_API_URL']!;
// String DASHBOARD_SERVICE_API_URL = dotenv.env['DASHBOARD_SERVICE_API_URL']!;

var theme;
FirebaseAuth authInstance = FirebaseAuth.instance;

Future<bool> logOut() async {
  try {
    await authInstance.signOut();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> DeleteAccount() async {
  try {
    authInstance.currentUser!.delete().then((value) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authInstance.currentUser!.uid)
          .delete();
    });
    print("sucessfull delte acount");
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double setSizeProportionnedBasic(BuildContext context, double size) {
  return (size * MediaQuery.of(context).size.width) / 1440;
}

CrashAsyncFunction(e, s, String specific_error, String UserId) async {
  if (!kIsWeb) {
    FirebaseCrashlytics.instance.setUserIdentifier(UserId);
    await FirebaseCrashlytics.instance.recordError(e, s,
        reason: 'fatal error from $specific_error userid: $UserId',
        fatal: true);
  }
}

CrashLog(String info) {
  if (!kIsWeb) {
    FirebaseCrashlytics.instance.log(info);
  }
}

CrashUserIdentifier(String UserId) {
  if (!kIsWeb) {
    FirebaseCrashlytics.instance.setUserIdentifier(UserId);
  }
}

bool isRunningOnWeb(BuildContext context) {
  return kIsWeb;
}

Future<void> getCurrentThemeIsDark() async {
  bool result = false;
  final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
      .platformBrightness;
  var pref = await SharedPreferences.getInstance();
  if (pref.getString("themeMode") == AdaptiveThemeMode.light) {
    result = false;
  } else if (pref.getString("themeMode") == AdaptiveThemeMode.dark) {
    result = true;
  } else if (brightness == Brightness.dark) {
    result = true;
  } else {
    result = false;
  }
  if (!result) {
    theme = false;
  } else {
    theme = true;
  }
}

List<String> rulesForUsers = [
  "${"clerk"}-clerk",
  "${"manager"}-manager",
  "${"owner"}-owner"
];

class ColorApp {
  static late Color shadowColor;
  static late Color primaryText;
  static late Color secondaryText;
  static late Color disabledText;
  static late Color fieldColor;
  static late Color blackWhiteColor;
  static late Color defaultBackgroundColor;
  static late Color separateColor;
  static late Color bagwhite;
  void init(BuildContext context) {
    primaryText = Theme.of(context).primaryColorLight;
    secondaryText = Theme.of(context).primaryColorDark;
    fieldColor = Theme.of(context).unselectedWidgetColor;
    disabledText = Theme.of(context).disabledColor;
    shadowColor = Theme.of(context).shadowColor;
    defaultBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    blackWhiteColor = Theme.of(context).cardColor;
    separateColor = Theme.of(context).canvasColor;
    bagwhite = Theme.of(context).primaryColorDark;
  }
}

// Color primaryMain = Color(0xff3DD6D0);
// Color primaryHover = Color(0xff64DED9);
// Color primaryClick = Color(0xff31ABA6);
Color white = Color(0xffFFFFFF);
Color bagwhite = Colors.black;

//  Color shadowColor=
Color errorMain = Color(0xffFF4842);
Color errorHover = Color(0xffFF6D68);
Color errorClick = Color(0xffCC3A35);

//  Color primaryText = Color(0xff242424);
//  Color secondaryText = ColorApp.secondaryText;
//  Color disabledText = Color(0xffD3D3D3);
//  Color fieldColor = Color(0xffF8F8F8);
// Color defaultBackgroundColor = Color(0xffFFFFFF);
int defaultTextStyle = 16;
int shadow = 4;

TextStyle onBoardTextStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w700,
      // height: 0.8,
      fontSize: 53,
    );
TextStyle titleStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w700,
      // height: 0.64,
      fontSize: 24,
    );
TextStyle supertitleStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w700,
      // height: 0.8,
      fontSize: 32,
    );
TextStyle subtitleStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      // height: 0.56,
    );
TextStyle bodyBoldStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w800,
      fontSize: 18,
      // height: 0.48,
    );
TextStyle bodyStyle(Color c) => TextStyle(
    color: c,
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    // height: 0.48,
    inherit: false);
TextStyle bodyFieldStyle(Color c) => TextStyle(
      color: c,
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      // textBaseline: TextBaseline.alphabetic
      // height: 15.0
    );
TextStyle bodyLightStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: 16,
    // height: 0.48,
    color: c);
TextStyle footnoteStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    // height: 0.32,
    color: c);
TextStyle footfilterStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    // height: 0.32,
    color: c);
TextStyle SeetingStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: 16,
    height: 0,
    color: c);
TextStyle overlineStyle(Color c) => TextStyle(
      fontFamily: 'SignikaNegative',
      fontWeight: FontWeight.w600,
      fontSize: 10,
      // height: 0.32,
      color: c,
    );
TextStyle buttonStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    // height: 0.48,
    letterSpacing: 1,
    color: c);
TextStyle linkStyle(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: c);
TextStyle linkFootnoteStyle(Color c) {
  return TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w500,
      fontSize: 12,
      // height: 0.32,
      color: c);
}

Size mediaQuery(BuildContext context) => MediaQuery.of(context).size;

Future<void> showAlertDialog(
    {required BuildContext context,
    required String title,
    required String body,
    required bool? isError,
    VoidCallback? method}) {
  // ignore: missing_return
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: subtitleStyle((isError != null && isError)
                        ? errorMain
                        : ColorApp.secondaryText),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    body,
                    // maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorApp.secondaryText,
                        fontFamily: 'SignikaNegative',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        inherit: false),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Divider(
                  height: 1,
                  color: ColorApp.secondaryText.withOpacity(0.5),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        method;
                      },
                      child: Text(
                        "done_text",
                        style: buttonStyle(primaryMain),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> showAlertDialog2(
    {required BuildContext context,
    required String title,
    String? body,
    required void Function()? methodYes,
    VoidCallback? methodNo}) {
  // ignore: missing_return
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 24, left: 24, right: 24, bottom: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: subtitleStyle(ColorApp.secondaryText),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                if (body != null)
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Center(
                      child: Text(body,
                          // maxLines: 2,
                          textAlign: TextAlign.center,
                          style: bodyStyle(ColorApp.secondaryText)),
                    ),
                  ),
                const SizedBox(
                  height: 28,
                ),
                Divider(
                  height: 1,
                  color: ColorApp.secondaryText.withOpacity(0.5),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            methodNo;
                          },
                          child: Center(
                            child: Text(
                              "no_text",
                              style: buttonStyle(ColorApp.disabledText),
                            ),
                          )),
                      Container(height: 50, width: 1, color: Color(0xFFE1E1E1)),
                      TextButton(
                          onPressed: methodYes,
                          child: Center(
                            child: Text(
                              "yes_text",
                              style: buttonStyle(primaryMain),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Future showAlertDialogWithSubtitle(
    {required BuildContext context,
    required String title,
    required String subtitle,
    required String body,
    VoidCallback? method}) {
  // ignore: missing_return
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: subtitleStyle(ColorApp.secondaryText),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 8),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: footnoteStyle(ColorApp.secondaryText),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Center(
                    child: Text(
                      body,
                      // maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorApp.secondaryText,
                          fontFamily: 'SignikaNegative',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          inherit: false),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Divider(
                  height: 1,
                  color: ColorApp.secondaryText.withOpacity(0.5),
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop("isDone");
                        method;
                      },
                      child: Text(
                        "done_text",
                        style: buttonStyle(primaryMain),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> showDeleteUser(
    {required BuildContext context,
    required String title,
    required String body,
    VoidCallback? methodYes,
    VoidCallback? methodNo}) {
  // ignore: missing_return
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 24, left: 24, right: 24, bottom: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: subtitleStyle(errorMain),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 48,
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Center(
                    child: Text(
                      body,
                      // maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SignikaNegative',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          inherit: false),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Divider(
                  height: 1,
                  color: ColorApp.secondaryText.withOpacity(0.5),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            FocusScope.of(context).requestFocus(FocusNode());
                            methodNo;
                          },
                          child: Text(
                            "No",
                            style: buttonStyle(Colors.black),
                          )),
                      Container(height: 50, width: 1, color: Color(0xFFE1E1E1)),
                      TextButton(
                          onPressed: methodYes,
                          child: Text(
                            "Yes",
                            style: buttonStyle(errorMain),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

var downloadUrl;

Future<void> AllocateConfirm(
    {required BuildContext context,
    required String title,
    required String body,
    VoidCallback? methodYes,
    VoidCallback? methodNo}) {
  // ignore: missing_return
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 24, left: 24, right: 24, bottom: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: subtitleStyle(ColorApp.secondaryText),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 48,
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Center(
                    child: Text(
                      body,
                      // maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorApp.secondaryText,
                          fontFamily: 'SignikaNegative',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          inherit: false),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                Divider(
                  height: 1,
                  color: ColorApp.secondaryText.withOpacity(0.5),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            FocusScope.of(context).requestFocus(FocusNode());
                            methodNo;
                          },
                          child: Text(
                            "nodelete_text",
                            style: buttonStyle(ColorApp.secondaryText),
                          )),
                      Container(height: 50, width: 1, color: Color(0xFFE1E1E1)),
                      TextButton(
                          onPressed: methodYes,
                          child: Text(
                            "Allouer",
                            style: buttonStyle(primaryMain),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget customContainer(
        {required Widget element, bool space = false, required Widget value}) =>
    Container(
      decoration: BoxDecoration(
        color: ColorApp.defaultBackgroundColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: ColorApp.shadowColor,
            blurRadius: 9,
            spreadRadius: 4,
            offset: Offset(-3, 2),
          ),
        ],
      ),
      // padding: EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            element,
            !space
                ? SizedBox(
                    height: 8,
                  )
                : SizedBox(),
            value,
            space
                ? SizedBox(
                    height: 3,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );

Widget CustomAppBar(
        {required String label,
        required BuildContext context,
        bool search = false,
        bool iconback = true,
        bool hasIcon = false,
        bool hasRadius = true,
        bool hasShadow = true,
        String iconName = "search",
        Function(String)? searchTyping,
        VoidCallback? onTapIcon}) =>
    Container(
      height: search ? 150 : 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorApp.defaultBackgroundColor,
        borderRadius: hasRadius
            ? BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24))
            : null,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: ColorApp.shadowColor.withOpacity(.3),
                  blurRadius: 9,
                  spreadRadius: 4,
                  offset: Offset(2, 0),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  iconback
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).pop("isPop");
                          },
                          child: Container(
                            height: 60,
                            margin: const EdgeInsets.only(top: 2, left: 16),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 25,
                              color: primaryMain,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 2, left: 16),
                          height: 60,
                        ),
                  Container(
                    height: 28,
                    margin: const EdgeInsets.only(top: 2, left: 16),
                    child: Center(
                        child: Text(
                      label,
                      style: subtitleStyle(Colors.black),
                    )),
                  ),
                  // const Icon(Icons.filter)
                ],
              ),
              hasIcon
                  ? GestureDetector(
                      onTap: onTapIcon,
                      child: Container(
                        margin: const EdgeInsets.only(top: 42, right: 16),
                        child: Center(
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            child: SvgPicture.asset(
                              "assets/icons/$iconName.svg",
                              width: 25,
                              color: primaryMain,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
              // hasIcon
              //     ? GestureDetector(
              //         onTap: onTapIcon,
              //         child: Container(
              //           height: 60,
              //           margin: EdgeInsets.only(top: 42, left: 16),
              //           child: Icon(
              //             Icons.arrow_back_ios_new_rounded,
              //             size: 25,
              //             color: primaryMain,
              //           ),
              //         ),
              //       )
              //     : Container(
              //         margin: EdgeInsets.only(top: 42, left: 16),
              //         height: 60,
              //       ),
              // Container(
              //   height: 28,
              //   margin: EdgeInsets.only(top: 48, left: 16),
              //   child: Center(
              //       child: Text(
              //     label,
              //     style: subtitleStyle(ColorApp.primaryText),
              //   )
              //   ),
              // ),
            ],
          ),
          search
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 40,
                    // width: 278,
                    decoration: BoxDecoration(
                      color: ColorApp.fieldColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextFormField(
                      cursorColor: primaryMain,
                      initialValue: "",
                      obscureText: false,
                      onChanged: searchTyping,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: mediaQuery(context).width * .03,
                            top: mediaQuery(context).width * .01,
                            bottom: mediaQuery(context).width * .005),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "assets/icons/search.svg",
                            width: 20,
                            color: ColorApp.blackWhiteColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              color: primaryMain,
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              color: errorMain,
                              width: 1,
                            )),
                        hintText: "search_filed_label",
                        hintStyle: bodyLightStyle(ColorApp.secondaryText),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );

Container TicketButton(String buttonName, Color buttonColor, Icon icon,
        {bool position = true}) =>
    Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: buttonColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  SvgPicture.asset(
          //         UrlSvg,
          //         width: 16,
          //         color: ColorApp.defaultBackgroundColor,
          //       )
          position ? icon : const SizedBox(),
          const SizedBox(
            width: 10,
          ),
          Text(buttonName, style: buttonStyle(Colors.white)),
          const SizedBox(
            width: 10,
          ),
          !position ? icon : const SizedBox(),
        ],
      ),
    );

// nav(Widget navigate, BuildContext context, {bool close = false}) {
//   close
//       ? Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (_) => navigate), (route) => false)
//       : Navigator.push(
//           context,
//           SizeTransition1(
//             navigate,
//           ),
//         );
// }

navigate(Widget navigate, BuildContext context, {bool close = false}) {
  close
      ? Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => navigate), (route) => false)
      : Navigator.push(context, MaterialPageRoute(builder: (_) => navigate));
}

TextStyle logoutbutton(Color c) => TextStyle(
    fontFamily: 'SignikaNegative',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    height: 0.48,
    letterSpacing: 1,
    color: c);

// getMessage() {
// //Firebase messaging function handlerin foreground
//   return FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('Got a message whilst in the foreground!');
//     print('Message data: ${message.data}');
//     // return message.data;
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
// }

Widget separatedContainer(
    {required String label,
    required String value,
    TextStyle? valueStyle,
    bool choice = false}) {
  return Container(
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: footnoteStyle(ColorApp.disabledText),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            choice
                ? SvgPicture.asset(
                    "assets/icons/edit.svg",
                    width: 25,
                    color: primaryMain,
                  )
                : const SizedBox(),
            const SizedBox(
              width: 5,
            ),
            Text(
              value,
              style: (valueStyle != null)
                  ? valueStyle
                  : subtitleStyle(ColorApp.secondaryText),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget messageCreation = Container(
  width: double.infinity,
  height: 80,
  margin: const EdgeInsets.only(top: 16),
  decoration:
      BoxDecoration(color: primaryMain, borderRadius: BorderRadius.circular(8)),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: Text(
        'you are a healthcare worker so register on HelloHealh and get patients online !',
        style: bodyStyle(ColorApp.defaultBackgroundColor),
        textAlign: TextAlign.center,
      ),
    ),
  ),
);

Widget noReturnCustomAppBar(
    {required BuildContext context,
    required String labelTranslation,
    bool search = false}) {
  return Container(
    height: search ? 160 : 92,
    width: double.infinity,
    decoration: BoxDecoration(
      color: ColorApp.defaultBackgroundColor,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      boxShadow: [
        BoxShadow(
          color: ColorApp.shadowColor,
          blurRadius: 9,
          spreadRadius: 4,
          offset: Offset(2, 0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              height: 28,
              margin: EdgeInsets.only(top: 48, left: 16),
              child: Center(
                  child: Text(
                labelTranslation,
                style: subtitleStyle(ColorApp.primaryText),
              )),
            ),
          ],
        ),
        search
            ? Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20,
                ),
                child: Container(
                  // margin: EdgeInsets.only(bottom: 16),
                  height: 40,
                  // width: 278,
                  decoration: BoxDecoration(
                    color: ColorApp.fieldColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextFormField(
                    cursorColor: primaryMain,
                    initialValue: "",
                    obscureText: false,
                    onChanged: ((value) => {}),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: mediaQuery(context).width * .03,
                          top: mediaQuery(context).width * .01,
                          bottom: mediaQuery(context).width * .005),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          width: 20,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                            color: primaryMain,
                            width: 1,
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                            color: errorMain,
                            width: 1,
                          )),
                      hintText: "search_filed_label",
                      hintStyle: bodyLightStyle(ColorApp.secondaryText),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}

const seatMapData = {
  "data": [
    {
      "rows": 1,
      "cols": 2,
      "left_cols": 0,
      "right_cols": 2,
      "data": [
        [
          {"seat": 1, "available": true},
          {"seat": 2, "available": false},
        ],
      ],
    },
    {
      "rows": 2,
      "cols": 5,
      "left_cols": 3,
      "right_cols": 2,
      "data": [
        [
          {"seat": 3, "available": true},
          {"seat": 4, "available": false},
          {"seat": 5, "available": false},
          {"seat": 6, "available": false},
          {"seat": 7, "available": true},
        ],
        [
          {"seat": 8, "available": true},
          {"seat": 9, "available": false},
          {"seat": 10, "available": false},
          {"seat": 11, "available": false},
          {"seat": 12, "available": true},
        ],
      ],
    },
    {
      "rows": 1,
      "cols": 3,
      "left_cols": 3,
      "right_cols": 0,
      "data": [
        [
          {"seat": 13, "available": true},
          {"seat": 14, "available": false},
          {"seat": 15, "available": false},
        ],
      ],
    },
    {
      "rows": 8,
      "cols": 5,
      "left_cols": 3,
      "right_cols": 2,
      "data": [
        [
          {"seat": 16, "available": true},
          {"seat": 17, "available": false},
          {"seat": 18, "available": false},
          {"seat": 19, "available": false},
          {"seat": 20, "available": true},
        ],
        [
          {"seat": 21, "available": true},
          {"seat": 22, "available": false},
          {"seat": 23, "available": false},
          {"seat": 24, "available": false},
          {"seat": 25, "available": true},
        ],
        [
          {"seat": 26, "available": true},
          {"seat": 27, "available": false},
          {"seat": 28, "available": false},
          {"seat": 29, "available": false},
          {"seat": 30, "available": true},
        ],
        [
          {"seat": 31, "available": true},
          {"seat": 32, "available": false},
          {"seat": 33, "available": false},
          {"seat": 34, "available": false},
          {"seat": 35, "available": true},
        ],
        [
          {"seat": 36, "available": true},
          {"seat": 37, "available": false},
          {"seat": 38, "available": false},
          {"seat": 39, "available": false},
          {"seat": 40, "available": true},
        ],
        [
          {"seat": 41, "available": true},
          {"seat": 42, "available": false},
          {"seat": 43, "available": false},
          {"seat": 44, "available": false},
          {"seat": 45, "available": true},
        ],
        [
          {"seat": 46, "available": true},
          {"seat": 47, "available": false},
          {"seat": 48, "available": false},
          {"seat": 49, "available": false},
          {"seat": 50, "available": true},
        ],
        [
          {"seat": 51, "available": true},
          {"seat": 52, "available": false},
          {"seat": 53, "available": false},
          {"seat": 54, "available": false},
          {"seat": 55, "available": true},
        ],
      ],
    },
    {
      "rows": 1,
      "cols": 3,
      "left_cols": 3,
      "right_cols": 0,
      "data": [
        [
          {"seat": 56, "available": true},
          {"seat": 57, "available": false},
          {"seat": 58, "available": false},
        ],
      ],
    },
    {
      "rows": 1,
      "cols": 5,
      "left_cols": 3,
      "right_cols": 2,
      "data": [
        [
          {"seat": 59, "available": true},
          {"seat": 60, "available": false},
          {"seat": 61, "available": false},
          {"seat": 62, "available": false},
          {"seat": 63, "available": true},
        ],
      ],
    },
    {
      "rows": 1,
      "cols": 5,
      "left_cols": 3,
      "right_cols": 2,
      "data": [
        [
          {"seat": 64, "available": true},
          {"seat": 65, "available": false},
          {"seat": 66, "available": false},
          {"seat": 67, "available": false},
          {"seat": 68, "available": true},
          {"seat": 69, "available": true},
        ],
      ],
    },
  ],
};
AppBar appbar(BuildContext context, var txt, {bool arrow = true}) => AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: arrow
          ? GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Ionicons.arrow_back,
                color: Colors.black,
              ),
            )
          : null,
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
