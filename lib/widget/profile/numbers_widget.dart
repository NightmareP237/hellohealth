import 'package:flutter/material.dart';
class NumbersWidget extends StatelessWidget {


  const NumbersWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
 mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(context,'4.8','Ranking'),
        buildDivider(),
        buildButton(context,'35','Following'),
        buildDivider(),
        buildButton(context,'90','Followers'),

      ],
    ),
  );

  Widget buildDivider() => Container(
height: 24,
    child: VerticalDivider(
      color: Colors.orange,
      width: 20,
    ),
  );

  Widget buildButton(BuildContext context, String value , String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2,),
          Text(text, style: TextStyle(fontSize: 20, ),
          ),
        ],
      ),
      );
}
