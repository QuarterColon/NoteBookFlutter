import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_dart/Services/auth/bloc/auth_events.dart';
import '../Services/auth/bloc/auth_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email'),),
      body: Column(
          children: [
            const Text("A verification email has already been sent. If not,"),
            const Text('please verify your email address:'),
            TextButton(onPressed: () async {
              context.read<AuthBloc>().add(const AuthEventSendEmailVerification());
            },
                child: const Text('send email verification')
            ),
            TextButton(onPressed: () async {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
                child: const Text('Sign Out')
            ),
          ]
      ),
    );
  }
}