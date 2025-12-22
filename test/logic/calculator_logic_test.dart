import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/logic/calculator_logic.dart';


void main() {
  group('CalculatorLogic Test', () {
    test('Penjumlahan 1.000.000 + 200.000', () {
      final logic = CalculatorLogic();

      logic.input('1');
      logic.input('0');
      logic.input('0');
      logic.input('0');
      logic.input('0');
      logic.input('0');
      logic.input('0');

      logic.input('+');

      logic.input('2');
      logic.input('0');
      logic.input('0');
      logic.input('0');
      logic.input('0');
      logic.input('0');

      logic.input('=');

      expect(logic.display, '1.200.000');
    });

    test('Backspace bekerja dengan benar', () {
      final logic = CalculatorLogic();

      logic.input('1');
      logic.input('2');
      logic.input('3');
      logic.input('⌫');

      expect(logic.display, '12');
    });

    test('Decimal tidak boleh double', () {
      final logic = CalculatorLogic();

      logic.input('1');
      logic.input('.');
      logic.input('.');
      logic.input('5');

      expect(logic.display, '1,5');
    });
  });
}
