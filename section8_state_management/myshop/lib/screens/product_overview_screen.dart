import 'package:flutter/material.dart';
import 'package:myshop/widgets/badge.dart';
import 'package:provider/provider.dart';

import 'package:myshop/providers/products.dart';
import 'package:myshop/widgets/products_grid.dart';
import 'package:myshop/widgets/badge.dart';
import '../providers/cart.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(ch!, cart.itemcount.toString(), Colors.redAccent),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart),
              ))
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
