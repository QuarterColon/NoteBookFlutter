import 'package:flutter/material.dart';
import 'package:learning_dart/Services/auth/auth_service.dart';
import 'package:learning_dart/Views/LoginView.dart';
import 'package:learning_dart/Views/RegisterView.dart';
import 'package:learning_dart/Views/VerifyEmailView.dart';
import 'package:learning_dart/constants/routes.dart';
import 'package:path/path.dart';
import 'Views/notes/new_note_view.dart';
import 'Views/notes/notes_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute : (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        notesRoute : (context) => const NotesView(),
        verifyEmailRoute : (context) => const VerifyEmailView(),
        newNoteRoute : (context) => const NewNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null){
              if (user.isEmailVerified){
                  return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}