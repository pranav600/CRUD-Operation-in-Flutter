import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  // intidata base

  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'datab.db');
    return await openDatabase(databasePath);
  }

// copy function

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "datab.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
          await rootBundle.load(join('assets/database', 'datab.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String, Object?>>> getDataFromStudent() async {
    Database db = await initDatabase();
    var data = await db.rawQuery("select * from student");
    return data;
  }

  Future<int> deleteStudent(int id) async {
    Database db = await initDatabase();
    var data = db.delete("student", where: "studentID=?", whereArgs: [id]);
    return data;
  }

  Future<int> insertStudent({name, cpi}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = {};
    map['name'] = name;
    // map['clg'] = clg;
    map['cpi'] = cpi;
    var data = db.insert("student", map);
    return data;
  }

  Future<int> updateStudent({name, cpi, id}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = {};
    map['name'] = name;
    // map['clg'] = clg;
    map['cpi'] = cpi;
    var data = db.update("student", map, where: "studentID=?", whereArgs: [id]);
    return data;
  }
}
