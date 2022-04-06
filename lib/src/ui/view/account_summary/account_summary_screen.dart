import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/helpers/alert_helper.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/view_model/auth_provider.dart';
import 'package:shopping_portal_demo/src/ui/view/account_summary/account_summary_top_view.dart';
import 'package:shopping_portal_demo/src/ui/view/home_screen.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';

class AccountSummaryScreen extends StatelessWidget {
  final bool isComingAfterSignUp;

  const AccountSummaryScreen({Key? key, this.isComingAfterSignUp = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void _logOutBtnClicked() {
      AlertHelper.showAlertDialogWithMultipleActions(
        ctx: context,
        msg: 'Are you sure to logout?',
        actions: [
          AlertActionModel(
            title: AppStrings.yes,
            action: () {
              authProvider.logOut();

              final route =
                  MaterialPageRoute(builder: (ctx) => const HomeScreen());
              Navigator.push(context, route);
            },
          ),
          AlertActionModel(
            title: AppStrings.no,
            action: () {},
          ),
        ],
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, AppConstants.preferredAppBarHeight),
        child: CustomAppBar(
          title: '',
          popRoute: isComingAfterSignUp
              ? MaterialPageRoute(builder: (ctx) => const HomeScreen())
              : null,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const AccountSummaryTopView(),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 20,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 90,
                color: Colors.grey[200],
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(color: AppColors.cabaret)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    )),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: AppColors.cabaret)),
                  ),
                  child: const Text(
                    'LOG OUT',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  onPressed: _logOutBtnClicked,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
