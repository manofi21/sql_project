import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sql_images/Users.dart';
import 'package:sql_images/commant.dart';
import 'package:sql_images/photo.dart';
import 'package:sql_images/state_container.dart';

class DBHelper {
  static Database _db;
  // nama database
  static const String DB_NAME = 'database_new_photo.db';
  // id untuk semua table
  static const String ID = 'id';
  // table User
  static const String USERTABLE = 'Usertable';
  static const String IMG_PROFILE = 'img_profile';
  static const String NAME = 'username';
  static const String PASS = 'password';
  // table Image
  static const String PHOTOTABLE = 'Phototable';
  static const String ID_AUTHOR = 'id_author';
  static const String PHOTO_NAME = 'photo_name';
  static const String DES = 'description';
  // table commant
  static const String COMMANT = 'commant';
  static const String TO_ID_USER = 'to_id_user';
  static const String FROM_ID_USER = 'from_id_user';
  static const String ID_PICTURE = 'id_picture';

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    // getApplicationDocumentsDirectory()
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    // var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onOpen: _onOpens);
    return db;
  }

  _onCreate(Database db, int version) async {
    // await db.execute("CREATE TABLE $USERTABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $NAME TEXT, $PASS TEXT)");
    await db.execute(
        "CREATE TABLE $USERTABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $IMG_PROFILE TEXT, $NAME TEXT, $PASS TEXT)");
    await db.execute("CREATE TABLE $PHOTOTABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $ID_AUTHOR INTEGER, $PHOTO_NAME TEXT, $DES TEXT)");
    await db.execute(
        "CREATE TABLE $COMMANT ($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TO_ID_USER INTEGER, $FROM_ID_USER INTEGER, $ID_PICTURE INTEGER, $COMMANT TEXT)");
  }

  _onOpens(Database db) async {
    // await db.execute("DROP TABLE $USERTABLE");
    // await db.execute("DROP TABLE $PHOTOTABLE");
    // await db.execute("DROP TABLE $COMMANT");
  }

  Future<Users> adduser(Users employee) async {
    var dbClient = await db;
    employee.id = await dbClient.insert(USERTABLE, employee.toMap());
    return employee;
  }

  Future<Users> updateuser(Users users) async {
    var dbClient = await db;
    users.id = await dbClient.update(USERTABLE, users.toMap(),
        where: '$ID = ?', whereArgs: [users.id]);
    return users;
  }

  Future<Users> loadUser(int userid) async {
    var dbClient = await db;
    List<Map> count = await dbClient.query(USERTABLE,
        columns: ['$ID', '$NAME', '$PASS'],
        where: '$ID = ?',
        whereArgs: [userid]);
    if (count.length > 0) {
      return Users.fromMap(count.first);
    }
    return null;
  }

  Future<Commant> addcommant(Commant commant) async {
    var dbClient = await db;
    commant.id = await dbClient.insert(COMMANT, commant.toMap());
    return commant;
  }

  Future<List<ForWidgetCommand>> loadCommant(
      {int id_user, int id_picture}) async {
    var dbClient = await db;
    List<Map> count = await dbClient.query(COMMANT,
        columns: [
          '$ID',
          '$TO_ID_USER',
          '$FROM_ID_USER',
          '$ID_PICTURE',
          '$COMMANT'
        ],
        where: '$TO_ID_USER = ? and $ID_PICTURE = ?',
        whereArgs: [id_user, id_picture]);
    List<ForWidgetCommand> theCommants = List();
    if (count.length > 0) {
      for (int i = 0; i < count.length; i++) {
        Commant commants = Commant.fromMap(count.elementAt(i));
        print(commants.from_id_user);
        ForWidgetCommand mapsCommants = await getCommant(commants);
        theCommants.add(mapsCommants);
      }
    }
    // print(theCommants.length);
    return theCommants;
  }

  Future<ForWidgetCommand> getCommant(Commant commant) async {
    var dbClient = await db;
    List<Map> users = await dbClient.query(USERTABLE,
        columns: [IMG_PROFILE, NAME],
        where: '$ID = ?',
        whereArgs: [commant.from_id_user]);
    // print(commant.from_id_user);
    // print(users.first["$NAME"]);
    ForWidgetCommand commads = ForWidgetCommand(
        picture: users.first["$IMG_PROFILE"],
        name_user_commant: users.first["$NAME"],
        commant: commant.commant);
    // print(commads.commant);
    return commads;
  }

  Future<Users> loginUser(String username, String password) async {
    var dbClient = await db;
    List<Map> count = await dbClient.query(USERTABLE,
        columns: ['$ID', '$NAME', '$PASS'],
        where: '$NAME = ? and $PASS = ?',
        whereArgs: [username, password]);
    if (count.length > 0) {
      // kenpa di tambah first pada count ? karena count mengembalikan List<Map> dan fromMap hanya membutuhkan
      // nilai User. Tapi di setiap nilai di dalam List<Map> akan mereturn nilai User yang sama
      return Users.fromMap(count.first);
    }
    return null;
  }

  Future<Photo> save(Photo photo) async {
    var dbClient = await db;
    photo.id = await dbClient.insert(PHOTOTABLE, photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .query(PHOTOTABLE, columns: [ID, ID_AUTHOR, PHOTO_NAME, DES]);
    List<Photo> employees = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        employees.add(Photo.fromMap(maps[i]));
      }
    }
    return employees;
  }

  Future<void> liat(int i) async {
    var dbClient = await db;
    dbClient.transaction((txn) async {
      // print(employee.photo_name);
      await txn
          .rawQuery('SELECT * FROM $PHOTOTABLE where id = $i')
          .then((value) => print(Photo.fromMap(value[0]).id_author));
    });
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
