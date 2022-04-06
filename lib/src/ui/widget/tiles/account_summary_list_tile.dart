import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';

class AccountSummaryListTile extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? summary;
  final MenuOptions? menuOption;
  final bool isShowDivider;
  final Function? goToScreen;

  const AccountSummaryListTile(
      {Key? key,
      @required this.icon,
      @required this.title,
      @required this.summary,
      this.menuOption,
      @required this.goToScreen,
      this.isShowDivider = true})
      : super(key: key);

  final double tileHeight = 80;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: menuOption != null ? () => goToScreen!(menuOption) : () {},
      child: Column(
        children: <Widget>[
          SizedBox(
            height: tileHeight,
            child: Row(
              children: <Widget>[
                Container(
                  width: tileHeight - 20,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 25,
                  ),
                  child: icon,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        summary!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: tileHeight,
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          if (isShowDivider) Container(height: 0.1, color: Colors.grey),
        ],
      ),
    );
  }
}
