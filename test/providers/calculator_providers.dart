import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/calculator_provider.dart';

void main() {
  test('CalculatorProvider menghitung 10 + 5 = 15', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier =
        container.read(calculatorProvider.notifier);

    notifier.input('1');
    notifier.input('0');
    notifier.input('+');
    notifier.input('5');
    notifier.input('=');

    final result = container.read(calculatorProvider);

    expect(result, '15');
  });
}
