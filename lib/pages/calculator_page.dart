import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/calculator_provider.dart';

class CalculatorPage extends ConsumerWidget {
  const CalculatorPage({super.key});

  Widget buildButton(
    WidgetRef ref,
    String text, {
    Color color = Colors.grey,
    Color textColor = Colors.white,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () {
            ref.read(calculatorProvider.notifier).input(text);
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final display = ref.watch(calculatorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          // DISPLAY
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              display,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Divider(),

          Row(
            children: [
              buildButton(ref, 'C', color: Colors.red),
              buildButton(ref, '⌫', color: Colors.blueGrey),
              buildButton(ref, '%', color: Colors.blueGrey),
              buildButton(ref, '÷', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton(ref, '7'),
              buildButton(ref, '8'),
              buildButton(ref, '9'),
              buildButton(ref, '×', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton(ref, '4'),
              buildButton(ref, '5'),
              buildButton(ref, '6'),
              buildButton(ref, '-', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton(ref, '1'),
              buildButton(ref, '2'),
              buildButton(ref, '3'),
              buildButton(ref, '+', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              buildButton(ref, '0'),
              buildButton(ref, '.'),
              buildButton(ref, '=', color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}
