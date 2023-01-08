import 'package:flutter/cupertino.dart';
import 'package:learning_dart/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context){
  return showGenericDialog(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this note?',
    optionsBuilder: () => {
      'Cancel' : false,
      'Yes' : true,
    },
  ).then((value) => value ?? false);
}