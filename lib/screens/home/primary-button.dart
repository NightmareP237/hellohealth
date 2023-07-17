import 'package:flutter/material.dart';
// import 'package:e_booking_mobile_app/ressources/const.dart';

import '../../ressources/const.dart';

class ButtonCard extends StatelessWidget {
  ButtonCard(
      {Key? key,
      required this.label,
      required this.isOutline,
      required this.onTap,
      this.isDisabled = false})
      : super(key: key);
  final String label;
  final bool isOutline;
  final bool isDisabled;
   VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: (!isOutline)
            ? BoxDecoration(
                color: isDisabled ? ColorApp.disabledText : primaryMain,
                borderRadius: BorderRadius.circular(4.0),
              )
            : BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: isDisabled ? ColorApp.disabledText : primaryMain),
                borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Text(
            label,
            style: buttonStyle((!isOutline)
                ? white
                : isDisabled
                    ? ColorApp.blackWhiteColor
                    : primaryMain),
          ),
        ),
      ),
    );
  }
}