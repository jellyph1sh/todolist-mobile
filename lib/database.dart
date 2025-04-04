import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/models/todo_model.dart';

class DatabaseHelper {
  final String _dbName = 'todoApp.db';
  final int _dbVersion = 1;
  final String _tableName = 'todos';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos (
      id INTEGER PRIMARY KEY,
      task TEXT NOT NULL,
      isCompleted INTEGER NOT NULL
    )
    ''');
  }

  // Insérer une tâche
  Future<int> insert(Todo todo) async {
    Database db = await instance.database;
    return await db.insert(_tableName, todo.toJson());
  }

  // Récupérer toutes les tâches
  Future<List<Todo>> getAllTodos() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> todos = await db.query(_tableName);
    return todos.map((e) => Todo.fromJson(e)).toList();
  }

  // Mettre à jour une tâche
  Future<int> update(Todo todo) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Supprimer une tâche
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
