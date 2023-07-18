import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';

import '../../ressources/const.dart';

class UpdatePro extends StatefulWidget {
  const UpdatePro({super.key});

  @override
  State<UpdatePro> createState() => _UpdateProState();
}

class _UpdateProState extends State<UpdatePro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      SingleChildScrollView(
          child: Column(children: [
        Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
                label: 'Update to Premium'.i18n(), context: context)),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              LottieBuilder.asset('assets/lotties/Syup.json'),
              messageUpdate,
            ],
          ),
        ),
        //       Text('Choose Your Premium bucket',style: NameStyle(),),
        //  Padding(
        //    padding: const EdgeInsets.all(20.0),
        //    child: Column(
        //      children: [
        //
        //      ],
        //    ),
        //  ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: redimh(context) / 3.5,
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
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: redimw(context) / 1.8,
                    height: redimh(context) / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(-2, 10),
                        ),
                      ],
                      color: primaryMain.withOpacity(.3),
                    )),
                    SizedBox(height: 16,),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: 
                    // !(this.click1 && this.click2)
                        // ? Colors.grey[400]
                     primaryMain.withOpacity(.9),
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Ionicons.star_half),
                  label: Text(
                    'Get Started !',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    // (this.click1 && this.click2)
                    //     ? nav(AddDoctor(), context)
                    //     : null;
                  },
                ),
              ],
            ),
          ),
        )
      ]))
    ])));
  }
}
