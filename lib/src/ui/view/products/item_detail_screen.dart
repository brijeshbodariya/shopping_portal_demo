// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/blocs/item_detail_bloc.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/helper.dart';
import 'package:shopping_portal_demo/src/core/models/product_model.dart';
import 'package:shopping_portal_demo/src/core/models/search_models.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/item_detail_carousel_with_indicator.dart';
import 'package:shopping_portal_demo/src/ui/widget/item_detail_floating_bottom_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/tiles/item_tiles/item_size_grid_tile.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ItemDetailScreen extends StatefulWidget {
  @override
  ItemDetailScreenState createState() => ItemDetailScreenState();

  final SearchProductsModel? searchProductsModel;
  final ProductModel? product;

  const ItemDetailScreen({
    Key? key,
    @required this.searchProductsModel,
    @required this.product,
  }) : super(key: key);
}

class ItemDetailScreenState extends State<ItemDetailScreen> {
  ItemDetailBloc? _itemDetailBloc;

  @override
  void initState() {
    print('ItemDetailScreen initState');
    super.initState();
  }

  @override
  void dispose() {
    print('ItemDetailScreen dispose');

    if (_itemDetailBloc != null) {
      _itemDetailBloc!.dispose();
    }
    super.dispose();
  }

  void didTappedAtItemId(String id) {}

  DiscountTypes get getDiscountType {
    return Helper.getDiscountTypeFor(
        code: widget.product!.priceMap!.discountType!);
  }

  String get getDiscountString {
    String discountString = '';
    final discountType = getDiscountType;
    switch (discountType) {
      case DiscountTypes.amount:
        discountString = 'Rs ${widget.product!.priceMap!.discountAmount} off';
        break;

      case DiscountTypes.percentage:
        discountString = '${widget.product!.priceMap!.discountPercentage}% off';
        break;

      default:
        break;
    }
    return discountString;
  }

  @override
  Widget build(BuildContext context) {
    _itemDetailBloc = ItemDetailBloc();

    _moreInfoView() => Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'VIEW INFORMATION',
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Product Code: ${widget.product!.manufacturerDetailMap!.prodCode}',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Sold by: ${widget.product!.manufacturerDetailMap!.brandName}',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'VIEW MORE',
                  style: TextStyle(
                    color: AppColors.cabaret,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );

    _deliveryView() => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'DELIVERY & SERVICES FOR',
                style: TextStyle(color: AppColors.silver),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.silver,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter PIN Code',
                          hintStyle: TextStyle(
                            color: AppColors.cabaret,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'CHANGE',
                        style: TextStyle(
                          color: AppColors.cabaret,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Cash on delivery might be available',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Try & Buy might be available',
                  style: TextStyle(
                    color: AppColors.silver,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );

    _productDetailView() => StreamProvider.value(
          initialData: _itemDetailBloc!.getProdDetailStatus,
          value: _itemDetailBloc!.showHideProdDetailStream,
          child: ProductDetailView(
              product: widget.product!, itemDetailBloc: _itemDetailBloc!),
        );

    _couponView() => Container(
          padding: const EdgeInsets.all(15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Text('You Pay Only:'),
                  Text(
                    'Rs319',
                    style: TextStyle(color: Colors.pink),
                  ),
                  Spacer(),
                  Text(
                    'Save: Rs30',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Text(
                'Apply the coupon during checkout',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              const Text(
                'Orders above Rs. 1499 (only on first purchase). T&C apply.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    child: const Text('ASD324HBHBH3J24'),
                    color: Colors.pink[50],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Tap to copy'),
                  )
                ],
              )
            ],
          ),
        );

    _buildPriceDiscountView() {
      return Row(
        children: <Widget>[
          const SizedBox(
            width: 5,
          ),
          Text(
            'Rs ${widget.product!.priceMap!.price}',
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

    _buildPriceView() {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
        ),
        child: Row(
          children: <Widget>[
            Text(
              '${AppStrings.rupeeSign} ${Helper.getIteratedPriceToShowFor(product: widget.product)}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
            ),
            if (getDiscountType != DiscountTypes.none)
              _buildPriceDiscountView(),
          ],
        ),
      );
    }

    _sizeView() => StreamProvider.value(
          initialData: _itemDetailBloc!.getSizeChartVisibilityStatus,
          value: _itemDetailBloc!.sizeChartVisiblityCheckerStream,
          child: SizeView(
              product: widget.product!, itemDetailBloc: _itemDetailBloc!),
        );

    _mainBody() => SizedBox(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: ItemDetailCarouselWithIndicator(
                          itemsArray: widget.product!.imgUrlsArray),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                widget
                                    .product!.manufacturerDetailMap!.brandName!,
                                style: const TextStyle(fontSize: 13),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.product!.descriptionMap!.short2!,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.product!.descriptionMap!.short1!,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                            ),
                          ),
                          _buildPriceView(),
                          Text(
                            widget.product!.specialMsg!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(color: Colors.white, height: 10),
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 0.2,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextButton.icon(
                                  icon: const Icon(Icons.content_copy),
                                  label: const Text('Similar'),
                                  onPressed: () {},
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  width: 0.4,
                                  color: Colors.grey,
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.compare),
                                  label: const Text('Compare'),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _couponView(),
                    const SizedBox(
                      height: 20,
                    ),
                    _sizeView(),
                    const SizedBox(
                      height: 20,
                    ),
                    _productDetailView(),
                    const SizedBox(
                      height: 20,
                    ),
                    _deliveryView(),
                    const SizedBox(
                      height: 20,
                    ),
                    _moreInfoView(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              StreamBuilder<bool>(
                stream: _itemDetailBloc!.sizeChartVisiblityCheckerStream,
                builder: (ctx, snapshot) {
                  return snapshot.data == true
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: ItemDetailFloatingBottomBar(
                                product: widget.product),
                          ),
                        )
                      : Container();
                },
              ),
            ],
          ),
        );

    _buildAppBar() => PreferredSize(
          preferredSize: const Size(0, AppConstants.preferredAppBarHeight),
          child: CustomAppBar(
              title: widget.product!.manufacturerDetailMap!.brandName),
        );

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _mainBody(),
      ),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  final ProductModel? product;
  final ItemDetailBloc? itemDetailBloc;

  const ProductDetailView({
    Key? key,
    @required this.product,
    @required this.itemDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<bool>(context)
        ? Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Text(
                      'Product Details',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        itemDetailBloc!.updateProdDetailViewStatus();
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
                Text(
                  product!.descriptionMap!.long!,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Material & Care',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  product!.descriptionMap!.materialAndCare!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: <Widget>[
                const Text(
                  'Product Details',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    itemDetailBloc!.updateProdDetailViewStatus();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          );
  }
}

class SizeView extends StatelessWidget {
  final ProductModel? product;
  final ItemDetailBloc? itemDetailBloc;

  const SizeView({
    Key? key,
    @required this.product,
    @required this.itemDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Text(
                'SELECT SIZE (UK SIZE)',
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Text(
                'SIZE CHART',
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 75,
            child: ListView.builder(
              itemBuilder: (ctx, index) => ProductSizeGridTile(
                prodSize: product!.sizesMap!.list![index],
                isSelected: product!.selectedSizeIndex == index,
              ),
              itemCount: product!.sizesMap!.list!.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          VisibilityDetector(
            key: const Key("unique key"),
            child: ItemDetailFloatingBottomBar(
              product: product,
            ),
            onVisibilityChanged: (VisibilityInfo info) {
              if (info.visibleFraction == 1.0) {
                itemDetailBloc!.changeBottomBarVisibiltyTo(false);
              } else if (info.visibleFraction == 0.0) {
                itemDetailBloc!.changeBottomBarVisibiltyTo(true);
              }
            },
          ),
        ],
      ),
    );
  }
}
