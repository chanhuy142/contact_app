import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/contact_bloc.dart';
import '../events/contact_event.dart';
import '../states/contact_state.dart';
import '../repositories/contact_repository.dart';
import '../models/contact.dart';
import '../blocs/authentication_bloc.dart';
import '../events/authentication_event.dart';
import 'add_contact_screen.dart';

class ContactListScreen extends StatelessWidget {
  final ContactRepository contactRepository = ContactRepository();

  ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(contactRepository)..add(LoadContacts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              },
            ),
          ],
        ),
        body: BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            if (state is ContactLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ContactLoaded) {
              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.phone),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<ContactBloc>(context)
                            .add(DeleteContact(contact));
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load contacts'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddContactScreen()),
            );
            if (result != null && result is Contact) {
              BlocProvider.of<ContactBloc>(context).add(AddContact(result));
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
