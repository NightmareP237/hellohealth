import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../ressources/const.dart';
import '../../widget/profile_list_item.dart';

class ProfileScreen extends StatelessWidget {
  bool swicth = false;
  @override
  Widget build(BuildContext context) {
    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          // Container(
          // height: 100,
          // width: 200,
          // margin: EdgeInsets.only(top: 15),
          // child: Stack(
          // children: <Widget>[
          // CircleAvatar(
          // radius: 15,
          // backgroundImage: AssetImage('assets/images/userProfile.png'),
          // ),
          // Align(
          // alignment: Alignment.bottomRight,
          // child: Container(
          // height: 50,
          // width: 150,
          // decoration: BoxDecoration(
          // color: Theme.of(context).accentColor,
          // shape: BoxShape.circle,
          // ),
          // child: Center(
          // heightFactor: 15,
          // widthFactor:15,
          // child: Icon(
          // Icons.edit,
          // color: primaryMain,
          // size: 15,
          // ),
          // ),
          // ),
          // ),
          // ],
          // ),
          // ),
          SizedBox(height: 25),
          Text(
            'Frank Armel',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          // SizedBox(height: kSpacingUnit.w * 0.5),
          // Text(
          //   'nicolasadams@gmail.com',
          //   style: TextStyle(fontSize: 10, color: Colors.black),
          // ),
          SizedBox(height: 15),
          Container(
            height: 30,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                'Mettre a jour son profil',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState: Theme.of(context).brightness == Brightness.dark
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () {
              // ThemeSwitcher.of(context).changeTheme(theme: kLightTheme);
            },
            child: Icon(
              Icons.spoke,
              size: 20,
            ),
          ),
          secondChild: GestureDetector(
            onTap: () {
              // ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme);
            },
            child: Icon(
              Icons.sunny,
              size: 20,
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 15),
        // Icon(
        //   Icons.arrow_left,
        //   size: ScreenUtil().setSp(kSpacingUnit.w * 3),
        // ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: 15),
      ],
    );

    return Builder(
      builder: (context) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 15),
              header,
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ProfileListItem(
                      icon: Icons.person_pin,
                      text: 'Donnees personnelles',
                    ),
                    ProfileListItem(
                      icon: Icons.history,
                      text: 'Suivit educatifs',
                    ),
                    ProfileListItem(
                      icon: Icons.contacts,
                      text: 'Contact et Aide academiques',
                    ),
                    ProfileListItem(
                      icon: Icons.settings,
                      text: 'Parametres',
                    ),
                    ProfileListItem(
                      icon: Icons.person_add,
                      text: 'Invite des amis',
                    ),
                    ProfileListItem(
                      icon: Icons.apps_outlined,
                      text: 'Deconnection',
                      hasNavigation: false,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
