import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DataBaseHelper{
  static final _dbNane="mytask.db";
  static final _dbversion=1;
  static final _tableName="tasks";
  static final _columnId="_id";
  static final columnname="name";
  static final columnCategory="category";
  static final columnPriorities="priority";

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance =DataBaseHelper._privateConstructor();
  static Database ? _database;

  Future<Database?> get dataBase async {
    if(_database != null)
      return _database;

      _database ??=await _initDataBase();
    return _database;
    }
    _initDataBase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path=join(directory.path,_dbNane);
    return await openDatabase(path,version: _dbversion,onCreate:_onCreate );

  }
  Future _onCreate(Database db,int version){
    return db.execute(
      '''
      CREATE TABLE $_tableName($_columnId INTEGER PRIMARY KEY,
      $columnname TEXT NOT NULL,$columnCategory TEXT NOT NULL,$columnPriorities TEXT NOT NULL)
      '''
    );
  }
  Future<int> insert(Map<String,dynamic> row) async{
    Database? db = await instance.dataBase;
    return await db!.insert(_tableName,row);

  }

  Future<List<Map<String,dynamic>>> queryAll() async{
    Database ? db=await instance.dataBase;
    return await db!.query(_tableName);


  }

  Future<int> upddate(Map<String,dynamic> row) async{
    Database ? db=await instance.dataBase;
    int id=row[_columnId];
    return await
         db !.update(_tableName, row,where: '$_columnId=?',whereArgs: [id]);
  }

  Future<int> delete(int id) async{
    Database ? db=await instance.dataBase;
    return await db !.delete(_tableName,where:'$_columnId=?',whereArgs: [id]);
  }

  Future<List> getAllRecords(String dbTable) async{
    Database ? db=await instance.dataBase;
    var result=await db !.rawQuery("SELECT * FROM $_tableName");
    return result.toList();
  }



}