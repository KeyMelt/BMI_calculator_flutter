import 'dart:math';

class BmiService {
  double calculateBmi({
    required int heightInCm,
    required int weightInKg,
  }) {
    _validateHeight(heightInCm);
    _validateWeight(weightInKg);

    return weightInKg / pow(heightInCm / 100, 2);
  }

  String formatBmi(double bmi) {
    _validateBmi(bmi);
    return bmi.toStringAsFixed(1);
  }

  String getResultText(double bmi) {
    _validateBmi(bmi);

    if (bmi >= 25) {
      return 'Overweight';
    }
    if (bmi >= 18.5) {
      return 'Normal';
    }
    return 'Underweight';
  }

  String getInterpretation(double bmi) {
    _validateBmi(bmi);

    if (bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    }
    if (bmi >= 18.5) {
      return 'You have a normal body weight. Good job!';
    }
    return 'You have a lower than normal body weight. You can eat a bit more.';
  }

  void _validateHeight(int heightInCm) {
    if (heightInCm <= 0) {
      throw ArgumentError.value(heightInCm, 'heightInCm', 'Height must be greater than zero.');
    }
  }

  void _validateWeight(int weightInKg) {
    if (weightInKg <= 0) {
      throw ArgumentError.value(weightInKg, 'weightInKg', 'Weight must be greater than zero.');
    }
  }

  void _validateBmi(double bmi) {
    if (bmi.isNaN || bmi.isInfinite || bmi < 0) {
      throw ArgumentError.value(bmi, 'bmi', 'BMI must be a finite positive value.');
    }
  }
}
