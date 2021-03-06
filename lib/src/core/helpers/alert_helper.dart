import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';

class AlertActionModel {
  final String? title;
  final Function? action;
  final bool isDestructiveAction;

  AlertActionModel({
    @required this.title,
    @required this.action,
    this.isDestructiveAction = false,
  });
}

class AlertHelper {
  static void showOnlyOkAlertDialog({
    @required BuildContext? ctx,
    @required String? msg,
  }) {
    showDialog(
      barrierDismissible: false,
      context: ctx!,
      builder: (ctx) => Platform.isIOS
          ? CupertinoAlertDialog(
              content: Text(msg!),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            )
          : AlertDialog(
              content: Text(msg!),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    AppStrings.ok,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
    );
  }

  static void showAlertDialogWithMultipleActions({
    @required BuildContext? ctx,
    @required String? msg,
    @required List<AlertActionModel>? actions,
    bool doAddCancelAction = false,
  }) {
    if (doAddCancelAction) {
      actions!.add(
        AlertActionModel(
          title: AppStrings.cancel,
          action: () {},
          isDestructiveAction: true,
        ),
      );
    }
    showDialog(
      barrierDismissible: false,
      context: ctx!,
      builder: (ctx) => Platform.isIOS
          ? CupertinoAlertDialog(
              content: Text(msg!),
              actions: actions!
                  .map((action) => CupertinoDialogAction(
                        isDestructiveAction: action.isDestructiveAction,
                        child: Text(action.title!),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          action.action!();
                        },
                      ))
                  .toList(),
            )
          : SimpleDialog(
              title: Text(
                msg!,
                textAlign: TextAlign.center,
              ),
              children: actions!
                  .map((action) => TextButton(
                        child: Text(
                          action.title!,
                          style: TextStyle(
                            color: action.isDestructiveAction
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          action.action!();
                        },
                      ))
                  .toList(),
            ),
    );
  }
}
