// lib/services/history_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class HistoryService {
  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('history') ?? [];
  }

  static Future<void> addCalculation(String calculation) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('history') ?? [];
    history.add(calculation);
    await prefs.setStringList('history', history);
  }
}
