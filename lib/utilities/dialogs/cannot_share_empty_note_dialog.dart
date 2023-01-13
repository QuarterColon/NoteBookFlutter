import 'package:flutter/cupertino.dart';
import 'package:learning_dart/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: 'Cannot share an empty Note',
    optionsBuilder: () => {
    'OK' : null,
    },
  );
}