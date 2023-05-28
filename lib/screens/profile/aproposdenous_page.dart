import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AProposDeNous extends StatefulWidget {
  const AProposDeNous({Key? key}) : super(key: key);

  @override
  State<AProposDeNous> createState() => _AProposDeNousState();
}

_makingPhoneCall() async {
  var url = Uri.parse("tel:677148646");
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _AProposDeNousState extends State<AProposDeNous> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 60,
          ),
          Center(
            child: Image.asset('assets/images/ts.png'),
          ),
          Center(
            child: Text('We are a platform that aims to connect the local '
                'or even global population with passionate doctors, '
                'who are always ready to do those why they have been asked, '
                'this being the case, your health concerns us as much as them, '
                'which is why this network we have set up is a way for us to '
                'contribute to your health expectations thank you for always trusting us.'),
          ),
          ElevatedButton(
            onPressed: () {
              // ignore: deprecated_member_use
              launch(
                  'mailto:kuimivicky@gmail.com?subject=This is Subject Title&body=This is Body of Email');
            },
            child: Text("Send An Email"),
          ),
          ListTile(
            leading: Icon(Icons.add_ic_call_outlined),
            title: Text('Call HelloHealthCenter'),
            onTap: () {
              _makingPhoneCall();
            },
          ),
        ],
      ),
    );
  }
}
