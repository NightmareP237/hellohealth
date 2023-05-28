import 'package:flutter/material.dart';
import '../../models/CardItem.dart';
import '../carditem/cardItemWidget.dart';

class GeneralistsWidget extends StatefulWidget {
  //const GeneralistsWidget({Key? key}) : super(key: key);

  @override
  State<GeneralistsWidget> createState() => _GeneralistsWidgetState();
}

class _GeneralistsWidgetState extends State<GeneralistsWidget> {
  List<CardItem> items = [
    CardItem(
      urlImage: 'assets/images/d15.png',
      title: 'Dr Noubaka',
      profession: 'Generalist',
      lieudeservice: 'Deido Clinic',
      nbrepatients: '1291',
      anexperience: '5',
      description: 'blablabla',
      rating: '4.3',
    ),
    CardItem(
      urlImage: 'assets/images/d11.png',
      title: ' Dr Kuimi Victorine',
      profession: 'Generalist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '3',
      description: 'blablabla',
      rating: '3.2',
    ),
    CardItem(
      urlImage: 'assets/images/d12.jpeg',
      title: 'Dr Marie',
      profession: 'Generalist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '3',
      description: 'blablabla',
      rating: '3.2',
    ),
    CardItem(
      urlImage: 'assets/images/d13.png',
      title: 'Dr Kamto Nathan',
      profession: 'Generalist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '3',
      description: 'blablabla',
      rating: '3.2',
    ),
    CardItem(
      urlImage: 'assets/images/d14.jpeg',
      title: 'Dr Christelle',
      profession: 'Generalist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '3',
      description: 'blablabla',
      rating: '3.2',
    ),
    CardItem(
      urlImage: 'assets/images/d10.jpeg',
      title: 'Dr Arielle',
      profession: 'Generalist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '3',
      description: 'blablabla',
      rating: '3.2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 250,
        child: ListView.separated(
          padding: EdgeInsets.all(16),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (context, _) => SizedBox(width: 12,),
          itemBuilder: (context, index) => CardItemWidget( item: items[index] ),
        ),
      ),
    );
  }

}
