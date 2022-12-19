import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Todo.dart';

class DatabaseProvider {
  Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializedatabase();
    }
    return _database;
  }

  Future<Database> initializedatabase() async {
    String databasePath = join(await getDatabasesPath(), "etrade.database");
    var eTradedatabase = await openDatabase(databasePath, version: 1, onCreate: createdatabase);
    return eTradedatabase;
  }

  Future<void> createdatabase(Database database, int version) async {
    await database.execute(
        "Create table Todos(id integer primary key, title text, body text)");
  }

  Future<List> getTodos() async {
    Database? database = await this.database;
    var result = await database!.query("Todos");
    //return result;
    return List.generate(result.length, (i) {
      return Todo.fromObject(result[i]);
    });
  }

  Future<int?> insert(Todo todo) async {
    Database? database = await this.database;
    var result = await database?.insert("Todos", todo.toMap());
    return result;
  }

  Future<int?> delete(int id) async {
    Database? database = await this.database;
    var result = await database?.rawDelete("delete from Todos where id= $id");
    return result;
  }

  Future<int?> update(Todo todo) async {
    Database? database = await this.database;
    var result = await database?.update("Todos", todo.toMap(),
        where: "id=?", whereArgs: [todo.id]);
    return result;
  }
}