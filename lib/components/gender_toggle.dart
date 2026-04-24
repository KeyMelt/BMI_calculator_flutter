import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/models/gender.dart';

class GenderToggle extends StatelessWidget {
  const GenderToggle({super.key, required this.selectedGender, required this.onChanged});

  final Gender? selectedGender;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: selectedGender == Gender.male
                ? Alignment.centerLeft
                : (selectedGender == Gender.female
                    ? Alignment.centerRight
                    : Alignment.center),
            child: selectedGender == null
                ? SizedBox.shrink()
                : Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    decoration: BoxDecoration(
                      color: kBottomContainerColour,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: kBottomContainerColour.withValues(alpha: 0.3),
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  key: const Key('gender_male_button'),
                  onTap: () => onChanged(Gender.male),
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: selectedGender == Gender.male
                              ? Colors.white
                              : kLabelTextStyle.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  key: const Key('gender_female_button'),
                  onTap: () => onChanged(Gender.female),
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: selectedGender == Gender.female
                              ? Colors.white
                              : kLabelTextStyle.color,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
