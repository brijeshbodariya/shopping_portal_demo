import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/validators.dart';
import 'package:shopping_portal_demo/src/core/view_model/auth_provider.dart';
import 'package:shopping_portal_demo/src/ui/view/account_summary/account_summary_screen.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_default_outline_button_with_icon.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_default_text_form_field.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_progress_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailFocus = FocusNode();
  final _emailController = TextEditingController();
  final _mobNumFocus = FocusNode();
  final _mobNumController = TextEditingController();
  final _passwordFocus = FocusNode();
  final _passwordController = TextEditingController();
  final _nameFocus = FocusNode();
  final _nameController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void _femaleBtnClicked() {
      authProvider.setSignUpSelectedGenderTypeTo(gender: GenderTypes.female);
    }

    void _maleBtnClicked() {
      authProvider.setSignUpSelectedGenderTypeTo(gender: GenderTypes.male);
    }

    void _submitSignUpRequest() async {
      setState(() {
        isLoading = true;
      });

      await authProvider
          .signUp(
        ctx: context,
        email: _emailController.text,
        password: _passwordController.text,
        mobNum: _mobNumController.text,
        name: _nameController.text,
      )
          .then((isSignUpDone) {
        if (isSignUpDone) {
          print('Move to profile screen');
          final route =
              MaterialPageRoute(builder: (ctx) => const AccountSummaryScreen());
          Navigator.pushAndRemoveUntil(
              context, route, (Route<dynamic> route) => false);
        } else {
          print('authProvider isSignUpDone false');
        }
      }).catchError((err) {
        print('authProvider catchError: $err');
      });

      setState(() {
        isLoading = false;
        _signUpFormKey.currentState!.reset();
      });
    }

    void _createAccountBtnClicked() {
      final isValid = _signUpFormKey.currentState!.validate();
      if (isValid) {
        _signUpFormKey.currentState!.save();
        _submitSignUpRequest();
      }
    }

    Widget _buildGenderView() {
      return SizedBox(
        height: 40,
        child: Selector<AuthProvider, GenderTypes>(
          selector: (context, authProvider) =>
              authProvider.getSignUpSelectedGenderType,
          builder: (ctx, signUpSelectedGenderType, _) {
            final gender = signUpSelectedGenderType;
            const normalTextStyle =
                TextStyle(color: Colors.black, fontWeight: FontWeight.w300);
            const selectedTextStyle =
                TextStyle(color: Colors.black, fontWeight: FontWeight.w800);
            return Row(
              children: <Widget>[
                Expanded(
                  child: CustomDefaultOutlineButtonWithIcon(
                    titleString: 'Female',
                    titleTextStyle: gender == GenderTypes.female
                        ? selectedTextStyle
                        : normalTextStyle,
                    buttonClicked: _femaleBtnClicked,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: CustomDefaultOutlineButtonWithIcon(
                    titleString: 'Male',
                    titleTextStyle: gender == GenderTypes.male
                        ? selectedTextStyle
                        : normalTextStyle,
                    buttonClicked: _maleBtnClicked,
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    Widget _buildScaffoldView() {
      return Scaffold(
        appBar: const PreferredSize(
          child: CustomAppBar(title: 'Sign up'),
          preferredSize: Size(0, AppConstants.preferredAppBarHeight),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                children: <Widget>[
                  CustomDefaultTextFormField(
                    placeHolderString: 'Email address*',
                    textController: _emailController,
                    ownFocusNode: _emailFocus,
                    textInputType: TextInputType.emailAddress,
                    nextFocusNode: _passwordFocus,
                    validationFunc: Validator.validateEmail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Password*',
                    textController: _passwordController,
                    ownFocusNode: _passwordFocus,
                    nextFocusNode: _mobNumFocus,
                    isObscureText: true,
                    validationFunc: Validator.validateLoginPassword,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Mobile Number(for order updates)',
                    textController: _mobNumController,
                    ownFocusNode: _mobNumFocus,
                    nextFocusNode: _nameFocus,
                    textInputType: TextInputType.number,
                    validationFunc: Validator.validateOptionalMobile,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomDefaultTextFormField(
                    placeHolderString: 'Full Name*',
                    textController: _nameController,
                    ownFocusNode: _nameFocus,
                    validationFunc: Validator.validateEmpty,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildGenderView(),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _createAccountBtnClicked,
                      child: const Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
