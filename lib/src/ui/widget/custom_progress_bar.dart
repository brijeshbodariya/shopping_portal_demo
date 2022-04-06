// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';

class CustomProgressBar extends StatelessWidget {
  final bool? status;

  const CustomProgressBar({Key? key, @required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status!) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SpinKitCircle(
            color: AppColors.silver,
            size: 42,
          ),
        ),
      );
    }
    return const SizedBox(
      height: 0.0,
      width: 0.0,
    );
  }
}
