import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/models/product_model.dart';

class ItemDetailFloatingBottomBar extends StatefulWidget {
  final ProductModel? product;

  const ItemDetailFloatingBottomBar({Key? key, @required this.product})
      : super(key: key);

  @override
  State<ItemDetailFloatingBottomBar> createState() =>
      _ItemDetailFloatingBottomBarState();
}

class _ItemDetailFloatingBottomBarState
    extends State<ItemDetailFloatingBottomBar> {
  bool _isWishListLoading = false;
  bool _isCartLoading = false;

  @override
  Widget build(BuildContext context) {
    void wishListBtnClicked() async {
      setState(() {
        _isWishListLoading = true;
      });

      setState(() {
        _isWishListLoading = false;
      });
    }

    void addToCartBtnClicked() async {
      setState(() {
        _isCartLoading = true;
      });
      setState(() {
        _isCartLoading = false;
      });
    }

    _buildWishListLoader() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
        padding: const EdgeInsets.all(5),
        child: Center(
          child: CircularProgressIndicator(backgroundColor: AppColors.cabaret),
        ),
      );
    }

    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 9,
            child: _isWishListLoading
                ? _buildWishListLoader()
                : OutlinedButton.icon(
                    onPressed: wishListBtnClicked,
                    icon: const Icon(Icons.bookmark),
                    label: const Text(
                      'ADD TO WISHLIST',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 11,
            child: _isCartLoading
                ? _buildWishListLoader()
                : TextButton.icon(
                    onPressed: addToCartBtnClicked,
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'ADD TO BAG',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
