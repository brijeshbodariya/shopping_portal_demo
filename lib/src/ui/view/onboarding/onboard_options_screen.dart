import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/ui/view/onboarding/login_screen.dart';
import 'package:shopping_portal_demo/src/ui/view/onboarding/sign_up_screen.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_button_with_image.dart';

class OnboardOptionsScreen extends StatelessWidget {
  const OnboardOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _normalLoginBtnClicked() {
      final route =
          MaterialPageRoute(builder: (context) => const LoginScreen());
      Navigator.push(context, route);
    }

    void _signupClicked() {
      final route =
          MaterialPageRoute(builder: (context) => const SignUpScreen());
      Navigator.push(context, route);
    }

    return Scaffold(
      appBar: const PreferredSize(
        child: CustomAppBar(title: ''),
        preferredSize: Size(0, AppConstants.preferredAppBarHeight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: const CustomButtonWithImage(
                        imageNameString: AppIcons.facebook,
                        titleString: 'Facebook',
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      child: const CustomButtonWithImage(
                        imageNameString: AppIcons.google,
                        titleString: 'Google',
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              InkWell(
                child: const CustomButtonWithImage(
                  imageNameString: AppIcons.mailBlack,
                  titleString: 'Log in using email',
                ),
                onTap: _normalLoginBtnClicked,
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                child: const CustomButtonWithImage(
                  imageNameString: AppIcons.phoneBlack,
                  titleString: 'Log in using mobile number',
                ),
                onTap: _normalLoginBtnClicked,
              ),
              const SizedBox(
                height: 25,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'New to Friendly Shopping? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign up ',
                      style: TextStyle(
                        color: AppColors.cabaret,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => _signupClicked(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
