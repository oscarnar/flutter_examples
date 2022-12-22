import 'package:contact_info/domain/entities/person.dart';

abstract class ContactsRepository {
  Future<List<Person>> getContacts();

  Future<void> addContact(Person person);

  Future<void> deleteContact(Person person);

  Future<void> updateContact(Person person);
}
