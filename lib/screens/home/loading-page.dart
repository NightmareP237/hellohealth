import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingComponennt extends StatelessWidget {
  const LoadingComponennt({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      color: Colors.black.withOpacity(.2),
      child: Center(
          child: LottieBuilder.asset(
        'assets/lotties/loading.json',
        height: h / 3,
        width: w / 3,
      )),
    );
  }
}
