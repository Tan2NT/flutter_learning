import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(this.id, this.amount, this.products, this.dateTime);
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authtoken;
  final String _baseURL =
      'https://flutter-update-3bbe4-default-rtdb.asia-southeast1.firebasedatabase.app';

  Orders(this.authtoken, this._orders);

  List<OrderItem> get orders {
    return _orders;
  }

  Future<void> fetchAndSetOrders() async {
    var url = Uri.parse('/orders.json');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          orderId,
          orderData['amount'],
          (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  item['id'], item['title'], item['quantity'], item['price']))
              .toList(),
          DateTime.parse(orderData['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse('$_baseURL/orders.json?auth=$authtoken');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(json.decode(response.body)['name'], total, cartProducts,
            DateTime.now()));
    notifyListeners();
  }
}
