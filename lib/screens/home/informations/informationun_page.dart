import 'package:flutter/material.dart';

import 'informationun_form_widget.dart';

class InformationUnPage extends StatefulWidget {
  const InformationUnPage({Key? key}) : super(key: key);

  @override
  State<InformationUnPage> createState() => _InformationUnPageState();
}

class _InformationUnPageState extends State<InformationUnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InformationUnFormWidget(),
    );
  }
}
