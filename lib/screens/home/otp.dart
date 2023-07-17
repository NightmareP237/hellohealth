import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(30, 60, 87, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(30, 60, 87, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/code.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 25,),
              Text(
                'Verification',
                style: TextStyle(fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text(
                'Entrez le code de Verification envoyé à votre Numero',
                style: TextStyle(fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30,),
              Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                length: 6,
               // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,

              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text('Verifier'),
                  style: ElevatedButton.styleFrom(
                      primary : Color(0xFF132342),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Vous n'avez pas reçu le code ?",style: TextStyle(color: Colors.black),),
                  TextButton(
                      onPressed: (){},
                      child:Text("Renvoyez le code",
                        style: TextStyle(
                          fontSize : 12,
                          color: Color(0xFF132342),
                        ),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
