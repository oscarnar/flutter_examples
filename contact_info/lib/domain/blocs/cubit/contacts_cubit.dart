import 'package:bloc/bloc.dart';
import 'package:contact_info/data/repositories/contacts_repository_impl.dart';
import 'package:contact_info/data/services/contacts_service.dart';
import 'package:contact_info/data/services/geolocator_service.dart';
import 'package:contact_info/domain/entities/person.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(const ContactsInitial());

  Future<void> init() async {
    emit(const ContactsLoading());
    _repository = ContactsRepositoryImpl(
      service: ContactsService(),
      // db: ,
    );
    try {
      final contacts = await _repository.getContacts();
      emit(ContactsLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactsError(e.toString()));
    }
  }

  Future<void> addContact(Person person) async {
    try {
      final location = await GeoService.determineCoordinates();
      final newContact = person.copyWith(
        id: _repository.contactsCount + 1,
        address: person.address.copyWith(coordinates: location),
      );
      await _repository.addContact(newContact);
      final contacts = await _repository.getContacts();
      emit(ContactsLoaded(contacts: contacts));
    } catch (e) {
      emit(ContactsError(e.toString()));
    }
  }

  late ContactsRepositoryImpl _repository;
}
