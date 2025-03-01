import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const CalculatorHomeScreen(),
    );
  }
}

class CalculatorHomeScreen extends StatefulWidget {
  const CalculatorHomeScreen({super.key});

  @override
  State<CalculatorHomeScreen> createState() => _CalculatorHomeScreenState();
}

class _CalculatorHomeScreenState extends State<CalculatorHomeScreen> {
  var _inputExpression = '';
  var _result = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                _inputExpression,
                style: TextStyle(color: Colors.grey, fontSize: 48),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(_result, style: TextStyle(fontSize: 48)),
            ),
            Flexible(
              flex: 4,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 16 / 9,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children:
                    CalculatorKey.keypad
                        .map(
                          (key) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: key.buildButton(_getOnPressed(key)),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback _getOnPressed(CalculatorKey key) {
    return () {
      setState(() {
        switch (key) {
          case CalculatorKey.reset:
            _inputExpression = '';
            _result = '0';
            break;
          case CalculatorKey.equals:
            _result = _parse(_inputExpression);
            _inputExpression = '';
            break;
          default:
            _inputExpression += key.toString();
        }
      });
    };
  }

  String _parse(String input) {
    final parser = GrammarParser();
    final expression = parser.parse(input);
    final contextModel = ContextModel();
    final result = expression.evaluate(EvaluationType.REAL, contextModel);

    return result.toString();
  }
}

enum CalculatorKey {
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  add,
  subtract,
  multiply,
  divide,
  percent,
  equals,
  reset,
  decimal,
  leftParenthesis,
  rightParenthesis;

  static List<CalculatorKey> get keypad => [
    CalculatorKey.reset,
    CalculatorKey.leftParenthesis,
    CalculatorKey.rightParenthesis,
    CalculatorKey.percent,
    CalculatorKey.seven,
    CalculatorKey.eight,
    CalculatorKey.nine,
    CalculatorKey.divide,
    CalculatorKey.four,
    CalculatorKey.five,
    CalculatorKey.six,
    CalculatorKey.multiply,
    CalculatorKey.one,
    CalculatorKey.two,
    CalculatorKey.three,
    CalculatorKey.subtract,
    CalculatorKey.zero,
    CalculatorKey.decimal,
    CalculatorKey.equals,
    CalculatorKey.add,
  ];

  Color? get color => switch (this) {
    CalculatorKey.zero ||
    CalculatorKey.one ||
    CalculatorKey.two ||
    CalculatorKey.three ||
    CalculatorKey.four ||
    CalculatorKey.five ||
    CalculatorKey.six ||
    CalculatorKey.seven ||
    CalculatorKey.eight ||
    CalculatorKey.nine ||
    CalculatorKey.decimal ||
    CalculatorKey.equals => Colors.white,
    _ => Colors.orange,
  };

  @override
  String toString() => switch (this) {
    CalculatorKey.zero => '0',
    CalculatorKey.one => '1',
    CalculatorKey.two => '2',
    CalculatorKey.three => '3',
    CalculatorKey.four => '4',
    CalculatorKey.five => '5',
    CalculatorKey.six => '6',
    CalculatorKey.seven => '7',
    CalculatorKey.eight => '8',
    CalculatorKey.nine => '9',
    CalculatorKey.add => '+',
    CalculatorKey.subtract => '-',
    CalculatorKey.multiply => '*',
    CalculatorKey.divide => '/',
    CalculatorKey.percent => '%',
    CalculatorKey.equals => '=',
    CalculatorKey.reset => 'AC',
    CalculatorKey.decimal => '.',
    CalculatorKey.leftParenthesis => '(',
    CalculatorKey.rightParenthesis => ')',
  };

  Widget buildButton(VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          this == CalculatorKey.equals ? Colors.orange[500] : Colors.grey[800],
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      child: Text(toString(), style: TextStyle(color: color, fontSize: 24)),
    );
  }
}
