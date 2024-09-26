import 'package:oct_exercise_l1/data/db/db_helper.dart';
import 'package:oct_exercise_l1/data/model/Task.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  DbHelper dbHelper = DbHelper();

  Future<void> insertData(Task task) async {
    final db = await dbHelper.initDb(); //Khởi tạo db

    await db.insert('tasks', task.toMap(),  
        conflictAlgorithm:
            ConflictAlgorithm.replace); //replace if conflict data
  }

  Future<void> deleteData(int id) async {
    final db = await dbHelper.initDb();

    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateData(Task task) async {
    final db = await dbHelper.initDb();

    await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List<Task>> getAllListData() async {
    final db = await dbHelper.initDb();

    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        content: maps[i]['content'],
        time: maps[i]['time'],
        status: maps[i]['status'],
      );
    });
  }
}
