import 'package:flutter/material.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart' as or;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routedName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      body: ListView.builder(
        itemBuilder: (ctx, i) => or.OrderItem(orders.orders[i]),
        itemCount: orders.orders.length,
      ),
      drawer: AppDrawer(),
    );
  }
}
