import 'package:bmi_calculator/screens/input_page.dart';

class BmiState {
  final Gender? gender;
  final int height;
  final int weight;
  final int age;
  final String bmiResult;
  final String resultText;
  final String interpretation;

  BmiState({
    this.gender,
    this.height = 180,
    this.weight = 60,
    this.age = 20,
    this.bmiResult = '',
    this.resultText = '',
    this.interpretation = '',
  });

  BmiState copyWith({
    Gender? gender,
    int? height,
    int? weight,
    int? age,
    String? bmiResult,
    String? resultText,
    String? interpretation,
    bool clearGender = false,
  }) {
    return BmiState(
      gender: clearGender ? null : (gender ?? this.gender),
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      bmiResult: bmiResult ?? this.bmiResult,
      resultText: resultText ?? this.resultText,
      interpretation: interpretation ?? this.interpretation,
    );
  }

  @override
  String toString() {
    return 'BmiState(gender: $gender, height: $height, weight: $weight, age: $age, bmiResult: $bmiResult, resultText: $resultText, interpretation: $interpretation)';
  }
}
