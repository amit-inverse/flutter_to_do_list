import 'package:flutter/material.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: toDoItems.length,
        itemBuilder: (context, index) {
          final toDoItem = toDoItems[index];
          return Dismissible(
            key: ValueKey(toDoItem),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              // Remove the item from the data source.
              toDoItems.removeAt(index);
            },
            child: CheckboxListTile(
              title: Text(toDoItem),
              value: false,
              onChanged: (value) {
                // Update the item's state.
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

final toDoItems = [
  'Buy groceries',
  'Do laundry',
  'Finish homework',
  'Take out the trash',
];
