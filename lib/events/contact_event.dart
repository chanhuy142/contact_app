import '../models/contact.dart';

abstract class ContactEvent {}

class LoadContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final Contact contact;

  AddContact(this.contact);
}

class DeleteContact extends ContactEvent {
  final Contact contact;

  DeleteContact(this.contact);
}
