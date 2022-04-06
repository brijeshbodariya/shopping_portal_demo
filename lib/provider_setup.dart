import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shopping_portal_demo/src/core/blocs/item_detail_bloc.dart';
import 'package:shopping_portal_demo/src/core/view_model/auth_provider.dart';
import 'package:shopping_portal_demo/src/core/view_model/category_provider.dart';
import 'package:shopping_portal_demo/src/core/view_model/product_provider.dart';
import 'package:shopping_portal_demo/src/core/view_model/products_provider.dart';

List<SingleChildStatelessWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => ProductsProvider()),
  Provider(create: (_) => ItemDetailBloc()),
  ChangeNotifierProxyProvider<AuthProvider, ProductProvider?>(
    update: (_, AuthProvider authProvider, ProductProvider? productProvider) =>
        productProvider!
          ..userID = authProvider.getUserID
          ..userDocID = authProvider.getUserDocID,
    create: (_) => ProductProvider(),
  ),
];
