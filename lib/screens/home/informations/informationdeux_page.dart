import 'package:flutter/material.dart';

import 'informationdeux_form_widget.dart';


class InformationDeuxPage extends StatefulWidget {
  const InformationDeuxPage({Key? key}) : super(key: key);

  @override
  State<InformationDeuxPage> createState() => _InformationDeuxPageState();
}

class _InformationDeuxPageState extends State<InformationDeuxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InformationDeuxFormWidget(),
    );
  }
}
