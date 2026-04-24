import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:bmi_calculator/cubit/bmi_observer.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/services/bmi_service.dart';

void main() {
  Bloc.observer = BmiObserver();
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BmiBloc(bmiService: BmiService()),
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
        home: const InputPage(),
      ),
    );
  }
}
