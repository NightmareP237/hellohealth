import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/CardItem.dart';
import '../../screens/appointment/make_appointment_page.dart';

class DoctorsInfosGeneralistsWidget extends StatefulWidget {
  final CardItem item;

  DoctorsInfosGeneralistsWidget({required this.item});

  @override
  State<DoctorsInfosGeneralistsWidget> createState() =>
      _DoctorsInfosGeneralistsWidgetState();
}

class _DoctorsInfosGeneralistsWidgetState
    extends State<DoctorsInfosGeneralistsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.item.urlImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: const SafeArea(
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.item.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                      '${widget.item.profession} * ${widget.item.lieudeservice}',style: const TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.item.title} : ${widget.item.description}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Spacer(),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              'Experience',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.item.anexperience),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Yr(s)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const VerticalDivider(
                          thickness: 2,
                          color: Colors.orange,
                        ),
                        Column(
                          children: [
                            const Text(
                              'Patients',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.item.nbrepatients),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'Ps',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const VerticalDivider(
                          thickness: 2,
                          color: Colors.orange,
                        ),
                        Column(
                          children: [
                            const Text(
                              'Ratings',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(widget.item.rating),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.orange,
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/ci.jpeg',
                              ),
                            ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // ignore: deprecated_member_use
                            launch(
                                'mailto:kuimivicky@gmail.com?subject=This is Subject Title&body=This is Body of Email');
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width - 104,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.orange,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MakeAppointmentPage()));
                          },
                          child: const Center(child: const Text('Make an Appointment')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
