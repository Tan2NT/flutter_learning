import 'package:flutter/material.dart';
import 'package:myshop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart' as or;
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routedName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _orderFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      body: FutureBuilder(
          future: _orderFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                // Do error handling stuff
                return Text('There is an error occured');
              } else {
                return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                          itemBuilder: (ctx, i) =>
                              or.OrderItem(orderData.orders[i]),
                          itemCount: orderData.orders.length,
                        ));
              }
            }
          }),
      drawer: AppDrawer(),
    );
  }
}
