// lib/controllers/calculator_controller.dart
import '../services/history_service.dart';

class CalculatorController {
  String displayText = '0';
  String firstOperand = '';
  String secondOperand = '';
  String operator = '';

  Future<void> saveToHistory(String calculation) async {
    await HistoryService.addCalculation(calculation);
  }

  void onButtonPressed(String value, Function(String) updateHistoryCallback) {
    if (value == 'C') {
      displayText = '0';
      firstOperand = '';
      secondOperand = '';
      operator = '';
    } else if (value == '+' || value == '-' || value == '*' || value == '/') {
      operator = value;
    } else if (value == '=') {
      if (firstOperand.isNotEmpty &&
          operator.isNotEmpty &&
          secondOperand.isNotEmpty) {
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
        String calculation =
            "$firstOperand $operator $secondOperand = $displayText\n${DateTime.now()}";
        updateHistoryCallback(calculation);
        saveToHistory(calculation);
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
