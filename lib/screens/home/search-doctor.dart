import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hellohealth/ressources/const.dart';
import 'package:intl/intl.dart';

class SearchDoctor extends StatefulWidget {
  const SearchDoctor({super.key});

  @override
  State<SearchDoctor> createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  final dateInput = TextEditingController();
  final doctor = TextEditingController();
  final selectarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, "Search Here"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Search Your ,",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Specialist",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextFormField(
                cursorColor: Colors.orange,
                key: ValueKey('area'),
                validator: (val) => (val == null || val.length > 3)
                    ? 'Please select your area'
                    : null,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  iconColor: Colors.orange,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  labelText: 'Select Area',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                ),
                onSaved: (val) {
                  // _userPassword = val!;
                },
              ),
              TextFormField(
                cursorColor: Colors.orange,
                key: ValueKey('doctor'),
                validator: (val) => (val == null || val.length < 7)
                    ? 'Please enter your doctor/specialist'
                    : null,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  iconColor: Colors.orange,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  labelText: 'Doctor,Specialist',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                ),
                onSaved: (val) {
                  // _userPassword = val!;
                },
              ),
              // TextFormField(
              //   cursorColor: Colors.orange,
              //   key: ValueKey('password'),
              //   validator: (val) => (val == null || val.length < 7)
              //       ? 'Password must be least 7 characters long!'
              //       : null,
              //   autofocus: false,
              //   obscureText: true,
               
              //   onSaved: (val) {
              //     // _userPassword = val!;
              //   },
              // ),
              TextField(
                controller: dateInput,
                //editing controller of this TextField
                decoration: const InputDecoration(
                  iconColor: Colors.orange,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  labelText: 'Select date',
                  contentPadding:
                      EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.orange,
                    ),
                    ),
                readOnly: true,
                onTap: () async {
                  var today = DateTime.now();
                  var fiftyDaysFromNow = today.add(new Duration(days: 3));
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null &&
                      pickedDate.isAfter(today) &&
                      pickedDate.isBefore(fiftyDaysFromNow)) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      // dateInput.text =
                      //     formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // _trySubmit();
                },
                child: Container(
                  width: 340,
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange.withOpacity(.7),
                  ),
                  child: Center(
                    child: Text(
                      "Search",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
