import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:myshop/providers/product.dart';

class Products with ChangeNotifier {
  List<String> _imageUrls = [
    'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ];

  final _baseURL =
      'https://flutter-update-3bbe4-default-rtdb.asia-southeast1.firebasedatabase.app';

  final String authtoken;
  final String userId;

  Products(this.authtoken, this.userId, this._items);

  List<Product> _items = [];

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((product) => product.isFavorite).toList();
    // }

    return [..._items];
  }

  List<Product> get favovriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> fetchAndSetProducts(bool filterByUser) async {
    final url = filterByUser == true
        ? Uri.parse(
            '$_baseURL/products.json?auth=$authtoken&orderBy="creatorId"&equalTo="$userId"')
        : Uri.parse('$_baseURL/products.json?auth=$authtoken');
    try {
      final response = await http.get(url);
      _items.clear();
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final favoriteUrl =
          Uri.parse('$_baseURL/userFavorites/$userId.json?auth=$authtoken');
      final favoriteResponse = await http.get(favoriteUrl);
      final favoriteData = json.decode(favoriteResponse.body);

      extractedData.forEach((productId, productData) {
        _items.add(Product(
            id: productId,
            title: productData['title'] as String,
            description: productData['description' as String],
            price: productData['price'],
            //imageUrl: productData['imageUrl'],
            imageUrl: _imageUrls[Random().nextInt(_imageUrls.length - 1)],
            isFavorite: favoriteData == null
                ? false
                : favoriteData[productId] ?? false));
        notifyListeners();
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse('$_baseURL/products.json?auth=$authtoken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'cretorId': userId
          }));

      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          isFavorite: product.isFavorite);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    try {
      final prodIndex = _items.indexWhere((prod) => prod.id == id);
      if (prodIndex >= 0) {
        var url = Uri.parse('$_baseURL/products/$id.json?auth=$authtoken');
        await http.patch(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
              'isFavorite': newProduct.isFavorite
            }));

        _items[prodIndex] = newProduct;
        notifyListeners();
      }
    } catch (error) {}
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.parse('$_baseURL/products/$id.json?auth=$authtoken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    final existingProduct = _items[existingProductIndex];
    final response = await http.delete(url);
    _items.removeAt(existingProductIndex);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      //throw HttpException('Could not delete product.');
    }
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
}
