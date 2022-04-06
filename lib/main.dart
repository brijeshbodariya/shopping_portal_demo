import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/provider_setup.dart';
import 'package:shopping_portal_demo/src/core/helpers/helper.dart';
import 'package:shopping_portal_demo/src/core/view_model/auth_provider.dart';
import 'package:shopping_portal_demo/src/res/values/theme.dart';
import 'package:shopping_portal_demo/src/ui/view/home_screen.dart';
import 'package:shopping_portal_demo/src/ui/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper.dismissKeyboard(ctx: context),
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Consumer<AuthProvider>(
            builder: (ctx, authProvider, _) {
              return authProvider.isAuthorized
                  ? const HomeScreen()
                  : FutureBuilder(
                      future: authProvider.tryAutoLogin(),
                      builder: (ctx1, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const HomeScreen();
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
