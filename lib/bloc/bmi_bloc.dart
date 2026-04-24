import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/bloc/bmi_event.dart';
import 'package:bmi_calculator/bloc/bmi_state.dart';
import 'package:bmi_calculator/services/bmi_service.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc({required BmiService bmiService})
      : _bmiService = bmiService,
        super(const BmiState()) {
    on<GenderChanged>(_onGenderChanged);
    on<HeightChanged>(_onHeightChanged);
    on<WeightIncremented>(_onWeightIncremented);
    on<WeightDecremented>(_onWeightDecremented);
    on<AgeIncremented>(_onAgeIncremented);
    on<AgeDecremented>(_onAgeDecremented);
    on<BmiCalculated>(_onBmiCalculated);
  }

  final BmiService _bmiService;

  void _onGenderChanged(GenderChanged event, Emitter<BmiState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onHeightChanged(HeightChanged event, Emitter<BmiState> emit) {
    emit(state.copyWith(height: event.height));
  }

  void _onWeightIncremented(WeightIncremented event, Emitter<BmiState> emit) {
    emit(state.copyWith(weight: state.weight + 1));
  }

  void _onWeightDecremented(WeightDecremented event, Emitter<BmiState> emit) {
    emit(state.copyWith(weight: state.weight > 1 ? state.weight - 1 : 1));
  }

  void _onAgeIncremented(AgeIncremented event, Emitter<BmiState> emit) {
    emit(state.copyWith(age: state.age + 1));
  }

  void _onAgeDecremented(AgeDecremented event, Emitter<BmiState> emit) {
    emit(state.copyWith(age: state.age > 1 ? state.age - 1 : 1));
  }

  void _onBmiCalculated(BmiCalculated event, Emitter<BmiState> emit) {
    final bmi = _bmiService.calculateBmi(
      heightInCm: state.height,
      weightInKg: state.weight,
    );

    emit(
      state.copyWith(
        bmiResult: _bmiService.formatBmi(bmi),
        resultText: _bmiService.getResultText(bmi),
        interpretation: _bmiService.getInterpretation(bmi),
      ),
    );
  }
}
