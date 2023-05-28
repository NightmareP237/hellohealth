import 'package:flutter/material.dart';

import '../../screens/informations/informationdeux_page.dart';

class InformationUnFormWidget extends StatefulWidget {
  const InformationUnFormWidget({Key? key}) : super(key: key);

  @override
  State<InformationUnFormWidget> createState() => _InformationUnFormWidgetState();
}

class _InformationUnFormWidgetState extends State<InformationUnFormWidget> {
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
                Container(width: 60,),
                Image.asset('assets/images/stet.png', width: 70,),
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
                  child:Image.asset('assets/images/d16.png',width: 500,height: 200,) ,
                ),
              ],
            ),
            Column(
              children: [
                Center(
                  child: Text('Your well-being starts here ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,),),
                ),
                Center(
                  child: Text( 'Enjoy With Us And',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,),),
                ),
                Center(
                  child: Text( 'Talk About Experience',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,),),
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
                        builder: (context) => InformationDeuxPage()));
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
