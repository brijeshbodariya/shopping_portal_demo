import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';

class HomeScreenTopCategoryListTile extends StatelessWidget {
  final String? imageName;
  final String? title;

  const HomeScreenTopCategoryListTile(
      {Key? key, @required this.imageName, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
      child: Card(
        elevation: 2,
        child: Column(
          children: <Widget>[
            Expanded(
              child: FadeInImage(
                placeholder: const AssetImage(
                  AppIcons.flutter,
                ),
                image: NetworkImage(imageName!),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 25,
              alignment: Alignment.center,
              child: Text(
                title!,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
