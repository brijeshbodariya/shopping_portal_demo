import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';

class CustomDefaultOutlineButtonWithIcon extends StatelessWidget {
  final String? titleString;
  final TextStyle? titleTextStyle;
  final double height;
  final VoidCallback? buttonClicked;

  const CustomDefaultOutlineButtonWithIcon({
    Key? key,
    @required this.titleString,
    this.titleTextStyle,
    this.height = 40,
    this.buttonClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: AppColors.silver)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
        textStyle:
            MaterialStateProperty.all(TextStyle(color: AppColors.cabaret)),
      ),
      child: Text(
        titleString!,
        style: TextStyle(
          color: titleTextStyle!.color ?? AppColors.cabaret,
          fontSize: titleTextStyle!.fontSize ?? 14,
          fontWeight: titleTextStyle!.fontWeight ?? FontWeight.w600,
        ),
      ),
      onPressed: buttonClicked ??
          () => print(
              'CustomDefaultOutlineButtonWithIcon clicked with title: $titleString'),
    );
  }
}
