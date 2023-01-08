import 'package:flutter/cupertino.dart';
import 'package:learning_dart/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context){
  return showGenericDialog(
    context: context,
    title: 'Log Out',
    content: 'Are you sure you want to Log Out?',
    optionsBuilder: () => {
    'cancel' : false,
    'Log Out' : true,
  },
  ).then((value) => value ?? false);
}