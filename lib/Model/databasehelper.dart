import 'package:alhidaya/Model/Student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  static const _databaseName = "data1.db";
  static const _databaseVersion = 1;
  static const table = 'student';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnClassName = 'classname';
  static const columnAddress = 'address';
  static const columnWork = 'work';
  static const columnProfile = 'profile';
  static const columnNotes = 'notes';
  static const columnPoints = 'points';
  static const columnPhone = 'phone';
  static const columnRingNum = 'ringnum';

  late Database db;
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnWork TEXT NOT NULL,
            $columnClassName INTEGER NOT NULL,
            $columnPhone INTEGER NOT NULL,
            $columnRingNum INTEGER NOT NULL,
            $columnPoints INTEGER NOT NULL,
            $columnNotes TEXT,
            $columnProfile TEXT
          )
          ''');
  }

  Future<int> insert(Student student) async {
    return await db.insert(table, student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Student?>> getAllStudents() async {
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (index) {
      return Student(
          id: maps[index]['id'],
          profile: maps[index]['profile'],
          name: maps[index]['name'],
          classname: maps[index]['classname'],
          address: maps[index]['address'],
          work: maps[index]['work'],
          phone: maps[index]['phone'],
          ringnum: maps[index]['ringnum'],
          points: maps[index]['points'],
          notes: maps[index]['notes']);
    });
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
