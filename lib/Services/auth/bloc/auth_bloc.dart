

import 'package:bloc/bloc.dart';
import 'package:learning_dart/Services/auth/auth_provider.dart';
import 'package:learning_dart/Services/auth/bloc/auth_events.dart';
import 'package:learning_dart/Services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>  {
  AuthBloc(AuthProvider provider) : super(const AuthStateUninitialized()) {

    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(email: email, password: password);
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification());
      } on Exception catch (e) {
        emit (AuthStateRegistering(e));
      }
    });


    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(null,false),);
      } else if (!user.isEmailVerified){
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    on<AuthEventLogin>((event, emit) async{
      emit(const AuthStateLoggedOut(
          null,
          true,
      ));
      final email = event.email;
      final password = event.password;
      try{
        final user = await provider.logIn(
            email: email,
            password: password
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(null,false));
          emit(const AuthStateNeedsVerification());
        } else {
          emit(AuthStateLoggedIn(user));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(e,false));
      }
    });

    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(const AuthStateLoggedOut(null, false));
        await provider.logOut();
      } on Exception catch (e){
        emit(AuthStateLoggedOut(e, true));
      }
    });
  }
}