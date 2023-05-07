import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  late List<Map<String, dynamic>> _toDoItems = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await rootBundle.loadString('assets/todo_data.json');
    if (data != null) {
      final items = json.decode(data) as List<dynamic>;
      setState(() {
        _toDoItems = items.cast<Map<String, dynamic>>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _toDoItems.length,
        itemBuilder: (context, index) {
          final toDoItem = _toDoItems[index];
          return Dismissible(
            key: ValueKey(toDoItem['id']),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                _toDoItems.removeAt(index);
              });
            },
            child: CheckboxListTile(
              title: Text(toDoItem['task'] ?? ''),
              value: toDoItem['completed'] ?? false,
              onChanged: (value) {
                setState(() {
                  _toDoItems[index]['completed'] = value;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the add to-do item screen.
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
