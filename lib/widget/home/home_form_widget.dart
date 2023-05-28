import 'package:flutter/material.dart';
import '../../screens/appointment/make_appointment_page.dart';
import '../doctorswidget/generalists_widget.dart';
import '../doctorswidget/specialist_widget.dart';

class HomeFormWidget extends StatefulWidget {
  const HomeFormWidget({Key? key}) : super(key: key);

  @override
  State<HomeFormWidget> createState() => _HomeFormWidgetState();
}

class _HomeFormWidgetState extends State<HomeFormWidget>
    with SingleTickerProviderStateMixin {
  final tabPagesWidget = [
    SpecialistsWidget(),
    GeneralistsWidget(),
  ];

  final tabBar = [
    Tab(
      text: 'Specialist',
    ),
    Tab(
      text: 'Generalists',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: 'How can we help you ?',
                  ),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            Container(
              child: Text(
                'Doctors',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Flexible(
              child: DefaultTabController(
                length: tabBar.length,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xfffbfcff),
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.grey[200]!,
                          ),
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey[200]!,
                          ),
                        ),
                      ),
                      child: TabBar(
                        indicatorColor: Colors.orange[200],
                        unselectedLabelColor: Colors.grey,
                        tabs: tabBar,
                      ),
                    ),
                    Flexible(
                      child: TabBarView(
                        children: tabPagesWidget,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),

            Container(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                   Text('Flutter tutorial by woolha.com', style: const TextStyle(color: Colors.teal)),
                  Icon(Icons.widgets),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
