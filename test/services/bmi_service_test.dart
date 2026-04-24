import 'package:bmi_calculator/services/bmi_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BmiService', () {
    late BmiService bmiService;

    setUp(() {
      bmiService = BmiService();
    });

    test('calculateBmi returns expected BMI for valid values', () {
      // Arrange
      const heightInCm = 180;
      const weightInKg = 81;

      // Act
      final result = bmiService.calculateBmi(
        heightInCm: heightInCm,
        weightInKg: weightInKg,
      );

      // Assert
      expect(result, closeTo(25.0, 0.01));
    });

    test('calculateBmi throws when height is zero', () {
      // Arrange
      const heightInCm = 0;
      const weightInKg = 81;

      // Act
      final call = () => bmiService.calculateBmi(
            heightInCm: heightInCm,
            weightInKg: weightInKg,
          );

      // Assert
      expect(call, throwsArgumentError);
    });

    test('calculateBmi throws when weight is zero', () {
      // Arrange
      const heightInCm = 180;
      const weightInKg = 0;

      // Act
      final call = () => bmiService.calculateBmi(
            heightInCm: heightInCm,
            weightInKg: weightInKg,
          );

      // Assert
      expect(call, throwsArgumentError);
    });

    test('formatBmi returns one decimal place', () {
      // Arrange
      const bmi = 24.6912;

      // Act
      final result = bmiService.formatBmi(bmi);

      // Assert
      expect(result, '24.7');
    });

    test('formatBmi throws for invalid BMI input', () {
      // Arrange
      const bmi = double.nan;

      // Act
      final call = () => bmiService.formatBmi(bmi);

      // Assert
      expect(call, throwsArgumentError);
    });

    test('getResultText returns Overweight for bmi >= 25', () {
      // Arrange
      const bmi = 25.0;

      // Act
      final result = bmiService.getResultText(bmi);

      // Assert
      expect(result, 'Overweight');
    });

    test('getResultText returns Normal for bmi between 18.5 and 24.9', () {
      // Arrange
      const bmi = 22.4;

      // Act
      final result = bmiService.getResultText(bmi);

      // Assert
      expect(result, 'Normal');
    });

    test('getResultText returns Underweight for bmi below 18.5', () {
      // Arrange
      const bmi = 17.9;

      // Act
      final result = bmiService.getResultText(bmi);

      // Assert
      expect(result, 'Underweight');
    });

    test('getInterpretation returns overweight message', () {
      // Arrange
      const bmi = 28.0;

      // Act
      final result = bmiService.getInterpretation(bmi);

      // Assert
      expect(result, 'You have a higher than normal body weight. Try to exercise more.');
    });

    test('getInterpretation returns normal message', () {
      // Arrange
      const bmi = 23.0;

      // Act
      final result = bmiService.getInterpretation(bmi);

      // Assert
      expect(result, 'You have a normal body weight. Good job!');
    });

    test('getInterpretation returns underweight message', () {
      // Arrange
      const bmi = 16.4;

      // Act
      final result = bmiService.getInterpretation(bmi);

      // Assert
      expect(result, 'You have a lower than normal body weight. You can eat a bit more.');
    });
  });
}
