import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_dart/Services/auth/auth_exceptions.dart';
import 'package:learning_dart/Services/auth/bloc/auth_events.dart';
import 'package:learning_dart/Services/auth/bloc/auth_state.dart';
import 'package:learning_dart/constants/routes.dart';
import '../Services/auth/bloc/auth_bloc.dart';
import '../utilities/dialogs/error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Email'
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
                hintText: 'Password'
            ),
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthStateLoggedOut){
                if (state.exception is UserNotFoundAuthException) {
                  await showErrorDialog(context, "User does not exist");
                } else if (state.exception is WrongPasswordAuthException) {
                  await showErrorDialog(context, "Wrong Credentials");
                } else if (state.exception is GenericAuthException) {
                  await showErrorDialog(context, "Authentication Error. Something went wrong");
                }
              }
            },
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                context.read<AuthBloc>().add(
                    AuthEventLogin(
                      email,
                      password,
                    )
                );
              },
                child: const Text("Login"),
          ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                      (route) => false
              );
            },
            child: const Text ("Not registered yet? Register here!"),
          ),
        ],
      ),
    );
  }
}

