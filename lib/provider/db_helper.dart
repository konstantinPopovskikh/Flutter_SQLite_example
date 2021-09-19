import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_database/model/todo_model.dart';

Future<Database> todoDatabase() async {
  return openDatabase(join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
    return db.execute('''
    CREATE TABLE IF NOT EXISTS todo (
      id INTEGER PRIMARY KEY,
      todo TEXT
      );''');
  }, version: 1);
}

// add entry
Future<TodoModel> addTodo({required TodoModel todo}) async {
  final db = await todoDatabase();

  db.insert('todo', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  return todo;
}

// update entry
Future<TodoModel> updateTodo(
    {required List id, required TodoModel todo}) async {
  final db = await todoDatabase();

  db.update('todo', todo.toMap(), where: 'id = ?', whereArgs: id);

  return todo;
}

//deleting entry
Future deleteTodo({required List id}) async {
  final db = await todoDatabase();

  db.delete('todo', where: 'id = ?', whereArgs: id);

  return id;
}

//read data
Future<List<Map>> readTodo() async {
  final db = await todoDatabase();

  return db.query('todo');
}
