import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/models/product_model.dart';

class Helper {
  static void dismissKeyboard({@required BuildContext? ctx}) {
    FocusScopeNode currentFocus = FocusScope.of(ctx!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static DiscountTypes getDiscountTypeFor({@required int? code}) {
    var discountType = DiscountTypes.none;

    switch (code) {
      case 1:
        discountType = DiscountTypes.amount;
        break;

      case 2:
        discountType = DiscountTypes.percentage;
        break;

      default:
        break;
    }

    return discountType;
  }

  static int? getIteratedPriceToShowFor({@required ProductModel? product}) {
    var iteratedPrice = product!.priceMap!.price;
    final discountType =
        getDiscountTypeFor(code: product.priceMap!.discountType);
    switch (discountType) {
      case DiscountTypes.amount:
        iteratedPrice = (iteratedPrice! - product.priceMap!.discountAmount!);
        break;

      case DiscountTypes.percentage:
        iteratedPrice = (iteratedPrice! -
                (iteratedPrice * product.priceMap!.discountPercentage!) / 100)
            as int;
        break;

      default:
        break;
    }

    return iteratedPrice;
  }

  static String getMenuOptionValue(MenuOptions menuOption) {
    switch (menuOption) {
      case MenuOptions.account:
        return 'Account';
      case MenuOptions.none:
        return 'None';

      default:
        return '';
    }
  }
}
