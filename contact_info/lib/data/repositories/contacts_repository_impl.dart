import 'package:contact_info/data/services/contacts_service.dart';
import 'package:contact_info/domain/entities/person.dart';
import 'package:contact_info/domain/repositories/contacts_repository.dart';
// import 'package:sqflite/sqflite.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl({
    required this.service,
    // required this.db,
  });

  final ContactsService service;
  // final Database db;

  final List<Person> _contacts = [];

  int get contactsCount => _contacts.length;

  @override
  Future<List<Person>> getContacts() async {
    if (_contacts.isNotEmpty) {
      return _contacts;
    }
    final data = await service.fetchData();
    final contacts = <Person>[];
    for (final element in data) {
      contacts.add(Person.fromJson(element as Map<String, dynamic>));
    }
    _contacts.addAll(contacts);
    return contacts;
  }

  @override
  Future<void> addContact(Person person) async {
    // return service.addContact(person);
    _contacts.add(person);
  }

  @override
  Future<void> deleteContact(Person person) async {
    // return service.deleteContact(person);
  }

  @override
  Future<void> updateContact(Person person) async {
    // return service.updateContact(person);
  }
}
