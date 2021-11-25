import 'package:extinct_animals/models/person_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String tablePersons = 'persons';

class NotesDatabase {
  static Database? _database;
  int ver = 3;
  String p = "";
  String get pa {
    return p;
  }

  NotesDatabase.init();
  static NotesDatabase instance = NotesDatabase.init();

  Future<Database> database(int vers) async {
    // if (_database != null) return _database!;

    _database = await _initDB('persons1.db', vers);
    int tempVer = await _database!.getVersion();
    print("in database " + tempVer.toString());
    return _database!;
  }

  void updateVersion(int version) async {
    ver = version;
    _database = await _initDB('persons1.db', version);
  }

  Future<Database> _initDB(String filePath, int ver) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("path " + path);
    setPa(pa) => pa = path;
    print("version " + ver.toString());

    return await openDatabase(path, version: ver, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    tablePersons = "persons" + version.toString();
    print("Version no " + version.toString());

    await db.execute('''
  CREATE TABLE $tablePersons ( 
  ${PersonFields.id} $idType,
  ${PersonFields.firstName} $textType,
  ${PersonFields.lastName} $textType,
  ${PersonFields.phoneNo} $textType,
  ${PersonFields.mailId} $textType,
  ${PersonFields.fav} $textType

  )
''');
    print("table person2 created");
// await db.execute('''
// CREATE TABLE persons2 (
//   ${PersonFields.id} $idType,
//   ${PersonFields.firstName} $textType,
//   ${PersonFields.lastName} $textType,
//   ${PersonFields.phoneNo} $textType,
//   ${PersonFields.mailId} $textType

//   )
// ''');
// await db.execute('''
// CREATE TABLE persons3 (
//   ${PersonFields.id} $idType,
//   ${PersonFields.firstName} $textType,
//   ${PersonFields.lastName} $textType,
//   ${PersonFields.phoneNo} $textType,
//   ${PersonFields.mailId} $textType

//   )
// ''');
  }

  Future<Person> createPerson(Person person, int vers) async {
    final db = await instance.database(vers);
    tablePersons = "persons" + vers.toString();
    final id = await db.insert(tablePersons, person.toJson());

    return person.copy(id: id + 1);
  }

  Future<Person> getPerson(int id, int vers) async {
    final db = await instance.database(vers);
    tablePersons = "persons" + vers.toString();
    final maps = await db.query(
      tablePersons,
      columns: PersonFields.values,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Person.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> getVersionNo(int ve) async {
    final db = await instance.database(ve);
    int v = await db.getVersion();
    return v;
  }

  Future<List<Person>> getAllPersons(int vers) async {
    final db = await instance.database(vers);
    int v = await db.getVersion();
    print("version from getV " + v.toString());

    // final orderBy = '${PersonFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');
    tablePersons = "persons" + vers.toString();
    final result = await db.query(
      tablePersons,
    );

    return result.map((json) => Person.fromJson(json)).toList();
  }

  Future<int> update(Person note, int vers) async {
    final db = await instance.database(vers);
    tablePersons = "persons" + vers.toString();
    return db.update(
      tablePersons,
      note.toJson(),
      where: '${PersonFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id, int vers) async {
    final db = await instance.database(vers);
    tablePersons = "persons" + vers.toString();
    return await db.delete(
      tablePersons,
      where: '${PersonFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close(int vers) async {
    final db = await instance.database(vers);

    db.close();
  }
}
