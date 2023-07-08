import 'package:flutter/material.dart';
import 'package:hellohealth/widget/profile/profile_form_widget.dart';
import 'package:provider/provider.dart';
import '../../models/auth_provider.dart';
import '../../models/user.dart';
import '../../widget/profile/button_widget.dart';
import '../../widget/profile/numbers_widget.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authStateProvider = Provider.of<AuthProvider>(context, listen: false);


    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileFormWidget(
              imagePath: authStateProvider.authUser?.imagePath ?? 'assets/images/d3.png',
              onClicked: () async {
              await  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage(
                      authUser: authStateProvider.authUser!,
                      ))
              );
              setState(() {});
              },),
          SizedBox(
            height: 24,
          ),
          // buildName( authStateProvider.authUser!),
          SizedBox(
            height: 24,
          ),
          // Center(child: buildUpgradeButton()),
          SizedBox(
            height: 24,
          ),
          NumbersWidget(),
          SizedBox(
            height: 30,
          ),
          // buildAbout( authStateProvider.authUser!),
        ],
      ),
    );
  }

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              user.about ?? '',
              style: TextStyle( fontSize: 18),
            ),
          ],
        ),
      );

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            user.email,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );
}
