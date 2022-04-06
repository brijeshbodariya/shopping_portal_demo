import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/helper.dart';
import 'package:shopping_portal_demo/src/core/models/product_model.dart';

class ItemGridTile extends StatelessWidget {
  final ProductModel? product;

  const ItemGridTile({Key? key, @required this.product}) : super(key: key);

  DiscountTypes get getDiscountType {
    return Helper.getDiscountTypeFor(code: product!.priceMap!.discountType!);
  }

  String get getDiscountString {
    String discountString = '';
    final discountType = getDiscountType;
    switch (discountType) {
      case DiscountTypes.amount:
        discountString = 'Rs ${product!.priceMap!.discountAmount} off';
        break;

      case DiscountTypes.percentage:
        discountString = '${product!.priceMap!.discountPercentage}% off';
        break;

      default:
        break;
    }
    return discountString;
  }

  Widget _buildPriceDiscountView() {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 5,
        ),
        Text(
          'Rs ${product!.priceMap!.price}',
          style: TextStyle(
            color: Colors.grey[500],
            decoration: TextDecoration.lineThrough,
            fontSize: 11,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          getDiscountString,
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          Text(
            '${AppStrings.rupeeSign} ${Helper.getIteratedPriceToShowFor(product: product)}',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
          if (getDiscountType != DiscountTypes.none) _buildPriceDiscountView(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.silver,
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: FadeInImage(
              placeholder: const AssetImage(
                AppIcons.flutter,
              ),
              image: NetworkImage(product!.imgUrlsArray!.first),
              fit: BoxFit.contain,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      product!.manufacturerDetailMap!.brandName!,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      product!.descriptionMap!.short1!,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 11,
                      ),
                    ),
                  ),
                  _buildPriceView(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      product!.specialMsg!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                width: 20,
                child: const Icon(
                  Icons.bookmark_border,
                  color: Colors.pink,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
