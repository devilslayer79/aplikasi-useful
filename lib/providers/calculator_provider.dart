import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic/calculator_logic.dart';

class CalculatorNotifier extends Notifier<String> {
  final CalculatorLogic _logic = CalculatorLogic();

  @override
  String build() {
    return _logic.display;
  }

  void input(String value) {
    _logic.input(value);
    state = _logic.display;
  }
}

final calculatorProvider =
    NotifierProvider<CalculatorNotifier, String>(
  CalculatorNotifier.new,
);
