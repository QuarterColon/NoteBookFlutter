import 'package:flutter/material.dart';
import 'package:learning_dart/Services/auth/auth_service.dart';
import 'package:learning_dart/constants/routes.dart';

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
              await AuthService.firebase().sendEmailVerification();
            },
                child: const Text('send email verification')
            ),
            TextButton(onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                      (route) => false);
            },
                child: const Text('Sign Out')
            ),
          ]
      ),
    );
  }
}