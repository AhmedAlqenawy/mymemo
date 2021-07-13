  import 'package:mymemo/model/memo-model.dart';
import 'package:mymemo/model/person-model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class Memos_service_database{
  String table = 'Memos';
  String table2 = 'Person';
  static Database _db;
  Future<Database> get db async{
    if(_db == null){
      _db = await initialDB();
      return _db;
    }else{
      return _db;
    }
  }

  initialDB() async{
    io.Directory docDirect = await getApplicationDocumentsDirectory();
    String path = join(docDirect.path,'Memodb.db');
    var mydb = await openDatabase(path,version: 1,onCreate: (Database db,int version) async{
      await db.execute('CREATE TABLE "$table" ("titel" Text UNIQUE PRIMARY KEY NOT NULL,"discription" Text , "type" Text , "pirsonName" Text,"memoDate" Text )');
      await db.execute('CREATE TABLE "$table2" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" Text NOT NULL,"memoNum" INTEGER , "birthDate" Date , "notify" INTEGER)');
    });
    return mydb;
  }

  //add || insert
  Future<bool> add(Memo object) async {
   // print(object.toMap());
    Database db1 = await this.db;
    List ret=await db1.rawQuery('SELECT * FROM Memos where titel = "${object.titel}" ');
    if(ret.length>0)
      return false;
    else
    {
       await db1.insert('Memos', object.toMap());
      return true;
    }
  }
  Future<bool> addPerson(Person object) async {
    //print(object.toMap());
    Database db1 = await this.db;
    List ret=await db1.rawQuery('SELECT * FROM Person where name = "${object.name}" ');
    if(ret.length>0)
      return false;
    else
    {
       await db1.insert('Person', object.toMap());
      return true;
    }
  }

  //Search
  Future<List<Memo>> find(String pirsonName)async{
    var dbclient=await db;
    List<Map> list2 = await dbclient.rawQuery('SELECT * FROM Memos where pirsonName = "$pirsonName" ');
    List<Memo> list=new List<Memo>();
    //print(list2.length);
    for(int i=0;i<list2.length;i++)
    {
      list.add(Memo.fromMap(list2[i]));
    }
    return  list;
  }
  Future<int> findPerson(String titel)async{
    var dbclient=await db;
    List<Map> list2 = await dbclient.rawQuery('SELECT * FROM Person where titel = "$titel" ');
    print(list2.length);
    return list2.length;
  }

  //getAll
  Future<List<Memo>> getMemo() async{
    var dbclient=await db;
    List<Map> list2 = await dbclient.rawQuery('SELECT * FROM Memos');
    List<Memo> list=new List<Memo>();
    for(int i=0;i<list2.length;i++)
    {
      list.add(Memo.fromMap(list2[i]));
    }
    return list;
  }
  Future<List<Person>> getPerson() async{
    var dbclient=await db;
    List<Map> list2 = await dbclient.rawQuery('SELECT * FROM Person');
    List<Person> list=new List<Person>();
    for(int i=0;i<list2.length;i++)
    {
      list.add(Person.fromMap(list2[i]));
    }
    return list;
  }

  //Update iteam
  void update(Memo object,{String title="no"})async{
    if(title=="no")
      title=object.titel;
    Database db1 = await this.db;
    await db1.update('Memos', object.toMap(), where: 'titel=?', whereArgs: [title]);
  }

  Future<int> updatePerson(Person object,{String name="no"}) async {
    if(name=="no")
      name=object.name;
    Database db1 = await this.db;
    await db1.update('Person', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
  }

  //Delete
  deletePersonMemo(pirsonName)async{
    var dbclient=await db;
    await dbclient.rawQuery('DELETE from Memos where pirsonName = "$pirsonName"');
  }
  deleteMemo(memoTitle)async{
    var dbclient=await db;
    await dbclient.rawQuery('DELETE from Memos where titel = "$memoTitle"');
  }

  DeletePerson(titel)async{
    var dbclient=await db;
    await dbclient.rawQuery('DELETE from Person where name = "$titel"');
  }


}