import 'package:flutter/material.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:hellohealth/screens/home/create-doctor.dart';

import 'add-doctor.dart';

class SignDoctor extends StatefulWidget {
  // const SignDoctor({super.key});

  @override
  State<SignDoctor> createState() => _SignDoctorState();
}

class _SignDoctorState extends State<SignDoctor> {
  bool click1 = false;
  bool click2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          CustomAppBar(
              label: 'Sign in Doctor Mode', context: context, iconback: true),
          Padding(
            padding: EdgeInsets.only(top: redimh(context) / 7),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/signdoc.png',
                      width: double.infinity,
                      height: redimh(context) / 3.2,
                    ),
                    messageCreation,
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: redimw(context) / 20,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: redimw(context) / 1.2,
                                child: InkWell(
                                  ///CHECKBOX
                                  onTap: () {
                                    setState(() {
                                      this.click1 = !this.click1;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: click1
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primaryMain),
                                                child: const Icon(
                                                  Icons.check,
                                                  size: 10.0,
                                                  color: Colors.white,
                                                ))
                                            : Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey),
                                                child: const Icon(
                                                  Icons.check,
                                                  size: 10.0,
                                                  color: Colors.white,
                                                )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text("I agree to be a healthcare worker",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'SignikaNegative',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                            // height: 0.48,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Container(
                                width: redimw(context) / 1.2,
                                child: InkWell(
                                  ///CHECKBOX
                                  onTap: () {
                                    setState(() {
                                      this.click2 = !this.click2;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: click2
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: primaryMain),
                                                  child: const Icon(
                                                    Icons.check,
                                                    size: 10.0,
                                                    color: Colors.white,
                                                  ))
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.grey),
                                                  child: const Icon(
                                                    Icons.check,
                                                    size: 10.0,
                                                    color: Colors.white,
                                                  ))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          "I agree to provide the real information\n about me",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'SignikaNegative',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                            // height: 0.48,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ])
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: !(this.click1 && this.click2)
                            ? Colors.grey[400]
                            : primaryMain,
                        minimumSize: Size.fromHeight(50),
                      ),
                      icon: Icon(Icons.medical_information),
                      label: Text(
                        'Accept and Continue',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        (this.click1 && this.click2)
                            ? nav(AddDoctor(), context)
                            : null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
