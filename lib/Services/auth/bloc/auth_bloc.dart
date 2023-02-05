

import 'package:bloc/bloc.dart';
import 'package:learning_dart/Services/auth/auth_provider.dart';
import 'package:learning_dart/Services/auth/bloc/auth_events.dart';
import 'package:learning_dart/Services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>  {
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified){
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    on<AuthEventLogin>((event, emit) async{
      emit(const AuthStateLoading());
      final email = event.email;
      final password = event.password;
      try{
        final user = await provider.logIn(
            email: email,
            password: password
        );
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(const AuthStateLoggedOut());
        await provider.logOut();
      } on Exception catch (e){
        emit(AuthStateLogOutFailure(e));
      }
    });
  }
}