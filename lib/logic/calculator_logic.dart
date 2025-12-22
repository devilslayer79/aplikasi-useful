import 'package:intl/intl.dart';

class CalculatorLogic {
  String _rawDisplay = '0';
  double _firstNumber = 0;
  String _operator = '';
  bool _shouldClear = false;

  final NumberFormat _formatter =
      NumberFormat('#,##0.########', 'id_ID');

  String get display => _formatter.format(double.parse(_rawDisplay));

  void input(String value) {
    // CLEAR
    if (value == 'C') {
      _rawDisplay = '0';
      _firstNumber = 0;
      _operator = '';
      _shouldClear = false;
      return;
    }

    // BACKSPACE
    if (value == '⌫') {
      if (_rawDisplay.length > 1) {
        _rawDisplay = _rawDisplay.substring(0, _rawDisplay.length - 1);
      } else {
        _rawDisplay = '0';
      }
      return;
    }

    // DECIMAL
    if (value == '.') {
      if (!_rawDisplay.contains('.')) {
        _rawDisplay += '.';
      }
      return;
    }

    // OPERATOR
    if (['+', '-', '×', '÷'].contains(value)) {
      _firstNumber = double.parse(_rawDisplay);
      _operator = value;
      _shouldClear = true;
      return;
    }

    // PERCENT
    if (value == '%') {
      double current = double.parse(_rawDisplay);
      current = _operator.isNotEmpty
          ? _firstNumber * current / 100
          : current / 100;
      _rawDisplay = current.toString();
      _shouldClear = true;
      return;
    }

    // EQUALS
    if (value == '=') {
      double secondNumber = double.parse(_rawDisplay);
      double result = 0;

      switch (_operator) {
        case '+':
          result = _firstNumber + secondNumber;
          break;
        case '-':
          result = _firstNumber - secondNumber;
          break;
        case '×':
          result = _firstNumber * secondNumber;
          break;
        case '÷':
          result = secondNumber == 0 ? 0 : _firstNumber / secondNumber;
          break;
      }

      _rawDisplay = result.toString();
      _operator = '';
      _shouldClear = true;
      return;
    }

    // NUMBER INPUT
    if (_shouldClear) {
      _rawDisplay = value;
      _shouldClear = false;
    } else {
      _rawDisplay = _rawDisplay == '0' ? value : _rawDisplay + value;
    }
  }
}
