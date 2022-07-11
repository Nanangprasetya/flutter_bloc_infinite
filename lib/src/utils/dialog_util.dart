import 'dart:async';
import 'package:flutter/material.dart';

enum Answer { yes_ok, no, cancel }

class DialogUtil {
  static Future<Answer?> showMessageDialog(BuildContext context, String message,
      {String title = 'Info',
      String? yesOkLabel: "OK",
      String? noLabel,
      String? cancelLabel}) {
    if (yesOkLabel?.isEmpty ?? true) {
      yesOkLabel = 'OK';
    }

    List<Widget> lstActions = [];
    lstActions.add(TextButton(
      child: Text(yesOkLabel!),
      onPressed: () {
        Navigator.of(context).pop(Answer.yes_ok);
      },
    ));

    if (noLabel?.isNotEmpty ?? false) {
      lstActions.add(TextButton(
        child: Text(noLabel!),
        onPressed: () {
          Navigator.of(context).pop(Answer.no);
        },
      ));
    }

    if (cancelLabel?.isNotEmpty ?? false) {
      lstActions.add(TextButton(
        child: Text(cancelLabel!),
        onPressed: () {
          Navigator.of(context).pop(Answer.cancel);
        },
      ));
    }

    return showDialog<Answer>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: lstActions,
        );
      },
    );
  }

  static Future<Answer?> showErrorDialog(BuildContext context, String message) {
    return showMessageDialog(context, message, title: "ERROR");
  }

  static Future<Answer?> showInfoDialog(BuildContext context, String message) {
    return showMessageDialog(context, message, title: "INFO");
  }

  static Future<Answer?> showConfirmationDialog(
      BuildContext context, String message,
      {String title = 'CONFIRMATION',
      String? yesOkLabel: "YES",
      String? noLabel: "NO",
      String? cancelLabel}) {
    return showMessageDialog(context, message,
        title: title,
        yesOkLabel: yesOkLabel,
        noLabel: noLabel,
        cancelLabel: cancelLabel);
  }

  static Future<Answer?> handleError(BuildContext context, Object errorObject,
      [StackTrace? stackTrace]) {
    if (stackTrace != null) {
      print('DialogUtil.handleError Error ' +
          DateTime.now().toString() +
          ' - $errorObject - ' +
          stackTrace.toString());
    }
    if (errorObject is TimeoutException) {
      return showErrorDialog(context, errorObject.message!);
    } else {
      print(errorObject);
      return showErrorDialog(context, errorObject.toString());
    }
  }
}
