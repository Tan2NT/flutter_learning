import 'package:flutter/material.dart';

import 'package:myshop/models/product.dart';
import 'package:myshop/widgets/product_item.dart';
import 'package:myshop/widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyShop')),
      body: ProductsGrid(),
    );
  }
}
