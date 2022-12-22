import 'package:contact_info/domain/entities/person.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableContacts = 'contacts';

class Contact {
  static final List<String> values = [
    id,
    name,
    username,
    email,
    website,
    phone,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String username = 'username';
  static const String email = 'email';
  static const String website = 'website';
  static const String phone = 'phone';
}

class ContactsDatabase {
  ContactsDatabase._init();

  static final ContactsDatabase instance = ContactsDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    // const boolType = 'BOOLEAN NOT NULL';
    // const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableContacts ( 
  ${Contact.id} $idType, 
  ${Contact.name} $textType,
  ${Contact.username} $textType,
  ${Contact.website} $textType,
  ${Contact.phone} $textType,
  ${Contact.email} $textType
  )
''');
  }

  Future<Person> create(Person person) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]},
    // ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableContacts, person.toJson());
    return person.copyWith(id: id);
  }

  Future<Person> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableContacts,
      columns: Contact.values,
      where: '${Contact.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Person.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Person>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${Contact.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableContacts, orderBy: orderBy);

    return result.map(Person.fromJson).toList();
  }

  Future<int> update(Person person) async {
    final db = await instance.database;

    return db.update(
      tableContacts,
      person.toJson(),
      where: '${Contact.id} = ?',
      whereArgs: [person.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableContacts,
      where: '${Contact.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;

    await db.close();
  }
}
