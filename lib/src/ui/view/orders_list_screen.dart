import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/ui/view/home_screen.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';

class OrdersListScreen extends StatelessWidget {
  static const routeName = '/order-list';

  final ordersArray = [];

  OrdersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        child: CustomAppBar(title: 'ORDERS'),
        preferredSize: Size(0, AppConstants.preferredAppBarHeight),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.grey[100],
              ),
            ),
            ordersArray.isEmpty
                ? Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'NO ACTIVE ORDERS',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'There are no recent orders to show.',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 220,
                          child: Image.asset('assets/images/img_empty_box.png'),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          height: 90,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                  const BorderSide(color: Colors.grey)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(color: Colors.blueAccent)),
                            ),
                            child: const Text('     START SHOPPING     '),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomeScreen.routeName,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => const SizedBox(),
                      itemCount: 0,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
