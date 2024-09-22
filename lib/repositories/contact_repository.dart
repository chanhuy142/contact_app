import '../models/contact.dart';

class ContactRepository {
  final List<Contact> _contacts = [
    Contact(name: 'Alice', phone: '123456789'),
    Contact(name: 'Bob', phone: '987654321'),
  ];

  Future<List<Contact>> fetchContacts() async {
    //chỗ này giả vờ fetch API nên đặt delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _contacts;
  }

  Future<void> addContact(Contact contact) async {
    //chỗ này cũng giả vờ fetch API nên đặt delay
    await Future.delayed(const Duration(milliseconds: 500));
    _contacts.add(contact);
  }

  Future<void> deleteContact(Contact contact) async {
    //chỗ này cũng giả vờ fetch API nên đặt delay
    await Future.delayed(const Duration(milliseconds: 500));
    _contacts.remove(contact);
  }
}
