import 'package:flutter/material.dart';
import '../providers/product.dart';

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
  Product _editedProdcut = Product(
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
    _form.currentState!.save();
    print('TDebug  ${_editedProdcut.title}');
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
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      _editedProdcut = Product(
                          title: value != null ? value : _editedProdcut.title,
                          id: _editedProdcut.id,
                          description: _editedProdcut.description,
                          price: _editedProdcut.price,
                          imageUrl: _editedProdcut.imageUrl);
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Price',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      _editedProdcut = Product(
                          title: _editedProdcut.title,
                          id: _editedProdcut.id,
                          description: _editedProdcut.description,
                          price: value != null
                              ? double.parse(value)
                              : _editedProdcut.price,
                          imageUrl: _editedProdcut.imageUrl);
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProdcut = Product(
                          title: _editedProdcut.title,
                          id: _editedProdcut.id,
                          description: value == null
                              ? _editedProdcut.description
                              : value,
                          price: _editedProdcut.price,
                          imageUrl: _editedProdcut.imageUrl);
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
                          onSaved: (value) {
                            _editedProdcut = Product(
                                title: _editedProdcut.title,
                                id: _editedProdcut.id,
                                description: _editedProdcut.description,
                                price: _editedProdcut.price,
                                imageUrl: value == null
                                    ? _editedProdcut.imageUrl
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
