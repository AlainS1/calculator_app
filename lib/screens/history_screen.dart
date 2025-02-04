// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import '../services/history_service.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    List<String> history = await HistoryService.getHistory();
    setState(() {
      _history = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculation History'),
      ),
      body: ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          final parts = _history[index].split('\n');
          final calculation = parts[0];
          final date = parts.length > 1 ? parts[1] : '';
          return ListTile(
            title: Text(calculation, style: TextStyle(fontSize: 18)),
            subtitle: Text(date, style: TextStyle(color: Colors.grey)),
          );
        },
      ),
    );
  }
}
