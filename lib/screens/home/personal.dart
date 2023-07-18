import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hellohealth/screens/home/loading-page.dart';
import 'package:hellohealth/screens/home/primary-button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../ressources/const.dart';

class PersonnalSreen extends StatefulWidget {
  const PersonnalSreen({super.key});

  @override
  State<PersonnalSreen> createState() => _PersonnalSreenState();
}

// User? user = currentUser;
// String phoneNumber = currentPhoneNumber!;
// String firstName = currentFirstName!;
// String lastName = currentLastName!;
// charge() {
//   phoneNumber = currentPhoneNumber!;
//   firstName = currentFirstName!;
//   lastName = currentLastName!;
// }

bool isUpdateLoading = false;
bool isStartLoading = false;
final ImagePicker _picker = ImagePicker();

class _PersonnalSreenState extends State<PersonnalSreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> uploadImage(XFile image, BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    var storage = FirebaseStorage.instance;
    if (image != null) {
      //Upload to Firebase
      var snapshot =
          await storage.ref('Profiles/' + image.name).putFile(File(image.path));
      downloadUrl = await snapshot.ref.getDownloadURL();
      // prefs.getInt('counter');
      prefs.setString('URL', downloadUrl);
      // APIResponse response = await APIService.updateProfileUrl(
      //     uid: currentUserId!,
      //     profileUrl: downloadUrl,
      //     headers: await doHeaders());
      // currentUserProfile = downloadUrl;
      // currentUser!.profileUrl = downloadUrl;
      return true;
    } else {
      if (kDebugMode) {
        print('No Image Path Received');
      }
    }
    return false;
  }

  changeProfile({required bool isCamera}) async {
    try {
      XFile? image;
      setState(() {
        isStartLoading = true;
      });
      if (isCamera) {
        image = await _picker.pickImage(source: ImageSource.camera);
      } else {
        image = await _picker.pickImage(source: ImageSource.gallery);
      }
      if (image != null) {
        Navigator.pop(context);
        bool result = await uploadImage(image, context);
        if (result) {
          showAlertDialog(
              isError: false,
              context: context,
              title: 'Success'.i18n(),
              body: 'profile upload !'.i18n());
        } else {
          showAlertDialog(
              isError: false,
              context: context,
              title: 'Error'.i18n(),
              body: 'Image not selected .Please try again'.i18n());
        }
      } else {
        Navigator.pop(context);
        showAlertDialog(
            isError: false,
            context: context,
            title: 'Error'.i18n(),
            body: 'Image not selected .Please try again'.i18n());
        // CrashLog('error_occured_message'.i18n() +
        //     currentUserId!);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print('Error : + $e');
      }
      // CrashAsyncFunction(
      //     e,
      //     s,
      //     "${'error_occured_message'.i18n()} $e in personnal sreen",
      //     currentUserId!);
      showAlertDialog(
          context: context,
          title: 'dialog_error'.i18n(),
          body: "${'error_occured_message'.i18n()} $e",
          isError: false);
    }
    setState(() {
      // currentUserProfile = currentUserProfile;
      isStartLoading = false;
    });
  }

  initState() {
    // charge();
    // CrashUserIdentifier(currentUserId!);
    if (kDebugMode) {
      // print(jsonEncode(currentUser));
    }
    super.initState();
  }

  void updateUser(User user) async {
    if (kDebugMode) {
      print(user.toJson());
    }
    setState(() {
      isUpdateLoading = true;
    });
    var response;
    // try {
    //   response = await APIService.updateUser(
    //       user: user, headers: await doHeaders(), context: context);

    //   setState(() {
    //     isUpdateLoading = false;
    //     currentFirstName = user.firstName;
    //     currentLastName = user.lastName;
    //     currentPhoneNumber = user.phoneNumber;
    //   });
    //   if (response.error == false) {
    //     // ignore: use_build_context_synchronously
    //     Navigator.pop(context);
    //     if (kDebugMode) {
    //       print("updated !");
    //       CrashLog(currentUserId!);
    //       CrashLog(
    //           'Userid:$currentUserId Api service succesfully done in personnal sreen!');
    //     }
    //   } else {
    //     showAlertDialog(
    //         context: context,
    //         title: 'dialog_error'.i18n(),
    //         body: 'error_occured_message'.i18n());
    //     if (kDebugMode) {
    //       print("Api service error!");
    //       CrashLog(
    //           'Userid:$currentUserId Api service error in personnal sreen!');
    //     }
    //   }
    // } catch (e, s) {
    //   CrashAsyncFunction(e, s, 'error_occured_message'.i18n(), currentUserId!);
    //   showAlertDialog(
    //       context: context,
    //       title: 'dialog_error'.i18n(),
    //       body: 'error_occured_message'.i18n());
    //   if (kDebugMode) {
    //     print(e.toString());
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: CustomAppBar(
                        label: 'Settings'.i18n(), context: context)),
                Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                        child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorApp.defaultBackgroundColor,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          ColorApp.shadowColor.withOpacity(.3),
                                      blurRadius: 9,
                                      spreadRadius: 4,
                                      offset: Offset(-3, 2),
                                    ),
                                  ],
                                ),
                                // padding: EdgeInsets.all(8),
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                  color: primaryMain,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.person,
                                                color: white,
                                              ),
                                            ),
                                            if (downloadUrl != null)
                                              Container(
                                                height: 48,
                                                width: 48,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          downloadUrl!,
                                                        ),
                                                        fit: BoxFit.cover),
                                                    shape: BoxShape.circle),
                                              ),
                                          ],
                                        ),
                                        Container(
                                            height: 48,
                                            width: 232,
                                            padding: EdgeInsets.only(top: 8),
                                            child: ButtonCard(
                                                label: 'upload image'.i18n(),
                                                isOutline: false,
                                                onTap: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor: ColorApp
                                                              .defaultBackgroundColor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          16.0))),
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              14,
                                                                          left:
                                                                              24,
                                                                          right:
                                                                              24,
                                                                          bottom:
                                                                              8),
                                                                  child: Text(
                                                                    'Choose Source'
                                                                        .i18n(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: subtitleStyle(
                                                                        Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    changeProfile(
                                                                        isCamera:
                                                                            true);
                                                                  },
                                                                  child: Container(
                                                                      height: 56.0,
                                                                      width: double.infinity,
                                                                      decoration: BoxDecoration(
                                                                        color: ColorApp
                                                                            .defaultBackgroundColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(8.0)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                ColorApp.shadowColor,
                                                                            blurRadius:
                                                                                4,
                                                                            offset:
                                                                                Offset(0, 2),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              height: 40.0,
                                                                              width: 40.0,
                                                                              decoration: BoxDecoration(
                                                                                color: primaryMain,
                                                                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: ColorApp.shadowColor,
                                                                                    blurRadius: 4,
                                                                                    offset: Offset(0, 4),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(7.0),
                                                                                child: SvgPicture.asset(
                                                                                  "assets/icons/camera.svg",
                                                                                  width: 16.0,
                                                                                  color: ColorApp.fieldColor,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 16.0, right: 50.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Camera'.i18n(),
                                                                                    style: bodyStyle(Colors.black),
                                                                                  ),
                                                                                  Text(
                                                                                    "Photo",
                                                                                    style: footnoteStyle(Colors.black45),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  height: 16,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    changeProfile(
                                                                        isCamera:
                                                                            false);
                                                                  },
                                                                  child: Container(
                                                                      height: 56.0,
                                                                      width: double.infinity,
                                                                      decoration: BoxDecoration(
                                                                        color: ColorApp
                                                                            .defaultBackgroundColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(8.0)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                ColorApp.shadowColor,
                                                                            blurRadius:
                                                                                4,
                                                                            offset:
                                                                                Offset(0, 2),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              height: 40.0,
                                                                              width: 40.0,
                                                                              decoration: BoxDecoration(
                                                                                color: primaryMain,
                                                                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                                                                boxShadow: [
                                                                                  BoxShadow(
                                                                                    color: ColorApp.shadowColor,
                                                                                    blurRadius: 4,
                                                                                    offset: Offset(0, 4),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(7.0),
                                                                                child: SvgPicture.asset(
                                                                                  "assets/icons/gallery.svg",
                                                                                  width: 16.0,
                                                                                  color: ColorApp.fieldColor,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: 16.0, right: 50.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    'Gallery'.i18n(),
                                                                                    style: bodyStyle(Colors.black),
                                                                                  ),
                                                                                  Text(
                                                                                    "Image",
                                                                                    style: footnoteStyle(Colors.black45),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )),
                                                                ),
                                                                SizedBox(
                                                                  height: 16,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                })),
                                      ],
                                    )),
                              )),
                          Container(
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorApp.defaultBackgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorApp.shadowColor.withOpacity(.3),
                                    blurRadius: 9,
                                    spreadRadius: 4,
                                    offset: Offset(-3, 2),
                                  ),
                                ],
                              ),
                              // padding: EdgeInsets.all(8),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text("Enter your name".i18n(),
                                        style: bodyStyle(Colors.black)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        // color: ColorApp.fieldColor.withOpacity(.2),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: TextFormField(
                                        cursorColor: primaryMain,
                                        initialValue: "firstName",
                                        // onChanged: ((value) =>
                                        //     {firstName = value}),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 12, bottom: 8),
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                color: primaryMain,
                                                width: 1,
                                              )),
                                          enabledBorder: OutlineInputBorder(),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                color: errorMain,
                                                width: 1,
                                              )),
                                          // hintText: currentFirstName ?? firstName,
                                          hintStyle: bodyLightStyle(
                                              ColorApp.secondaryText),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Text("last_name_text".i18n(),
                                        style:
                                            bodyStyle(ColorApp.secondaryText)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: ColorApp.fieldColor,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: TextFormField(
                                        cursorColor: primaryMain,
                                        // initialValue: currentLastName,
                                        // onChanged: ((value) =>
                                        //     {lastName = value}),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 12, bottom: 8),
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                color: primaryMain,
                                                width: 1,
                                              )),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                color: errorMain,
                                                width: 1,
                                              )),
                                          // hintText: currentLastName ?? lastName,
                                          hintStyle: bodyLightStyle(
                                              ColorApp.secondaryText),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Text("phone_number_text".i18n(),
                                        style:
                                            bodyStyle(ColorApp.secondaryText)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: ColorApp.fieldColor,
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: TextFormField(
                                        cursorColor: primaryMain,
                                        // initialValue: currentPhoneNumber,
                                        // onChanged: ((value) =>
                                        //     {phoneNumber = value}),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: false, decimal: true),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 12, bottom: 8),
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                color: primaryMain,
                                                width: 1,
                                              )),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                color: errorMain,
                                                width: 1,
                                              )),
                                          // hintText: currentPhoneNumber ??
                                          //     "phone_number_hint_text".i18n(),
                                          hintStyle: bodyLightStyle(
                                              ColorApp.secondaryText),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                    ),
                                    ButtonCard(
                                        label: 'save_label'.i18n(),
                                        isOutline: false,
                                        onTap: () {
                                          // if (firstName.length < 2 ||
                                          //     lastName.length < 2) {
                                          // } else {
                                          //   if (user!.firstName == firstName &&
                                          //       user!.lastName == lastName) {
                                          //   } else {
                                          //     user!.firstName = firstName;
                                          //     user!.lastName = lastName;
                                          //     updateUser(user!);
                                          //   }
                                          // }
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))
              ]),
            ),
            if (isUpdateLoading || isStartLoading) LoadingComponennt()
          ],
        ),
      )),
    );
  }
}
