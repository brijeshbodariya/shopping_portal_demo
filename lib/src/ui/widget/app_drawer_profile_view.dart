import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/prefs_constants.dart';
import 'package:shopping_portal_demo/src/core/view_model/auth_provider.dart';

class AppDrawerProfileView extends StatefulWidget {
  const AppDrawerProfileView({Key? key}) : super(key: key);

  @override
  _AppDrawerProfileViewState createState() => _AppDrawerProfileViewState();
}

class _AppDrawerProfileViewState extends State<AppDrawerProfileView> {
  String name = 'Login - Sign up';

  _loadUserPrefs() async {
    final userPrefsMap = await FSPrefs.getUserPrefsMap();
    setState(() {
      name = userPrefsMap[FSPrefs.userName] as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isAuthorized) {
      _loadUserPrefs();
    }

    return Container(
      height: 140,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.red],
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 70,
                    padding: authProvider.isAuthorized
                        ? const EdgeInsets.all(15)
                        : const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset(AppIcons.userBlack),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
