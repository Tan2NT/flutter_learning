import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInited = false;
  var _initValues = {
    'title': '',
    'description': '',
    'price': 0.0,
    'id': '',
    'imageURL': ''
  };

  Product _editedProduct = Product(
      id: "sdafs",
      title: "dflsf",
      description: 'dfsfsdf',
      price: 0.3,
      imageUrl: 'https://aslfs',
      isFavorite: false);

  @override
  void initState() {
    _imageUrFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInited) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      _editedProduct =
          Provider.of<Products>(context, listen: false).findById(productId);
      _initValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'id': _editedProduct.id,
        'imageURL': ''
      };
      _imageUrlController.text = _editedProduct.imageUrl;
      _isInited = true;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageUrFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    if (_editedProduct.id.isEmpty) {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Product'),
          actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    initialValue: _initValues['title'] as String,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide a value';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          title: value != null ? value : _editedProduct.title,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Price',
                    ),
                    initialValue: _initValues['price'] as String,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide a value';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      if (double.parse(value) < 0) {
                        return 'price must equal or greater than 0';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          title: _editedProduct.title,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          description: _editedProduct.description,
                          price: value != null
                              ? double.parse(value)
                              : _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    initialValue: _initValues['description'] as String,
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      if (value.length < 10) {
                        return 'description must longer than 10 words';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          title: _editedProduct.title,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          description: value == null
                              ? _editedProduct.description
                              : value,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter a URL')
                            : FittedBox(
                                child: Image.network(
                                    'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
                                    fit: BoxFit.cover))),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrFocusNode,
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an image URL';
                            }
                            if (!value.startsWith('http') ||
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL';
                            }
                            // if (!value.endsWith('.png') ||
                            //     !value.endsWith('.jpg')) {
                            //   return 'Please enter a valid Url Image';
                            // }

                            return null;
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                title: _editedProduct.title,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value == null
                                    ? _editedProduct.imageUrl
                                    : value);
                          }),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
