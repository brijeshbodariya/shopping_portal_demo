import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/models/common_models.dart';
import 'package:shopping_portal_demo/src/core/view_model/category_provider.dart';
import 'package:shopping_portal_demo/src/ui/widget/app_drawer.dart';
import 'package:shopping_portal_demo/src/ui/widget/custom_app_bar.dart';
import 'package:shopping_portal_demo/src/ui/widget/tiles/home_tiles/home_screen_hot_deals_list_tile.dart';
import 'package:shopping_portal_demo/src/ui/widget/tiles/home_tiles/home_screen_top_category_tile.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  List<CategoryModal> topCategoriesArray = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });
      final catProvider = Provider.of<CategoryProvider>(context, listen: false);
      catProvider.fetchAndSetCategories().then((_) {
        setState(() {
          topCategoriesArray = catProvider.categories.values.toList();
          _isLoading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildAppBar(BuildContext context) {
      return const PreferredSize(
        preferredSize: Size(0, AppConstants.preferredAppBarHeight),
        child: CustomAppBar(
            leftButton: CustomAppBarLeftButtonsTypes.menu,
            title: 'Friendly Shopping'),
      );
    }

    _buildScaffoldView() {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _buildTopListView(),
                    Image.asset(
                      AppImages.banner1,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) =>
                            const HomeScreenHotDealsListTile(
                          heading: 'THE DESI WAY',
                          title: 'Shop Ethnic Wear At Min. 50% Off!',
                          imageName: AppImages.women,
                          msg: '+ DON\'T MISS THIS',
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: topCategoriesArray.length,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      AppImages.banner2,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        drawer: const AppDrawer(),
      );
    }

    return _buildScaffoldView();
  }

  _buildTopListView() {
    return SizedBox(
      height: 110,
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => HomeScreenTopCategoryListTile(
                title: topCategoriesArray[index].name,
                imageName: topCategoriesArray[index].homePageImageUrl,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: topCategoriesArray.length,
            ),
    );
  }
}
