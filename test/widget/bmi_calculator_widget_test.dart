import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/screens/input_page.dart';
import 'package:bmi_calculator/services/bmi_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpCalculatorApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2560);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      BlocProvider(
        create: (_) => BmiBloc(bmiService: BmiService()),
        child: const MaterialApp(
          home: InputPage(),
        ),
      ),
    );
  }

  group('BMI calculator widgets', () {
    testWidgets('renders all main UI components', (tester) async {
      // Arrange
      await pumpCalculatorApp(tester);

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Age'), findsOneWidget);
      expect(find.text('Weight (KG)'), findsOneWidget);
      expect(find.text('Height (CM)'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
      expect(find.byKey(const Key('height_slider')), findsOneWidget);
      expect(find.byKey(const Key('gender_male_button')), findsOneWidget);
      expect(find.byKey(const Key('gender_female_button')), findsOneWidget);
      expect(find.byKey(const Key('calculate_bmi_button')), findsOneWidget);
    });

    testWidgets('increments and decrements age', (tester) async {
      // Arrange
      await pumpCalculatorApp(tester);

      // Act
      final initialAge = tester.widget<Text>(find.byKey(const Key('age_value_text'))).data;
      await tester.tap(find.byKey(const Key('age_increment_button')));
      await tester.pumpAndSettle();
      final incrementedAge = tester.widget<Text>(find.byKey(const Key('age_value_text'))).data;
      await tester.tap(find.byKey(const Key('age_decrement_button')));
      await tester.pumpAndSettle();
      final finalAge = tester.widget<Text>(find.byKey(const Key('age_value_text'))).data;

      // Assert
      expect(initialAge, '20');
      expect(incrementedAge, '21');
      expect(finalAge, '20');
    });

    testWidgets('increments and decrements weight', (tester) async {
      // Arrange
      await pumpCalculatorApp(tester);

      // Act
      final initialWeight = tester.widget<Text>(find.byKey(const Key('weight_value_text'))).data;
      await tester.tap(find.byKey(const Key('weight_increment_button')));
      await tester.pumpAndSettle();
      final incrementedWeight = tester.widget<Text>(find.byKey(const Key('weight_value_text'))).data;
      await tester.tap(find.byKey(const Key('weight_decrement_button')));
      await tester.pumpAndSettle();
      final finalWeight = tester.widget<Text>(find.byKey(const Key('weight_value_text'))).data;

      // Assert
      expect(initialWeight, '60');
      expect(incrementedWeight, '61');
      expect(finalWeight, '60');
    });

    testWidgets('updates height from slider drag', (tester) async {
      // Arrange
      await pumpCalculatorApp(tester);
      final slider = find.byKey(const Key('height_slider'));
      final initialHeight = tester.widget<Text>(find.byKey(const Key('height_value_text'))).data;

      // Act
      await tester.drag(slider, const Offset(100, 0));
      await tester.pumpAndSettle();
      final updatedHeight = tester.widget<Text>(find.byKey(const Key('height_value_text'))).data;

      // Assert
      expect(initialHeight, '180');
      expect(updatedHeight, isNot('180'));
    });

    testWidgets('selects female gender', (tester) async {
      // Arrange
      await pumpCalculatorApp(tester);

      // Act
      await tester.tap(find.byKey(const Key('gender_female_button')));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Female'), findsOneWidget);
      final femaleText = tester.widget<Text>(find.text('Female'));
      expect(femaleText.style?.color, Colors.white);
    });

    testWidgets('navigates to results page after calculation', (tester) async {
      // Arrange
      await pumpCalculatorApp(tester);

      // Act
      await tester.tap(find.byKey(const Key('calculate_bmi_button')));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('bmi_results_title')), findsOneWidget);
      expect(find.byKey(const Key('bmi_result_value')), findsOneWidget);
      expect(find.byKey(const Key('bmi_result_label')), findsOneWidget);
      expect(find.byKey(const Key('bmi_result_interpretation')), findsOneWidget);
      expect(find.byKey(const Key('save_results_button')), findsOneWidget);
    });
  });
}
