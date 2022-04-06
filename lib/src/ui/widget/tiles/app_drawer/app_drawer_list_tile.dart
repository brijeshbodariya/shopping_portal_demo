import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/helper.dart';
import 'package:shopping_portal_demo/src/core/models/common_models.dart';

class AppDrawerListTile extends StatelessWidget {
  final MenuOptions? menuOption;
  final Color titleColor;
  final FontWeight titleWeight;
  final Widget? leadItem;
  final Widget? trailingItem;
  final Function? menuOptionViewTapped;

  const AppDrawerListTile({
    Key? key,
    @required this.menuOption,
    this.titleColor = Colors.black,
    this.titleWeight = FontWeight.w500,
    @required this.leadItem,
    this.trailingItem,
    @required this.menuOptionViewTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => menuOptionViewTapped!(menuOption),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 20,
              alignment: Alignment.center,
              child: leadItem,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              Helper.getMenuOptionValue(menuOption!),
              style: TextStyle(
                color: titleColor,
                fontWeight: titleWeight,
                fontSize: 13,
              ),
            ),
            const Spacer(),
            if (trailingItem != null) trailingItem!,
          ],
        ),
      ),
    );
  }
}

class AppDrawerCategoryListTile extends StatelessWidget {
  final CategoryModal? category;
  final Color titleColor;
  final FontWeight titleWeight;
  final Widget? leadItem;
  final Widget? trailingItem;
  final Function? categoryViewTapped;

  const AppDrawerCategoryListTile({
    Key? key,
    @required this.category,
    this.titleColor = Colors.black,
    this.titleWeight = FontWeight.w500,
    @required this.leadItem,
    this.trailingItem,
    @required this.categoryViewTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => categoryViewTapped!(category),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 20,
              alignment: Alignment.center,
              child: leadItem,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              category!.name!,
              style: TextStyle(
                color: titleColor,
                fontWeight: titleWeight,
                fontSize: 13,
              ),
            ),
            const Spacer(),
            if (trailingItem != null) trailingItem!,
          ],
        ),
      ),
    );
  }
}
