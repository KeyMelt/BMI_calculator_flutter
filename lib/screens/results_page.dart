import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/bloc/bmi_state.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/bottom_button.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('BMI CALCULATOR')),
      ),
      body: BlocBuilder<BmiBloc, BmiState>(
        builder: (context, state) {
          final bmiString = state.bmiResult;
          final splitBmi = bmiString.split('.');
          final integerPart = splitBmi[0];
          final decimalPart = splitBmi.length > 1 ? '.${splitBmi[1]}' : '';

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Body Mass Index',
                  style: kTitleTextStyle.copyWith(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'BMI Results',
                        key: const Key('bmi_results_title'),
                        style: kLabelTextStyle,
                      ),
                      const SizedBox(height: 10.0),
                      RichText(
                        key: const Key('bmi_result_value'),
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: integerPart,
                              style: kBMITextStyle,
                            ),
                            TextSpan(
                              text: decimalPart,
                              style: kBMITextStyle.copyWith(fontSize: 50.0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        state.resultText.toUpperCase() + ' BMI',
                        key: const Key('bmi_result_label'),
                        style: kBodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          state.interpretation,
                          key: const Key('bmi_result_interpretation'),
                          textAlign: TextAlign.center,
                          style: kBodyTextStyle.copyWith(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                key: const Key('save_results_button'),
                buttonTitle: 'Save the results',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
