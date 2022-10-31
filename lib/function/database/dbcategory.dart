import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../../models/categoryModel/categoryModel.dart';

class DBCategory {
  static Database ? _db;
  Future<Database?> get db async{
    if (_db !=null){
      return _db;
    }
    _db = await initDatabase();
  }
  initDatabase() async {
    io.Directory documnetDirectory = await  getApplicationDocumentsDirectory();
    String path = join(documnetDirectory.path,'category.db');
    var db = await openDatabase(path,version:1,onCreate: _onCreate,) ;
    return db;
  }

  _onCreate(Database db , int version)async{
    await db
        .execute('CREATE TABLE tabcategory (id INTEGER NOT NULL PRIMARY KEY , NameArabic VARCHAR, NameEnglish VARCHAR,Image TEXT)');
    await db
        .execute('CREATE TABLE tabItem (id INTEGER NOT NULL PRIMARY KEY ,parent INTEGER, NameArabic VARCHAR, NameEnglish VARCHAR,Image TEXT)');
    await db
        .execute('CREATE TABLE tabItemSize (id INTEGER NOT NULL PRIMARY KEY ,parent INTEGER, NameArabic VARCHAR, NameEnglish VARCHAR , price DOUBLE)');
  }

  Future<Category>insert(Category category)async{
    var dbClient = await db;
    await dbClient!.insert('tabcategory', category.toMap());
    return category;
  }

  Future<List<Category>>getCartList()async{
    var dbClient = await db;
    final List<Map<String,Object?>> queryResult= await dbClient!.query('tabcategory');
    return queryResult.map((e) => Category.fromMap(e)).toList();
  }
}
