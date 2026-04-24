import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/bloc/bmi_event.dart';
import 'package:bmi_calculator/bloc/bmi_state.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/components/gender_toggle.dart';
import 'package:bmi_calculator/models/gender.dart';

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('BMI CALCULATOR')),
      ),
      body: SafeArea(
        child: BlocBuilder<BmiBloc, BmiState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
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
                                        const Text(
                                          'Age',
                                          style: kLabelTextStyle,
                                        ),
                                        Text(
                                          state.age.toString(),
                                          key: const Key('age_value_text'),
                                          style: kNumberTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            RoundIconButton(
                                              key: const Key('age_decrement_button'),
                                              icon: FontAwesomeIcons.minus,
                                              onPressed: () {
                                                context.read<BmiBloc>().add(const AgeDecremented());
                                              },
                                            ),
                                            const SizedBox(width: 15.0),
                                            RoundIconButton(
                                              key: const Key('age_increment_button'),
                                              icon: FontAwesomeIcons.plus,
                                              onPressed: () {
                                                context.read<BmiBloc>().add(const AgeIncremented());
                                              },
                                            ),
                                          ],
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
                                        const Text(
                                          'Weight (KG)',
                                          style: kLabelTextStyle,
                                        ),
                                        Text(
                                          state.weight.toString(),
                                          key: const Key('weight_value_text'),
                                          style: kNumberTextStyle,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            RoundIconButton(
                                              key: const Key('weight_decrement_button'),
                                              icon: FontAwesomeIcons.minus,
                                              onPressed: () {
                                                context.read<BmiBloc>().add(const WeightDecremented());
                                              },
                                            ),
                                            const SizedBox(width: 15.0),
                                            RoundIconButton(
                                              key: const Key('weight_increment_button'),
                                              icon: FontAwesomeIcons.plus,
                                              onPressed: () {
                                                context.read<BmiBloc>().add(const WeightIncremented());
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
                                  const Text(
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
                                        key: const Key('height_value_text'),
                                        style: kNumberTextStyle,
                                      ),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor: kInactiveCardColour,
                                      activeTrackColor: kBottomContainerColour,
                                      thumbColor: kBottomContainerColour,
                                      overlayColor: kBottomContainerColour.withValues(alpha: 0.12),
                                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
                                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Row(
                                        children: [
                                          Text('50 cm', style: kLabelTextStyle.copyWith(fontSize: 12)),
                                          Expanded(
                                            child: Slider(
                                              key: const Key('height_slider'),
                                              value: state.height.toDouble(),
                                              min: 50.0,
                                              max: 300.0,
                                              onChanged: (double newValue) {
                                                context.read<BmiBloc>().add(
                                                      HeightChanged(newValue.round()),
                                                    );
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
                                  const Text(
                                    'Gender',
                                    style: kLabelTextStyle,
                                  ),
                                  const SizedBox(height: 15.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: GenderToggle(
                                      selectedGender: state.gender,
                                      onChanged: (Gender gender) {
                                        context.read<BmiBloc>().add(GenderChanged(gender));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BottomButton(
                            key: const Key('calculate_bmi_button'),
                            buttonTitle: 'Calculate BMI',
                            onTap: () {
                              context.read<BmiBloc>().add(const BmiCalculated());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResultsPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
