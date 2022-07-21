import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/services/product_service.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
  
    final productService = Provider.of<ProductService>(context);
    final List productList = productService.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: const Icon(Icons.add_to_photos_rounded),
        onPressed: () => Navigator.pushNamed(context, 'product'),
      ),
      
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: productList.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: ProductCard(producto: productList[i]),
        ),
        ),
    );
  }
}

