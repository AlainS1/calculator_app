import 'package:flutter/material.dart';
import '../controllers/calculator_controller.dart';
import 'history_screen.dart';
import 'converter_screen.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorController _controller = CalculatorController();

  void updateHistory(String calculation) {
    print("Uus arvutustulemus lisatud: $calculation");
  }

  Widget buildButton(String text, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(3),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _controller.onButtonPressed(text, updateHistory);
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
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator 2025'),
        actions: [
          IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConverterScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          ),
        ],
      ),
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
