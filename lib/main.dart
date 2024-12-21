import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

// App entry point
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Controller: Handles the logic
class CalculatorController {
  String displayText = '0';
  String firstOperand = '';
  String secondOperand = '';
  String operator = '';

  void onButtonPressed(String value) {
    if (value == 'C') {
      displayText = '0';
      firstOperand = '';
      secondOperand = '';
      operator = '';
    } else if (value == '+' || value == '-' || value == '*' || value == '/') {
      operator = value;
    } else if (value == '=') {
      if (firstOperand.isNotEmpty && operator.isNotEmpty && secondOperand.isNotEmpty) {
        double num1 = double.parse(firstOperand);
        double num2 = double.parse(secondOperand);
        double result = 0;

        if (operator == '+') {
          result = num1 + num2;
        } else if (operator == '-') {
          result = num1 - num2;
        } else if (operator == '*') {
          result = num1 * num2;
        } else if (operator == '/') {
          result = num2 != 0 ? num1 / num2 : 0;
        }

        displayText = result.toString();
        firstOperand = displayText;
        secondOperand = '';
        operator = '';
      }
    } else {
      if (operator.isEmpty) {
        firstOperand += value;
        displayText = firstOperand;
      } else {
        secondOperand += value;
        displayText = secondOperand;
      }
    }
  }
}

// Main Calculator Screen
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController _controller = CalculatorController();

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _controller.onButtonPressed(text);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KmToMilesConverterScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              _controller.displayText,
              style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton('7', Colors.grey),
                    buildButton('8', Colors.grey),
                    buildButton('9', Colors.grey),
                    buildButton('/', Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4', Colors.grey),
                    buildButton('5', Colors.grey),
                    buildButton('6', Colors.grey),
                    buildButton('*', Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1', Colors.grey),
                    buildButton('2', Colors.grey),
                    buildButton('3', Colors.grey),
                    buildButton('-', Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton('C', Colors.orange),
                    buildButton('0', Colors.grey),
                    buildButton('=', Colors.lightGreen),
                    buildButton('+', Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Kilometer to Mile Converter
class KmToMilesConverterScreen extends StatefulWidget {
  @override
  _KmToMilesConverterScreenState createState() => _KmToMilesConverterScreenState();
}

class _KmToMilesConverterScreenState extends State<KmToMilesConverterScreen> {
  String input = '';
  String _result = '';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        _result = '';
      } else if (value == '=') {
        if (input.isNotEmpty) {
          final double kilometers = double.parse(input);
          final double miles = kilometers * 0.621371;
          _result = '$kilometers km = ${miles.toStringAsFixed(2)} miles';
        }
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Km to Miles Converter'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              input.isEmpty ? '0' : input,
              style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(20),
            child: Text(
              _result,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    buildButton('7', Colors.grey),
                    buildButton('8', Colors.grey),
                    buildButton('9', Colors.grey),
                  ],
                ),
                Row(
                  children: [
                    buildButton('4', Colors.grey),
                    buildButton('5', Colors.grey),
                    buildButton('6', Colors.grey),
                  ],
                ),
                Row(
                  children: [
                    buildButton('1', Colors.grey),
                    buildButton('2', Colors.grey),
                    buildButton('3', Colors.grey),
                  ],
                ),
                Row(
                  children: [
                    buildButton('C', Colors.orange),
                    buildButton('0', Colors.grey),
                    buildButton('=', Colors.lightGreen),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
