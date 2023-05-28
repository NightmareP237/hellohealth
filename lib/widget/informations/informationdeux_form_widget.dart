import 'package:flutter/material.dart';

import '../../screens/auth/login/login_page.dart';

class InformationDeuxFormWidget extends StatefulWidget {
  const InformationDeuxFormWidget({Key? key}) : super(key: key);

  @override
  State<InformationDeuxFormWidget> createState() =>
      _InformationDeuxFormWidgetState();
}

class _InformationDeuxFormWidgetState extends State<InformationDeuxFormWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              height: 70,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                ),
                Image.asset(
                  'assets/images/stet.png',
                  width: 70,
                ),
                Text(
                  'HelloHealth',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Column(
              children: [
                Center(
                  child:Image.asset('assets/images/d17.png',width: 500,height: 200,) ,
                ),
              ],
            ),
            Column(
              children: [
                Center(
                  child: Text('We are a platform that brings',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.orange,),),
                ),
                Center(
                  child: Text('Smiles back and want to keep it',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.orange,),),
                ),
                Center(
                  child: Text('That way for as long as possible.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.orange,),),
                ),
              ],
            ),
            Container(
              height: 50,
            ),
            ElevatedButton(
              onPressed: ()  {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginPage()));
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
