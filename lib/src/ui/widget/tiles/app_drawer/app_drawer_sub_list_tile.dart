import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/models/common_models.dart';

class AppDrawerSubListTile extends StatelessWidget {
  final SubCategoryModal? subCategory;
  final bool isSelected;
  final int? index;
  final Function? subCategoryViewTapped;
  final Function? subSubCategoryViewTapped;

  const AppDrawerSubListTile({
    Key? key,
    @required this.subCategory,
    this.isSelected = false,
    @required this.index,
    @required this.subCategoryViewTapped,
    @required this.subSubCategoryViewTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          onTap: () => subCategoryViewTapped!(subCategory),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  subCategory!.name!,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[800],
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w400 : FontWeight.w300,
                  ),
                ),
                if (subCategory!.subSubCategoriesIDs!.isNotEmpty)
                  Icon(
                    isSelected
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey[400],
                  ),
              ],
            ),
          ),
        ),
        Container(
          height: 0.3,
          color: Colors.grey[400],
        ),
        if (isSelected)
          Column(
            children: subCategory!.subSubCategories!.map((subSubCategory) {
              return InkWell(
                onTap: () => subSubCategoryViewTapped!(subSubCategory),
                child: AppDrawerSubSubListTile(subSubCategory: subSubCategory),
              );
            }).toList(),
          )
      ],
    );
  }
}

class AppDrawerSubSubListTile extends StatelessWidget {
  final SubSubCategoryModal? subSubCategory;

  const AppDrawerSubSubListTile({Key? key, @required this.subSubCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Text(
                  subSubCategory!.name!,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.3,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}
