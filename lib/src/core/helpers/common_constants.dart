import 'dart:core';

import 'package:shopping_portal_demo/src/core/extensions/color_extension.dart';

enum CustomAppBarLeftButtonsTypes {
  back,
  cross,
  menu,
}

enum DiscountTypes { amount, none, percentage }

enum GenderTypes {
  female,
  male,
  none,
}

enum MenuOptions {
  account,
  none,
}

class AppColors {
  static final cabaret = HexColor('#DA4C6E');
  static final oceanGreen = HexColor('#46A786');
  static final silver = HexColor('#BDBDBD');
}

class AppConstants {
  static const preferredAppBarHeight = 50.0;
}

class AppIcons {
  static const accountBlack = 'assets/icons/icon_account_black.png';
  static const bellBlack = 'assets/icons/icon_bell_black.png';
  static const bookmarkBlack = 'assets/icons/icon_bookmark_black.png';
  static const boxBlack = 'assets/icons/icon_box_black.png';
  static const cosmeticsBlack = 'assets/icons/icon_cosmetics_black.png';
  static const crossBlack = 'assets/icons/icon_cross_black.png';
  static const downArrow = 'assets/icons/icon_down_arrow.png';
  static const flutter = 'assets/icons/icon_flutter.png';
  static const homeBlack = 'assets/icons/icon_home_black.png';
  static const kidClothBlack = 'assets/icons/icon_kid_cloth_black.png';
  static const leftArrowBlack = 'assets/icons/icon_left_arrow_black.png';
  static const menDress = 'assets/icons/icon_men_dress.png';
  static const menuBlack = 'assets/icons/icon_menu_black.png';
  static const portfolioBlack = 'assets/icons/icon_portfolio_black.png';
  static const rightDirectBlack = 'assets/icons/icon_right_direct_black.png';
  static const shoppingBagBlack = 'assets/icons/icon_shopping_bag.png';
  static const winterClothBlack = 'assets/icons/icon_winter_cloth_black.png';
  static const womenDress = 'assets/icons/icon_women_dress.png';
  static const userBlack = 'assets/icons/user_black.png';

  static const facebook = 'assets/icons/social/facebook.png';
  static const google = 'assets/icons/social/google.png';
  static const mailBlack = 'assets/icons/social/mail_black.png';
  static const phoneBlack = 'assets/icons/social/phone_black.png';
}

class AppImages {
  static const banner1 = 'assets/images/img_banner1.jpg';
  static const banner2 = 'assets/images/img_banner2.jpg';
  static const emptyBox = 'assets/images/img_empty_box.png';
  static const freeDelivery = 'assets/images/img_free_delivery.png';
  static const kids = 'assets/images/img_kid.jpg';
  static const lowestPrice = 'assets/images/img_lowest_price.jpg';
  static const men = 'assets/images/img_men.png';
  static const user = 'assets/images/img_user.jpg';
  static const women = 'assets/images/img_women.png';
}

class AppStrings {
  static const cancel = 'Cancel';
  static const no = 'No';
  static const ok = 'Ok';
  static const rupeeSign = '₹';
  static const yes = 'Yes';
}
