import 'package:flutter/material.dart';
import 'package:myshop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProduct(BuildContext context) async {
    Provider.of<Products>(context, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: _refreshProduct(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _refreshProduct(context),
                      child: Consumer<Products>(
                        builder: (ctx, productData, _) => Padding(
                          padding: EdgeInsets.all(8),
                          child: ListView.builder(
                            itemBuilder: (_, i) => Column(
                              children: [
                                UserProductItem(
                                    productsData.items[i].id,
                                    productsData.items[i].title,
                                    productsData.items[i].imageUrl),
                                Divider()
                              ],
                            ),
                            itemCount: productsData.items.length,
                          ),
                        ),
                      ),
                    ),
        ));
  }
}
