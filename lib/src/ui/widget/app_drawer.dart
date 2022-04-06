import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_portal_demo/src/core/helpers/common_constants.dart';
import 'package:shopping_portal_demo/src/core/helpers/helper.dart';
import 'package:shopping_portal_demo/src/core/models/common_models.dart';
import 'package:shopping_portal_demo/src/core/models/search_models.dart';
import 'package:shopping_portal_demo/src/core/view_model/auth_provider.dart';
import 'package:shopping_portal_demo/src/core/view_model/category_provider.dart';
import 'package:shopping_portal_demo/src/ui/view/account_summary/account_summary_screen.dart';
import 'package:shopping_portal_demo/src/ui/view/onboarding/onboard_options_screen.dart';
import 'package:shopping_portal_demo/src/ui/view/products/items_list_screen.dart';
import 'package:shopping_portal_demo/src/ui/widget/app_drawer_profile_view.dart';
import 'package:shopping_portal_demo/src/ui/widget/tiles/app_drawer/app_drawer_list_tile.dart';
import 'package:shopping_portal_demo/src/ui/widget/tiles/app_drawer/app_drawer_sub_list_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  List<CategoryModal> _topCategoriesArray = [];

  @override
  void initState() {
    print('App Drawer initState');
    Future.delayed(Duration.zero).then((_) {
      final catProvider = Provider.of<CategoryProvider>(context, listen: false);
      setState(() {
        _topCategoriesArray = catProvider.categories.values.toList();
      });
    });

    super.initState();
  }

  CategoryModal? _selCategory;
  SubCategoryModal? _selSubCategory;

  void _profileViewTapped() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    Navigator.pop(context);
    if (authProvider.isAuthorized) {
      final route = MaterialPageRoute(
        builder: (context) => const AccountSummaryScreen(),
      );
      Navigator.push(context, route);
    } else {
      final route = MaterialPageRoute(
        builder: (context) => const OnboardOptionsScreen(),
      );
      Navigator.push(context, route);
    }
  }

  void _categoryViewTapped(CategoryModal category) {
    if (category.subCategoriesIDs!.isEmpty) {
      return;
    }
    setState(() {
      _selCategory = category;
    });
  }

  void _subCategoryViewTapped(SubCategoryModal subCategory) {
    if (subCategory.subSubCategoriesIDs!.isEmpty) {
      return;
    }
    setState(() {
      if (_selSubCategory != null) {
        _selSubCategory = subCategory == _selSubCategory ? null : subCategory;
      } else {
        _selSubCategory = subCategory;
      }
    });
  }

  void _subSubCategoryViewTapped(SubSubCategoryModal subSubCategory) {
    Navigator.pop(context);
    final searchProdModel = SearchProductsModel(
      category: _selCategory,
      subCategory: _selCategory,
      subSubCategory: subSubCategory,
    );
    final route = MaterialPageRoute(
      builder: (ctx) => ItemsListScreen(
        searchProductsModel: searchProdModel,
        title: subSubCategory.name,
      ),
    );
    Navigator.push(context, route);
  }

  void _menuOptionViewTapped(MenuOptions menuOption) {
    switch (menuOption) {
      case MenuOptions.account:
        Navigator.pop(context);
        final route =
            MaterialPageRoute(builder: (ctx) => const AccountSummaryScreen());
        Navigator.push(context, route);

        break;

      default:
        print(
            'No action assigned yet for this MenuOptions: ${Helper.getMenuOptionValue(menuOption)}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget getSubMenuList() {
      final _subCategoriesArray = _selCategory!.subCategories;
      return ListView.builder(
        itemBuilder: (ctx, index) => AppDrawerSubListTile(
          subCategory: _subCategoriesArray![index],
          index: index,
          isSelected: _selSubCategory != null
              ? _selSubCategory == _subCategoriesArray[index]
                  ? true
                  : false
              : false,
          subCategoryViewTapped: _subCategoryViewTapped,
          subSubCategoryViewTapped: _subSubCategoryViewTapped,
        ),
        itemCount: _subCategoriesArray!.length,
      );
    }

    Widget getSubMenuDrawer() {
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            _selCategory = null;
                            _selSubCategory = null;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _selCategory!.name!,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 0.2,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Expanded(
            child: getSubMenuList(),
          ),
        ],
      );
    }

    Widget getMainDrawer() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: const AppDrawerProfileView(),
              onTap: _profileViewTapped,
            ),
            Column(
              children: _topCategoriesArray.map((category) {
                return AppDrawerCategoryListTile(
                  category: category,
                  leadItem: FadeInImage(
                    placeholder: const AssetImage(
                      AppIcons.flutter,
                    ),
                    image: NetworkImage(category.menuIconImageUrl),
                    fit: BoxFit.cover,
                  ),
                  trailingItem: category.subCategoriesIDs!.isEmpty
                      ? Container()
                      : Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                        ),
                  categoryViewTapped: _categoryViewTapped,
                );
              }).toList(),
            ),
            Container(
              height: 0.1,
              color: Colors.grey,
            ),
            AppDrawerListTile(
              menuOption: MenuOptions.account,
              titleWeight: FontWeight.w300,
              leadItem: Image.asset(
                AppIcons.accountBlack,
                color: Colors.grey[700],
              ),
              menuOptionViewTapped: _menuOptionViewTapped,
            ),
            Container(
              height: 0.1,
              color: Colors.grey,
            ),
          ],
        ),
      );
    }

    return Drawer(
      child: SafeArea(
        child: _selCategory == null ? getMainDrawer() : getSubMenuDrawer(),
      ),
    );
  }
}
