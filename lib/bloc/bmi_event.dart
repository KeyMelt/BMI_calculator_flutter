import 'package:bmi_calculator/models/gender.dart';

sealed class BmiEvent {
  const BmiEvent();
}

class GenderChanged extends BmiEvent {
  const GenderChanged(this.gender);

  final Gender gender;
}

class HeightChanged extends BmiEvent {
  const HeightChanged(this.height);

  final int height;
}

class WeightIncremented extends BmiEvent {
  const WeightIncremented();
}

class WeightDecremented extends BmiEvent {
  const WeightDecremented();
}

class AgeIncremented extends BmiEvent {
  const AgeIncremented();
}

class AgeDecremented extends BmiEvent {
  const AgeDecremented();
}

class BmiCalculated extends BmiEvent {
  const BmiCalculated();
}
