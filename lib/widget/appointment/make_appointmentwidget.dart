import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MakeAppointmentFormWidget extends StatefulWidget {
  const MakeAppointmentFormWidget({Key? key}) : super(key: key);

  @override
  State<MakeAppointmentFormWidget> createState() =>
      _MakeAppointmentFormWidgetState();
}

class _MakeAppointmentFormWidgetState extends State<MakeAppointmentFormWidget> {
  final _formkey = GlobalKey<FormState>();
  String? dropdownvalue = 'Pains';
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  var items = [
    'Pains',
    'Great fatigue',
    'Yellowing of the eyes and skin',
    'Darker urine',
    'Nausea and vomiting',
    'Diarrhoea'
        'Discomfort',
    'Loss of appetite',
    'Sleep disturbances',
    'Fever and diffuse pain',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              height: 60,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/booking.png',
                    height: 150,
                    width: 200,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Ready to book !',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          height: 2),
                    ),
                  ),
                  Center(
                    child: Text('Your information is safe with us!',
                        style: TextStyle(
                            color: Colors.orange, fontSize: 14, height: 2)),
                  ),
                  Center(
                    child: TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'Enter at leaast 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Patient name :',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Text('           Symptoms ?  '),
                        DropdownButton(
                          value: dropdownvalue,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: items.map((items) {
                            return DropdownMenuItem(
                                value: items, child: Text(items));
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.orange,
                        ),
                        //icon of text field
                        labelText: "Enter Date" //label text of field
                    ),
                    readOnly: true,
                    onTap: ()  async {
                      DateTimeRange? picked = (
                          await showDateRangePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              //last date by subtracting 1 ensures it cannot be before today.
                              lastDate: DateTime(DateTime.now().year + 5),
                              initialDateRange: DateTimeRange(
                                end: DateTime.now().add(Duration(days: 7)),
                                start: DateTime.now(),
                              ),
                              builder: (context, child) {
                                return Column(
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 400.0,
                                      ),
                                      child: child,
                                    ),
                                  ],
                                );
                              }
                          )
                      );
                      print(picked!.start);
                      print(picked.end);
                      //proceed to do something with the daterange
                    },
                  ),
                  TextField(
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          color: Colors.orange,
                        ),
                        //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: Text('Confirm now !',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('My Booking'),
                            content: Text('bla bla bla'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Ok')),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Text('             Not Payment For Moment ?'),
                        // ignore: deprecated_member_use
                        TextButton(
                          child: Text(
                            'Just Save',
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
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
