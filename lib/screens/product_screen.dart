import 'package:flutter/material.dart';
import 'package:shop_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          const ProductImage(),
          
          const Positioned(child: BackButton()),

          Positioned(
            child: IconButton(
              onPressed: (){},
              icon: const Icon(Icons.camera_alt_rounded)))
        ],
      )
      );
  }
}