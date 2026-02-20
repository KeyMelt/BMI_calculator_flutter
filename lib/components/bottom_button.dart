import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.onTap, required this.buttonTitle});

  final void Function() onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
        decoration: BoxDecoration(
          color: kBottomContainerColour,
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}
