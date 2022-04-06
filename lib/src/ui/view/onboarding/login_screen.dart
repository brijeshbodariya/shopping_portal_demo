import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/helpers/alert_helper.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/helper.dart';
import 'package:shopping_portal_demo/src/core/helpers/validators.dart';
import 'package:shopping_portal_demo/src/core/view_model/auth_provider.dart';
import 'package:shopping_portal_demo/src/ui/view/account_summary/account_summary_screen.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_default_text_form_field.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_progress_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobNumEmailFocus = FocusNode();
  final _mobNumEmailController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void _submitLogInRequest() async {
      setState(() {
        isLoading = true;
      });

      Helper.dismissKeyboard(ctx: context);

      try {
        final isLogInDone = await authProvider.signIn(
          ctx: context,
          email: _mobNumEmailController.text,
          password: _passwordController.text,
        );
        if (isLogInDone) {
          print('Move to profile screen');
          final route = MaterialPageRoute(
            builder: (ctx) =>
                const AccountSummaryScreen(isComingAfterSignUp: true),
          );
          Navigator.push(context, route);
        } else {
          print('authProvider isLogInDone false');
        }
      } on FirebaseAuthException catch (error) {
        print('Error --> $error');
        AlertHelper.showOnlyOkAlertDialog(
            ctx: context, msg: '${error.message}');
      }
      setState(() {
        isLoading = false;
        _loginFormKey.currentState!.reset();
      });
    }

    void _loginBtnClicked() {
      Helper.dismissKeyboard(ctx: context);

      final isValid = _loginFormKey.currentState!.validate();
      if (isValid) {
        _loginFormKey.currentState!.save();
        _submitLogInRequest();
      }
    }

    Widget _buildScaffoldView() {
      return Scaffold(
        appBar: const PreferredSize(
          child: CustomAppBar(title: 'Login'),
          preferredSize: Size(0, AppConstants.preferredAppBarHeight),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Mobile Number or Email ID',
                    textController: _mobNumEmailController,
                    ownFocusNode: _mobNumEmailFocus,
                    nextFocusNode: _passwordFocus,
                    validationFunc: Validator.validateEmpty,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Password',
                    textController: _passwordController,
                    ownFocusNode: _passwordFocus,
                    textInputAction: TextInputAction.done,
                    isObscureText: true,
                    validationFunc: Validator.validateLoginPassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _loginBtnClicked,
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            BorderSide(color: AppColors.silver)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        )),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: AppColors.cabaret)),
                      ),
                      child: const Text(
                        'QUICK LOG IN USING OTP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.cabaret,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        _buildScaffoldView(),
        CustomProgressBar(status: isLoading),
      ],
    );
  }
}
