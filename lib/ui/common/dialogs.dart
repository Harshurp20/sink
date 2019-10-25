import 'package:flutter/material.dart';
import 'package:sink/theme/palette.dart' as Palette;

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String confirmationText;
  final String proceedText;
  final String cancelText;

  final Color proceedColor;
  final Color cancelColor;

  final Function onProceed;
  final Function onCancel;

  ConfirmationDialog({
    @required this.title,
    @required this.confirmationText,
    @required this.proceedText,
    @required this.cancelText,
    @required this.onProceed,
    @required this.onCancel,
    proceedColor,
    cancelColor,
  })  : this.proceedColor = proceedColor ?? Palette.discouraged,
        this.cancelColor = cancelColor ?? Palette.dimBlueGrey;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      content: Text(confirmationText, textAlign: TextAlign.center),
      actions: <Widget>[
        FlatButton(
          child: Text(cancelText),
          textColor: Colors.white,
          color: cancelColor,
          onPressed: () => onCancel(),
        ),
        FlatButton(
          child: Text(proceedText),
          textColor: Colors.white,
          color: proceedColor,
          onPressed: () => onProceed(),
        ),
      ],
    );
  }
}