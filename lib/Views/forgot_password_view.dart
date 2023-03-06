import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_dart/Services/auth/bloc/auth_bloc.dart';
import 'package:learning_dart/Services/auth/bloc/auth_events.dart';
import 'package:learning_dart/Services/auth/bloc/auth_state.dart';
import 'package:learning_dart/utilities/dialogs/error_dialog.dart';
import 'package:learning_dart/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context, 'Something happened.');
          }
        }
      },
      child: Scaffold(
        appBar:AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children:  [
                const Text('If you have forgot your password,'
                    'enter your registered email id,'
                    'and reset your password from a mail we have sent you.'
                ),
                const TextField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  autofocus: true,
                  decoration:  InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextButton(
                    onPressed: () {
                      final email = _controller.text;
                      context.read<AuthBloc>().add(AuthEventForgotPassword(email: email));
                    },
                    child: const Text('Reset')
                ),
                TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    child: const Text('Login')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
