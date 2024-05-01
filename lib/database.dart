import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class myclass{
      Future<Database> databd() async {
      // Get a location using getDatabasesPath
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');

        Database database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
              await db.execute('CREATE TABLE vrushabh (id INTEGER PRIMARY KEY, name TEXT, email text, number text,password text)');
              await db.execute('CREATE TABLE contact (id INTEGER PRIMARY KEY, name TEXT, number text,userid integer)');
              // print('======path==========${path}');
        });

      return database;
}
      Future<bool> insertdb(String Name,String Email,String Number,String Pass,Database database) async {
        String list="select * from vrushabh where email='$Email' or name='$Name' or number='$Number' or password='$Pass' ";
        List<Map> map=await  database.rawQuery(list);
        if(map.isEmpty) {
          String insertdata = "insert into vrushabh(name,email,number,password) values('$Name','$Email','$Number','$Pass')";
          int ans = await database.rawInsert(insertdata);
          return true;
        }
        else
        {
          return false;
        }
      }

      Future<List<Map>> showdb(Database database) async {
        String list ="SELECT * FROM vrushabh";
        List<Map> listdata= await database.rawQuery(list);
     return listdata;
      }

      Future deletedata(Database database,int a) async {
        String list ="DELETE FROM vrushabh WHERE id = $a";
     int del= await database.rawDelete(list);
      }

      Future deleteall(Database database) async {
        String list ="DELETE FROM vrushabh ";
     int del= await database.rawDelete(list);
      }

  Future<void> updatedata(String upname, String upemail, String upnumber, Database database,int uid) async {
        String list1="update vrushabh set name= '$upname',email= '$upemail',number= '$upnumber' where id='$uid'";
        int updated=await database.rawDelete(list1);
  }

  Future<List<Map>> login(String uemail, String upss, Database database) async {
        String list="select * from vrushabh where email='$uemail' or number='$uemail' and password='$upss'";
     List<Map> map=await  database.rawQuery(list);
     return map;
  }

      Future<void> insertConatct(
          String name, String num, int userid, Database database) async {
        String insertconatc =
            "insert into contact (name,number,userid)  values('$name','$num','$userid')";

        int aa = await database.rawInsert(insertconatc);

        print("==$aa");
      }

      Future<List<Map>> viewConatct(int i, Database database) async {

        String selctconatc = "select * from contact where userid ='$i'";

        List<Map>  list  = await  database.rawQuery(selctconatc);
        return list;
      }

  ucontact(String name,String number, Database database, uid) async {
    String list1="update contact set name= '$name',number= '$number' where id='$uid'";
    int updated=await database.rawDelete(list1);
  }

      Future deletecontact(Database database,int a) async {
        String list ="DELETE FROM contact WHERE id = $a";
        int del= await database.rawDelete(list);
      }
}