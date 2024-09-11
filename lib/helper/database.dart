import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class DataBaseHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDb() async {
    //هنحدد المسار اللي هتتخزن فيه لانها قاعدة بيانات محليه local
    //بتشغل حيز من ذاكرة الجهاز يعني لما نحذف التطبيق بتتحذف هى كمان
    //getDatabasesPath() المثود دي بتحدد المسار الافتراضي
    String dataBasePath = await getDatabasesPath();

    String path = join(dataBasePath, 'interview4.db');
    //ال path بيدمج اسم الداتابيز مع المسار
    // dataBasePath/interview.db

    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 11,onUpgrade: _onUpGrade);
    return myDb;
  }


  _onUpGrade(Database db, int oldVersion,int newVersion)async{
    await db.execute('ALTER TABLE "notes" ADD COLUMN deadline TEXT');
    print('upgrade========================');

  }

  void _onCreate(Database db, int version) async {
    Batch batch=db.batch();
   batch.execute('''
      CREATE TABLE notes (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        deadline TEXT NOT NULL
      )
    ''');
  await batch.commit();
    print('Table created');
  }

  readData(String sql) async {
    //السطر دا بيخزن الداتا اللي عملت عليها if فوق في الداتا اللي عامل ليها open
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    //السطر دا بيخزن الداتا اللي عملت عليها if فوق في الداتا اللي عامل ليها open
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(
    String sql,
  ) async {
    //السطر دا بيخزن الداتا اللي عملت عليها if فوق في الداتا اللي عامل ليها open
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    //السطر دا بيخزن الداتا اللي عملت عليها if فوق في الداتا اللي عامل ليها open
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
  myDeleteDatabase()async{
    String dataBasePath = await getDatabasesPath();

    String path = join(dataBasePath, 'interview1.db');
    deleteDatabase(path);
  }
}

