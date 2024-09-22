import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc.dart';
import 'events/authentication_event.dart';
import 'states/authentication_state.dart';
import 'repositories/user_repository.dart';
import 'screens/login_screen.dart';
import 'screens/contact_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Pattern App',
      home: BlocProvider(
        create: (context) =>
            AuthenticationBloc(userRepository)..add(AppStarted()),
        child: App(userRepository: userRepository),
      ),
    );
  }
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  const App({required this.userRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationAuthenticated) {
          return ContactListScreen();
        } else if (state is AuthenticationUnauthenticated) {
          return LoginScreen(userRepository: userRepository);
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
