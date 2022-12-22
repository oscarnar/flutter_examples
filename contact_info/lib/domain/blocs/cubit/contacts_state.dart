part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState extends Equatable {
  const ContactsState({
    this.contacts,
  });

  final List<Person>? contacts;

  @override
  List<Object> get props => [contacts ?? false, contacts?.length ?? 0];
}

class ContactsInitial extends ContactsState {
  const ContactsInitial() : super(contacts: null);
}

class ContactsLoading extends ContactsState {
  const ContactsLoading() : super(contacts: null);
}

class ContactsError extends ContactsState {
  const ContactsError(this.message) : super();

  final String message;
}

class ContactsLoaded extends ContactsState {
  const ContactsLoaded({
    required List<Person> contacts,
  }) : super(contacts: contacts);
}
