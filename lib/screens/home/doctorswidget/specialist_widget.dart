import 'package:flutter/material.dart';

import '../../../models/CardItem.dart';
import '../carditem/cardItemWidget.dart';

class SpecialistsWidget extends StatefulWidget {
  const SpecialistsWidget({Key? key}) : super(key: key);

  @override
  State<SpecialistsWidget> createState() => _SpecialistsWidgetState();
}

class _SpecialistsWidgetState extends State<SpecialistsWidget> {
  List<CardItem> items1 = [
    CardItem(
      urlImage: 'assets/images/d5.png',
      title: 'Dr Ondaphe Arthur',
      profession: 'Dentist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '3',
      description:
          'Specialist dentist, he is known for his humor with patients,'
              ' young and passionate about his profession to take care of'
              ' our teeth and always keep them clean',
      rating: '3.2',
    ),
    CardItem(
      urlImage: 'assets/images/d3.png',
      title: ' Dr Jules Toukam',
      profession: 'Surgeon',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '15',
      description: 'He started in his profession when he was still 27 years old. '
          'Very dedicated, he does not consider the risks during an operation'
          ' because he handled his tools well.',
      rating: '10.2',
    ),
    CardItem(
      urlImage: 'assets/images/d6.jpeg',
      title: 'Dr Dr Caline',
      profession: 'Ophtamologist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '122',
      anexperience: '8',
      description: 'The queen of sight because she has dedicated her whole life '
          'to helping her patients by improving their vision',
      rating: '6.2',
    ),
    CardItem(
      urlImage: 'assets/images/d7.jpeg',
      title: 'Dr Nono lesly',
      profession: 'Rheumatologist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '1250',
      anexperience: '19',
      description: 'Specialist in diseases of the bones, joints, muscles and tendons.'
          ' It therefore treats and prevents pain in the neck, back, and all the joints'
          ' of the skeleton.',
      rating: '12.1',
    ),
    CardItem(
      urlImage: 'assets/images/d8.jpeg',
      title: 'Dr Merime',
      profession: 'Dermatologist',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '1600',
      anexperience: '25',
      description: 'is the expert in the diagnosis and treatment of skin pathologies'
          ' and general diseases affecting the skin',
      rating: '22.9',
    ),
    CardItem(
      urlImage: 'assets/images/d9.jpeg',
      title: 'Yimen nelly',
      profession: 'Veterinary ',
      lieudeservice: 'Edimed Clinic',
      nbrepatients: '1120',
      anexperience: '12',
      description: 'ensure the health and well-being of all animal species and contribute '
          'to the improvement of public health, in particular with regard to diseases '
          'transmissible from animals to humans.',
      rating: '11.3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 16,
            runAlignment: WrapAlignment.spaceBetween,
            runSpacing: 16,
            children: List.generate(items1.length, (index) => CardItemWidget(item: items1[index])),
          ),
        ),
      ),);
  }
}
