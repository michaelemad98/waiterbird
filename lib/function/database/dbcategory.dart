import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:waiterbird/models/categoryModel/itemModel.dart';
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
        .execute('CREATE TABLE tabcategory (id INTEGER NOT NULL PRIMARY KEY , NameArabic VARCHAR, NameEnglish VARCHAR,Image VARCHAR)');
    await db
        .execute('CREATE TABLE tabItem (id INTEGER NOT NULL PRIMARY KEY ,parent INTEGER, NameArabic VARCHAR, NameEnglish VARCHAR,Image VARCHAR,SizeID INTEGER,SizeNameArabic VARCHAR,SizeNameEnglish VARCHAR,SizePrice DOUBLE)');
    await db
        .execute('CREATE TABLE tabItemSize (id INTEGER NOT NULL PRIMARY KEY ,parent INTEGER, NameArabic VARCHAR, NameEnglish VARCHAR , price DOUBLE)');
  }

  Future<Categorym>insert(Categorym category)async{
    var dbClient = await db;
    await dbClient!.insert('tabcategory', category.toMap());
    return category;
  }

  Future<List<Categorym>>getCategoryList()async{
    var dbClient = await db;
    final List<Map<String,Object?>> queryResult= await dbClient!.query('tabcategory');
    return queryResult.map((e) => Categorym.fromMap(e)).toList();
  }
  Future<Item>insertItem(Item item)async{
    var dbClient = await db;
    await dbClient!.insert('tabItem', item.toMap());
    return item;
  }
  Future<List<Item>>getItemList()async{
    var dbClient= await db;
    final List<Map<String,Object?>> queryResult = await dbClient!.query('tabItem');
    return queryResult.map((e) => Item.fromMap(e)).toList();
  }
}
