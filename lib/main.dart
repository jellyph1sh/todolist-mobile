import 'package:flutter/material.dart';
import 'package:todo_list/add_task.dart';
import 'package:todo_list/database.dart';
import 'package:todo_list/models/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await DatabaseHelper.instance.getAllTodos();
    setState(() {
      todoList = todos;
    });
  }

  Future<void> _addTodo(String task) async {
    final newTodo = Todo(task: task, isCompleted: false);
    await DatabaseHelper.instance.insert(newTodo);
    _loadTodos();
  }

  Future<void> _updateTodo(Todo todo) async {
    await DatabaseHelper.instance.update(todo);
    _loadTodos();
  }

  Future<void> _deleteTodo(int id) async {
    await DatabaseHelper.instance.delete(id);
    _loadTodos();
  }

  void _editTask(BuildContext context, Todo todo) {
    final TextEditingController _editController =
        TextEditingController(text: todo.task);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifier la tâche'),
          content: TextField(
            controller: _editController,
            decoration: InputDecoration(
              labelText: 'Nom de la tâche',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTask = _editController.text;
                final updatedTodo = todo.copyWith(task: updatedTask);
                _updateTodo(updatedTodo);
                Navigator.pop(context);
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma ToDo List (${todoList.length})'),
      ),
      body: todoList.isEmpty
          ? Center(
              child: Text(
                'Aucune tâche',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                final todo = todoList[index];
                return ListTile(
                  title: Text(todo.task),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (bool? value) {
                      final updatedTodo = todo.copyWith(isCompleted: value!);
                      _updateTodo(updatedTodo);
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _editTask(context, todo);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteTodo(todo.id!);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          ).then((value) {
            if (value != null && value is String) {
              _addTodo(value);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
