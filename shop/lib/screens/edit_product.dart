import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';

import '../providers/product.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _imageURLFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    description: '',
    imageURL: '',
    price: 0,
    isFavorite: false,
  );
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageURL': '',
  };

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final prodID = ModalRoute.of(context)?.settings.arguments;
      if (prodID != null) {
        _editedProduct = Provider.of<Products>(
          context,
          listen: false,
        ).findById(prodID as String);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageURL': '',
        };
        _imageURLController.text = _editedProduct.imageURL;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageURLFocusNode.removeListener(_updateImageURL);
    _imageURLFocusNode.dispose();
    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      setState(() => _isLoading = true);
      if (_editedProduct.id != '') {
        Provider.of<Products>(context, listen: false)
            .editProduct(_editedProduct)
            .then((value) {
          setState(() => _isLoading = false);
          Navigator.of(context).pop();
        });
      } else {
        Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct)
            .then((value) {
          setState(() => _isLoading = false);
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (val) => (val == null || val.isEmpty)
                          ? 'Please provide a title'
                          : null,
                      initialValue: _initValues['title'],
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: '$value',
                        description: _editedProduct.title,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      initialValue: _initValues['description'],
                      maxLines: 3,
                      validator: (val) => (val == null || val.isEmpty)
                          ? 'Please provide a description'
                          : (val.length < 10
                              ? 'Description should have atleast 10 characters'
                              : null),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: '$value',
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                      initialValue: _initValues['price'],
                      validator: (val) => (val == null || val.isEmpty)
                          ? 'Please provide a price'
                          : ((double.tryParse(val) == null)
                              ? 'Invalid number'
                              : ((double.parse(val) < 1)
                                  ? 'Please add number greater than zero'
                                  : null)),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _editedProduct = Product(
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        imageURL: _editedProduct.imageURL,
                        price: double.parse(value!),
                        isFavorite: _editedProduct.isFavorite,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageURLController.text.isEmpty
                              ? const Text('Enter URL')
                              : FittedBox(
                                  child:
                                      Image.network(_imageURLController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                            child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          validator: (val) => (val == null || val.isEmpty)
                              ? 'Please enter image URL'
                              : ((!val.startsWith('http') &&
                                      !val.startsWith('https')
                                  ? 'Please enter a valid URL.'
                                  : null)),
                          controller: _imageURLController,
                          focusNode: _imageURLFocusNode,
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onSaved: (value) => _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            imageURL: '$value',
                            price: _editedProduct.price,
                            isFavorite: _editedProduct.isFavorite,
                          ),
                          onFieldSubmitted: (_) => _saveForm,
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
