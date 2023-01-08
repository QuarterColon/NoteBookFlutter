

import 'package:flutter/cupertino.dart';
import 'package:learning_dart/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
    BuildContext context,
    String text) {
  return showGenericDialog(
      context: context,
      title: "An Error Occurred",
      content: text,
      optionsBuilder: () => {
        'OK' : null,
      }
      );
}
