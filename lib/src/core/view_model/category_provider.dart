import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shopping_portal_demo/src/core/helpers/url_constants.dart';
import 'package:shopping_portal_demo/src/core/models/common_models.dart';
import 'package:shopping_portal_demo/src/core/models/table_schemas/common_tables_schema.dart';

class CategoryProvider with ChangeNotifier {
  final databaseReference = FirebaseFirestore.instance;

  final Map<String, CategoryModal> _categories = <String, CategoryModal>{};

  Map<String, CategoryModal> get categories {
    return {..._categories};
  }

  CategoryModal? getCategoryBy(String id) {
    return _categories[id];
  }

  void _addOrUpdate({@required CategoryModal? category}) {
    if (_categories.containsKey(category!.id)) {
      _categories.update(category.id!, (existingCategory) {
        return CategoryModal(
          name: existingCategory.name,
          id: existingCategory.id,
          homePageImageUrl: existingCategory.homePageImageUrl,
          menuIconStoragePath: existingCategory.menuIconStoragePath,
          menuIconImageUrl: category.menuIconImageUrl,
          subCategoriesIDs: existingCategory.subCategoriesIDs,
          subCategories: category.subCategories,
        );
      });
    } else {
      _categories.putIfAbsent(category.id!, () {
        return CategoryModal(
          name: category.name,
          id: category.id,
          homePageImageUrl: category.homePageImageUrl,
          menuIconStoragePath: category.menuIconStoragePath,
          menuIconImageUrl: category.menuIconImageUrl,
          subCategoriesIDs: category.subCategoriesIDs,
          subCategories: category.subCategories,
        );
      });
    }
  }

  Future<void> fetchAndSetCategories() async {
    if (_categories.isNotEmpty) {
      return;
    }
    try {
      print('fetchAndSetCategories from server');

      await databaseReference
          .collection(Tables.categories)
          .where(CategoryTable.isActive, isEqualTo: true)
          .get()
          .then((QuerySnapshot snapshot) {
        if (snapshot.docs.isEmpty) {
          return;
        }

        for (var doc in snapshot.docs) {
          var subCategoriesIDsJson = doc[CategoryTable.subCatIDs];
          List<String> subCategoriesIDs = subCategoriesIDsJson == null
              ? []
              : List<String>.from(subCategoriesIDsJson);
          final newCat = CategoryModal(
            name: doc[CategoryTable.name],
            id: doc.id,
            homePageImageUrl: doc[CategoryTable.imageUrl],
            menuIconStoragePath: doc[CategoryTable.menuIconName],
            subCategoriesIDs: subCategoriesIDs,
            subCategories: [],
          );
          _getDownloadableUrlFor(category: newCat);
          _addOrUpdate(category: newCat);
        }

        notifyListeners();

        _fetchAndSetSubCategories();
      });
    } on FirebaseException catch (error) {
      print('fetchAndSetCategories error: ${error.message}');
      rethrow;
    }
  }

  Future<void> _getDownloadableUrlFor({CategoryModal? category}) async {
    try {
      if (category!.menuIconStoragePath == '') {
        return;
      }
      Reference reference =
          FirebaseStorage.instance.ref(category.menuIconStoragePath);
      category.menuIconImageUrl = await reference.getDownloadURL();
      _addOrUpdate(category: category);
    } catch (error) {
      print('getDownloadableUrlFor ${category!.name} error: $error');
      rethrow;
    }
  }

  Future<void> _fetchAndSetSubCategories() async {
    try {
      print('fetchAndSetSubCategories from server');
      final List<SubCategoryModal> loadedSubCategories = [];

      await databaseReference
          .collection(Tables.subCategories)
          .where(SubCategoryTable.isActive, isEqualTo: true)
          .get()
          .then((QuerySnapshot snapshot) {
        if (snapshot.docs.isEmpty) {
          print('fetchAndSetSubCategoriesFor documents: isEmpty');
          return;
        }
        for (var doc in snapshot.docs) {
          var subSubCategoriesIDsJson = doc[SubCategoryTable.subSubCatIDs];

          List<String> subSubCategoriesIDs = subSubCategoriesIDsJson == null
              ? []
              : List<String>.from(subSubCategoriesIDsJson);

          loadedSubCategories.add(SubCategoryModal(
            name: doc[SubCategoryTable.name],
            id: doc.id,
            subSubCategoriesIDs: subSubCategoriesIDs,
            subSubCategories: [],
          ));
        }

        for (var cat in _categories.values) {
          for (var subCat in loadedSubCategories) {
            if (cat.subCategoriesIDs!.contains(subCat.id)) {
              cat.subCategories!.add(subCat);
            }
          }
          _addOrUpdate(category: cat);
        }

        _fetchAndSetSubSubCategories();
      });
    } catch (error) {
      print('fetchAndSetSubCategories error: $error');
      rethrow;
    }
  }

  Future<void> _fetchAndSetSubSubCategories() async {
    try {
      print('fetchAndSetSubSubCategories from server');
      final List<SubSubCategoryModal> loadedSubSubCategories = [];

      await databaseReference
          .collection(Tables.subSubCategories)
          .where(SubCategoryTable.isActive, isEqualTo: true)
          .get()
          .then((QuerySnapshot snapshot) {
        if (snapshot.docs.isEmpty) {
          print('fetchAndSetSubSubCategoriesFor documents: isEmpty');
          return;
        }
        for (var doc in snapshot.docs) {
          loadedSubSubCategories.add(SubSubCategoryModal(
              name: doc[SubCategoryTable.name], id: doc.id));
        }

        for (var cat in _categories.values) {
          for (var subCat in cat.subCategories!) {
            for (var subSubCat in loadedSubSubCategories) {
              if (subCat.subSubCategoriesIDs!.contains(subSubCat.id)) {
                subCat.subSubCategories!.add(subSubCat);
              }
            }
          }
          _addOrUpdate(category: cat);
        }
      });
    } catch (error) {
      print('fetchAndSetSubCategories error: $error');
      rethrow;
    }
  }
}
