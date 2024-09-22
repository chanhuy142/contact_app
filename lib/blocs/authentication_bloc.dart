import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/user_repository.dart';
import '../events/authentication_event.dart';
import '../states/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(AuthenticationInitial()) {
    on<AppStarted>((event, emit) => emit(AuthenticationUnauthenticated()));
    on<LoggedIn>((event, emit) => emit(AuthenticationAuthenticated()));
    on<LoggedOut>((event, emit) => emit(AuthenticationUnauthenticated()));
  }
}
