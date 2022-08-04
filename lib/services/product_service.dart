import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/products_model.dart';


class ProductService extends ChangeNotifier {

  final _baseUrl = 'mygymapp-6238a-default-rtdb.firebaseio.com';
  
  final List<Product> products = [];

  bool isLoading = true;

  ProductService() {
    loadProducts().then((value) => notifyListeners());

  }

  Future <List<Product>>loadProducts() async {
    final url = Uri.https(_baseUrl, 'users.json');  
    // print(url);
    final resp = await http.get(url);
    final Map <String, dynamic> productsMap = await jsonDecode(resp.body);  
    
    productsMap.forEach((key, value) {
      // print('');
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      // print(key);
      products.add(tempProduct);
      
    });
    
    return products; 
  }

}
