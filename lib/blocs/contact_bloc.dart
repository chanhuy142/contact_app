import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/contact_repository.dart';
import '../events/contact_event.dart';
import '../states/contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;

  ContactBloc(this.contactRepository) : super(ContactLoading()) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<DeleteContact>(_onDeleteContact);
  }

  void _onLoadContacts(LoadContacts event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    final contacts = await contactRepository.fetchContacts();
    emit(ContactLoaded(contacts));
  }

  void _onAddContact(AddContact event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded) {
      await contactRepository.addContact(event.contact);
      final contacts = await contactRepository.fetchContacts();
      emit(ContactLoaded(contacts));
    }
  }

  void _onDeleteContact(DeleteContact event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded) {
      await contactRepository.deleteContact(event.contact);
      final contacts = await contactRepository.fetchContacts();
      emit(ContactLoaded(contacts));
    }
  }
}
