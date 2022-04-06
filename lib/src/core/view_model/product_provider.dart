import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/url_constants.dart';
import 'package:shopping_portal_demo/src/core/models/table_schemas/user_table_schema.dart';

class ProductProvider with ChangeNotifier {
  String? userID;
  String? userDocID;

  final _databaseReference = FirebaseFirestore.instance;

  Future<bool> addProdToCartListWith({@required String? prodID}) async {
    try {
      await _databaseReference
          .collection(Tables.users)
          .doc('$userDocID')
          .update({
        UserTable.cartListDetailMap: {
          UserCartListMap.prodIDsList: FieldValue.arrayUnion([prodID])
        }
      });

      print('Add prod to cart done');

      return true;
    } catch (e) {
      print('Add prod to cart error: $e');
      return false;
    }
  }

  Future<bool> addProdToWishListWith({@required String? prodID}) async {
    try {
      await _databaseReference
          .collection(Tables.users)
          .doc('$userDocID')
          .update({
        UserTable.wishListDetailMap: {
          UserWishListMap.prodIDsList: FieldValue.arrayUnion([prodID])
        }
      });
      print('Add prod to wishlist done');

      return true;
    } catch (e) {
      print('Add prod to wishlist error: $e');
      return false;
    }
  }
}
