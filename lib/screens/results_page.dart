import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/cubit/bmi_cubit.dart';
import 'package:bmi_calculator/cubit/bmi_state.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
      ),
      body: BlocBuilder<BmiCubit, BmiState>(
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
                        color: Colors.black.withOpacity(0.05),
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
                        style: kLabelTextStyle,
                      ),
                      SizedBox(height: 10.0),
                      RichText(
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
                      SizedBox(height: 10.0),
                      Text(
                        state.resultText.toUpperCase() + ' BMI',
                        style: kBodyTextStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          state.interpretation,
                          textAlign: TextAlign.center,
                          style: kBodyTextStyle.copyWith(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
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
