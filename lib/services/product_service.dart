import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/products_model.dart';


class ProductService extends ChangeNotifier {

  final _baseUrl = 'mygymapp-6238a-default-rtdb.firebaseio.com';
  
  final List<Product> products = [];
  late Product selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductService() {
    loadProducts().then((value) => notifyListeners());

  }

  Future <List<Product>>loadProducts() async {
    final url = Uri.https(_baseUrl, 'users.json');  
    final resp = await http.get(url);
    final Map <String, dynamic> productsMap = await jsonDecode(resp.body);  
    
    productsMap.forEach((key, value) {
      // print('');
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      // print(key);
      products.add(tempProduct);
      
    });
    
    isLoading = false;
    notifyListeners();
    return products;

  }

  Future saveOrCreateProduct( Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // crear producto
    } else {

      await updateProduct(product);

    }

    isSaving = false;
    notifyListeners();
    
  }
  Future <String> updateProduct( Product product ) async {
    final url = Uri.https(_baseUrl, 'users/${product.id}.json');  
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    print(decodedData);

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future <String> createProduct( Product product ) async {
    final url = Uri.https(_baseUrl, 'users.json');  
    final resp = await http.post(url, body: product.toJson());
    final decodedData = jsonDecode(resp.body);

    print(decodedData);

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }
}
