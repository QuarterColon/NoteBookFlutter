import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_dart/Services/auth/auth_service.dart';
import 'package:learning_dart/Services/auth/bloc/auth_bloc.dart';
import 'package:learning_dart/Services/auth/bloc/auth_events.dart';
import 'package:learning_dart/Services/auth/bloc/auth_state.dart';
import 'package:learning_dart/Services/auth/firebase_auth_provider.dart';
import 'package:learning_dart/Views/LoginView.dart';
import 'package:learning_dart/Views/RegisterView.dart';
import 'package:learning_dart/Views/VerifyEmailView.dart';
import 'package:learning_dart/constants/routes.dart';
import 'Views/notes/create_update_note_view.dart';
import 'Views/notes/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute : (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        notesRoute : (context) => const NotesView(),
        verifyEmailRoute : (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute : (context) => const CreateOrUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateLoggedIn){
        return const NotesView();
      } else if (state is AuthStateNeedsVerification){
        return const VerifyEmailView();
      } else if(state is AuthStateLoggedOut) {
        return const LoginView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    },
    );
  }
}

