import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/products_model.dart';


class ProductService extends ChangeNotifier {

  final _baseUrl = 'mygymapp-6238a-default-rtdb.firebaseio.com';
  
  final List<Product> products = [];
  late Product selectedProduct;

  File? newPictureFile;

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
      await createProduct( product );
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

    product.id = decodedData['name'];

    products.add( product );
    
    return product.id!;
  }

  void updateSelectedProductImage( String path){

    selectedProduct.imagen = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dx0pryfzn/image/upload?upload_preset=autwc6pa');
    
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    print( resp.body );
  }
}