import '../models/contact.dart';

abstract class ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> contacts;

  ContactLoaded(this.contacts);
}
