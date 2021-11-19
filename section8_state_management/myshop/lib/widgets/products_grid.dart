import 'package:flutter/material.dart';
import 'package:myshop/providers/products.dart';
import 'package:provider/provider.dart';

import 'package:myshop/widgets/product_item.dart';
import 'package:myshop/providers/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showFavs ? productsData.favovriteItems : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (c) => products[i],
        value: products[i],
        child: ProductItem(
            // products[i].id, products[i].title, products[i].imageUrl
            ),
      ),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
