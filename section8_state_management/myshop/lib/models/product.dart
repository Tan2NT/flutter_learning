import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id = "",
      @required this.title = "",
      @required this.description = "",
      @required this.price = 0.0,
      @required this.imageUrl = "",
      @required this.isFavorite = false});
}