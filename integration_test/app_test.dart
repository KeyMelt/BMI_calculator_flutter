import 'package:bmi_calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('full BMI calculator flow works', (tester) async {
    // Arrange
    await tester.pumpWidget(const BMICalculator());
    await tester.pumpAndSettle();

    // Act
    await tester.tap(find.byKey(const Key('gender_male_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('age_increment_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('weight_increment_button')));
    await tester.pumpAndSettle();
    await tester.drag(find.byKey(const Key('height_slider')), const Offset(60, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('calculate_bmi_button')));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byKey(const Key('bmi_results_title')), findsOneWidget);
    expect(find.byKey(const Key('bmi_result_value')), findsOneWidget);
    expect(find.byKey(const Key('bmi_result_label')), findsOneWidget);
    expect(find.byKey(const Key('bmi_result_interpretation')), findsOneWidget);
    expect(find.textContaining('BMI'), findsWidgets);
  });
}
