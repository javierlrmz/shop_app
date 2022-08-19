import 'package:flutter/material.dart';
import 'package:shop_app/models/products_model.dart';

class ProductFormService extends ChangeNotifier {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Product product;

  ProductFormService(this.product);

  isValidForm(){
    
    // print(product.descripcion);

    // print(product.precio);
    

    return formkey.currentState?.validate() ?? false;
  }
  
}