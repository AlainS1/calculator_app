// lib/screens/converter_screen.dart
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double _result = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void _convert() {
    setState(() {
      double? kilometers = double.tryParse(_controller.text);
      if (kilometers != null) {
        _result = kilometers * 0.621371;
      } else {
        _result = 0.0;
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kilometers to Miles Converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: "Enter kilometers",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: _convert,

              child: Text("Convert to miles"),
            ),
            SizedBox(height: 21),
            Text(
              "Resolution: ${_result.toStringAsFixed(3)} miles",
              style: TextStyle(fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
