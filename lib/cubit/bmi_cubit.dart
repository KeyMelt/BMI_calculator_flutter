import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'dart:math';

import 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(BmiState());

  void updateGender(Gender gender) => emit(state.copyWith(gender: gender));
  
  void updateHeight(int height) => emit(state.copyWith(height: height));
  
  void updateWeight(int weight) => emit(state.copyWith(weight: weight));
  
  void updateAge(int age) => emit(state.copyWith(age: age));

  void calculateBmi() {
    double bmi = state.weight / pow(state.height / 100, 2);
    String bmiResult = bmi.toStringAsFixed(1);
    
    String resultText;
    if (bmi >= 25) {
      resultText = 'Overweight';
    } else if (bmi > 18.5) {
      resultText = 'Normal';
    } else {
      resultText = 'Underweight';
    }

    String interpretation;
    if (bmi >= 25) {
      interpretation = 'You have a higher than normal body weight. Try to exercise more.';
    } else if (bmi >= 18.5) {
      interpretation = 'You have a normal body weight. Good job!';
    } else {
      interpretation = 'You have a lower than normal body weight. You can eat a bit more.';
    }

    emit(state.copyWith(
      bmiResult: bmiResult,
      resultText: resultText,
      interpretation: interpretation,
    ));
  }
}
