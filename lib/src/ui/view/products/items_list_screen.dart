import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/models/product_model.dart';
import 'package:shopping_portal_demo/src/core/models/search_models.dart';
import 'package:shopping_portal_demo/src/core/view_model/products_provider.dart';
import 'package:shopping_portal_demo/src/ui/view/products/item_detail_screen.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_progress_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/tiles/item_tiles/item_grid_tile.dart';

class ItemsListScreen extends StatefulWidget {
  @override
  ItemsListScreenState createState() => ItemsListScreenState();

  final SearchProductsModel? searchProductsModel;
  final String? title;

  const ItemsListScreen({
    Key? key,
    @required this.searchProductsModel,
    @required this.title,
  }) : super(key: key);
}

class ItemsListScreenState extends State<ItemsListScreen> {
  var isLoading = false;
  List<ProductModel> _productArray = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isLoading = true;
      });
      _productArray =
          await Provider.of<ProductsProvider>(context, listen: false)
              .fetchProducts(context: context);
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void didTappedAtItem({@required int? index}) {
      final prod = _productArray[index!];
      final route = MaterialPageRoute(
          builder: (ctx) => ItemDetailScreen(
              product: prod, searchProductsModel: widget.searchProductsModel));
      Navigator.push(context, route);
    }

    _buildAppBar() => PreferredSize(
          preferredSize: const Size(0, AppConstants.preferredAppBarHeight),
          child: CustomAppBar(title: widget.title),
        );

    _buildBottomView() {
      return Container(
        height: 50,
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
                    icon: const Icon(Icons.sort_by_alpha),
                    label: const Text('Sort'),
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
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filter'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    _buildGridView() {
      return Expanded(
        child: Container(
          child: _productArray.isEmpty
              ? const Center(child: Text('No data yet'))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () => didTappedAtItem(index: index),
                      child: ItemGridTile(
                        product: _productArray[index],
                      ),
                    );
                  },
                  itemCount: _productArray.length,
                ),
        ),
      );
    }

    _buildScaffoldView() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              _buildGridView(),
              _buildBottomView(),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        _buildScaffoldView(),
        CustomProgressBar(status: isLoading),
      ],
    );
  }
}
