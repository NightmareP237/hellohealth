import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/auth_provider.dart';
import '../../widget/home/home_form_widget.dart';
import '../appointment/user_appointment_page.dart';
import '../auth/login/login_page.dart';
import '../profile/aproposdenous_page.dart';
import '../profile/edit_profile_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

_makingPhoneCall() async {
  var url = Uri.parse("tel:677148646");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    HomeFormWidget(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('HelloHealth'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.orange,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8),
                    Text('LogOut'),
                  ],
                ),
                value: 'LogOut',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'LogOut') {
                authProvider.logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.routeName, (Route<dynamic> route) => false);
              }
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Feed',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Colors.green,
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authStateProvider = Provider.of<AuthProvider>(context, listen: false);

    Widget buildHeader(BuildContext context)  {
      return
        Material(
          color: Colors.orange,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.orange,
              padding: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .padding
                    .top,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 52,
                    //  backgroundImage: ,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    authStateProvider.authUser?.name ?? '',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                  Text(
                    authStateProvider.authUser?.email ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
  }
    Widget buildMenuItems(BuildContext context) {
      final AuthProvider authStateProvider =
      Provider.of<AuthProvider>(context);
      return
        Container(
          padding: EdgeInsets.all(24),
          child: Wrap(
            runSpacing: 16,
            children: [
              ListTile(
                leading: Icon(Icons.favorite_border),
                title: Text('Favourites'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.corporate_fare),
                title: Text('Appointments'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserAppointmentPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.create_new_folder),
                title: Text('Search Lab'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.border_color),
                title: Text('Edit Profile'),
                onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage(authUser: authStateProvider.authUser!,)));
                },
              ),
              ListTile(
                leading: Icon(Icons.add_ic_call_outlined),
                title: Text('Call HelloHealthCenter'),
                onTap: () {
                  _makingPhoneCall();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.bedtime),
                title: Text('day/night'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.mail_outline_rounded),
                title: Text('Languages'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.article),
                title: Text('About Us'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AProposDeNous()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Exit'),
                onTap: () {
                  authStateProvider.logOut();
                 Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.routeName, (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        );
    }

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }
}
