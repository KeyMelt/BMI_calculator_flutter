import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/components/gender_toggle.dart';
import 'package:bmi_calculator/cubit/bmi_cubit.dart';
import 'package:bmi_calculator/cubit/bmi_state.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALCULATOR')),
      ),
      body: BlocBuilder<BmiCubit, BmiState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Age',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              state.age.toString(),
                              style: kNumberTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    context.read<BmiCubit>().updateAge(state.age - 1);
                                  },
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    context.read<BmiCubit>().updateAge(state.age + 1);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Weight (KG)',
                              style: kLabelTextStyle,
                            ),
                            Text(
                              state.weight.toString(),
                              style: kNumberTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    context.read<BmiCubit>().updateWeight(state.weight - 1);
                                  },
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    context.read<BmiCubit>().updateWeight(state.weight + 1);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Height (CM)',
                        style: kLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            state.height.toString(),
                            style: kNumberTextStyle,
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          inactiveTrackColor: kInactiveCardColour,
                          activeTrackColor: kBottomContainerColour,
                          thumbColor: kBottomContainerColour,
                          overlayColor: kBottomContainerColour.withOpacity(0.12),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 15.0),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text('50 cm', style: kLabelTextStyle.copyWith(fontSize: 12)),
                              Expanded(
                                child: Slider(
                                  value: state.height.toDouble(),
                                  min: 50.0,
                                  max: 300.0,
                                  onChanged: (double newValue) {
                                    context.read<BmiCubit>().updateHeight(newValue.round());
                                  },
                                ),
                              ),
                              Text('300 cm', style: kLabelTextStyle.copyWith(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Gender',
                        style: kLabelTextStyle,
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GenderToggle(
                          selectedGender: state.gender,
                          onChanged: (Gender gender) {
                            context.read<BmiCubit>().updateGender(gender);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BottomButton(
                buttonTitle: 'Calculate BMI',
                onTap: () {
                  context.read<BmiCubit>().calculateBmi();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultsPage(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
