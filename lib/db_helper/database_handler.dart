
import 'package:flutter_bonik_demo/models/post_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String DATABASE_NAME = "bonik.db";
  String TABLE_NAME_POST = "table_post";

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, DATABASE_NAME),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE $TABLE_NAME_POST(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT NOT NULL, days TEXT NOT NULL, cat TEXT NOT NULL, gen TEXT NOT NULL, "
          "qty INTEGER, price INTEGER, moq INTEGER, scolor REAL, ecolor REAL, "
          "size TEXT NOT NULL, photo TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertPost(PostModel post) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert(TABLE_NAME_POST, post.toMap());
    return result;
  }

  Future<List<PostModel>> getAllPost() async {
    final  Database db = await initializeDB();
    var res = await db.query(TABLE_NAME_POST);
    List<PostModel> list = res.isNotEmpty ? res.map((c) => PostModel.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<PostModel>> getPostById(int id) async {
    final Database db = await initializeDB();
    var res = await db.query(TABLE_NAME_POST, where: "id = ?", whereArgs: [id]);
    List<PostModel> list = res.isNotEmpty ? res.map((c) => PostModel.fromMap(c)).toList() : [];
    return list;
  }
}