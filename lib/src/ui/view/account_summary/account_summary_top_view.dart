import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/prefs_constants.dart';

class AccountSummaryTopView extends StatefulWidget {
  const AccountSummaryTopView({Key? key}) : super(key: key);

  @override
  AccountSummaryTopViewState createState() => AccountSummaryTopViewState();
}

class AccountSummaryTopViewState extends State<AccountSummaryTopView> {
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserPrefs();
  }

  _loadUserPrefs() async {
    final userPrefsMap = await FSPrefs.getUserPrefsMap();
    setState(() {
      name = userPrefsMap[FSPrefs.userName] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 260,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            height: 100,
          ),
        ),
        Positioned(
          left: 15,
          bottom: 30,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: Colors.white,
            ),
            child: Image.asset(AppImages.user),
          ),
        ),
        Positioned(
          left: 180,
          bottom: 70,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
