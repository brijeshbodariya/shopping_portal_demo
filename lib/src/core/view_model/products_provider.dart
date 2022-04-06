import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/alert_helper.dart';
import 'package:shopping_portal_demo/src/core/helpers/url_constants.dart';
import 'package:shopping_portal_demo/src/core/models/product_model.dart';
import 'package:shopping_portal_demo/src/core/models/table_schemas/prod_table_schema.dart';

class ProductsProvider with ChangeNotifier {
  final databaseReference = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts(
      {@required BuildContext? context}) async {
    try {
      final snapShot = await databaseReference
          .collection(Tables.products)
          .where(ProductTable.isActive, isEqualTo: true)
          .get();
      if (snapShot.docs.isEmpty) {
        return [];
      }
      List<ProductModel> _prodsArray = [];
      for (var doc in snapShot.docs) {
        var imgUrlsJson = doc[ProductTable.imgUrlsArray];
        List<String> imgUrls =
            imgUrlsJson == null ? [] : List<String>.from(imgUrlsJson);

        var sizesJson =
            doc[ProductTable.sizesDetailMap][ProdSizesDetailMap.list];
        List<Map<String, dynamic>> sizesDynamicArray =
            sizesJson == null ? [] : List<Map<String, dynamic>>.from(sizesJson);
        List<ProdSizeModel> sizesArray = [];
        for (var sizeDynamic in sizesDynamicArray) {
          final prodSize = ProdSizeModel(
            id: sizeDynamic[ProdSizeMap.id],
            name: sizeDynamic[ProdSizeMap.name],
            remainingQty: sizeDynamic[ProdSizeMap.remainingQty] ?? 0,
          );

          sizesArray.add(prodSize);
        }

        final prod = ProductModel(
          id: doc.id,
          customerReviewsCount: doc[ProductTable.customerReviewsCount],
          descriptionMap: ProdDescriptionModel(
            long: doc[ProductTable.descriptionMap][ProdDescriptionMap.long],
            materialAndCare: doc[ProductTable.descriptionMap]
                [ProdDescriptionMap.materialAndCare],
            short1: doc[ProductTable.descriptionMap][ProdDescriptionMap.short1],
            short2: doc[ProductTable.descriptionMap][ProdDescriptionMap.short2],
            sizeAndFit: doc[ProductTable.descriptionMap]
                [ProdDescriptionMap.sizeAndFit],
          ),
          imgUrlsArray: imgUrls,
          manufacturerDetailMap: ProdManufacturerModel(
            brandId: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.brandId],
            brandName: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.brandName],
            id: doc[ProductTable.manufacturerDetailMap][ProdManufacturerMap.id],
            name: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.name],
            prodCode: doc[ProductTable.manufacturerDetailMap]
                [ProdManufacturerMap.prodCode],
          ),
          priceMap: ProdPriceModel(
            discountAmount: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountAmount],
            discountMaxAmountViaPercentage: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountMaxAmountViaPercentage],
            discountPercentage: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountPercentage],
            discountType: doc[ProductTable.priceDetailMap]
                [ProdPriceMap.discountType],
            price: doc[ProductTable.priceDetailMap][ProdPriceMap.price],
          ),
          sizesMap: ProdSizesDetailModel(
            list: sizesArray,
            specialMsg: doc[ProductTable.sizesDetailMap]
                    [ProdSizesDetailMap.specialMsg] ??
                '',
          ),
          specialMsg: doc[ProductTable.specialMsg] ?? '',
        );
        _prodsArray.add(prod);
      }

      return _prodsArray;
    } on FirebaseException catch (error) {
      print('fetchProducts error: $error');
      AlertHelper.showOnlyOkAlertDialog(ctx: context!, msg: error.message!);
      return [];
    }
  }
}
