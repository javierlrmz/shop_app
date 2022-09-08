import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products_model.dart';
import 'package:shop_app/services/product_service.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  
    final productService = Provider.of<ProductService>(context);
    final List productList = productService.products;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton( 
            icon: const Icon(Icons.logout_rounded), 
            onPressed: () {
              print(FirebaseAuth.instance.currentUser?.uid);
              FirebaseAuth.instance.signOut();
              print(              FirebaseAuth.instance.signOut());
              Navigator.pushReplacementNamed(context, 'login');
              },
            )],
        title: const Text('Productos'),
        ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_to_photos_rounded),

        onPressed: () {
          productService.selectedProduct = Product(
            descripcion: '',
            precio: 0
            );
          Navigator.pushNamed(context, 'product');
        },
      ),
      
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: productList.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          
          child: GestureDetector(
            onTap: () {
              productService.selectedProduct = productService.products[i].copy();
              Navigator.pushNamed(context, 'product');

              },  
            child: ProductCard(producto: productList[i]),
            ),
        ),
        ),
    );
  } 
}
