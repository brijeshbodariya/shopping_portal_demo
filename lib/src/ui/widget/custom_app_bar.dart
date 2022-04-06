import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';

class CustomAppBar extends StatelessWidget {
  final CustomAppBarLeftButtonsTypes leftButton;
  final MaterialPageRoute? popRoute;
  final String? title;
  final bool isShowDivider;
  final List<Widget>? rightWidgets;

  const CustomAppBar({
    Key? key,
    this.leftButton = CustomAppBarLeftButtonsTypes.back,
    this.popRoute,
    @required this.title,
    this.rightWidgets,
    this.isShowDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: <Widget>[
                    buildLeftIconButton(context),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    if (rightWidgets != null) ...rightWidgets!
                  ],
                ),
              ),
            ),
            Container(
              height: 0.3,
              color: AppColors.silver,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeftIconButton(BuildContext context) {
    switch (leftButton) {
      case CustomAppBarLeftButtonsTypes.back:
        return SizedBox(
          width: 30,
          child: IconButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            icon: const Image(
              image: AssetImage(AppIcons.leftArrowBlack),
              fit: BoxFit.cover,
            ),
            onPressed: () {
              if (popRoute != null) {
                Navigator.popUntil(context, (popRoute) => true);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        );

      case CustomAppBarLeftButtonsTypes.menu:
        return SizedBox(
          width: 30,
          child: IconButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            icon: const Image(
              image: AssetImage(
                AppIcons.menuBlack,
              ),
              fit: BoxFit.cover,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        );

      default:
        return Container();
    }
  }
}
