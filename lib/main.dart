import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:bmi_calculator/cubit/bmi_observer.dart';
import 'package:bmi_calculator/cubit/bmi_cubit.dart';
import 'package:bmi_calculator/constants.dart';

void main() {
  Bloc.observer = BmiObserver();
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BmiCubit(),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: kBottomContainerColour,
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: kBackgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: kPrimaryTextColor),
            titleTextStyle: TextStyle(
              color: kPrimaryTextColor,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        home: InputPage(),
      ),
    );
  }
}
