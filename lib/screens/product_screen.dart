import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/services/product_service.dart';
import 'package:shop_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    final selectedProduct = productService.selectedProduct;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
      
      
            Stack(
              children: [
                ProductImage(url: selectedProduct.imagen,),
                backButton(context),
                cameraButton(),
              ],
            ),
            const SizedBox(height: 10,),
            ProductForm(descripcion: selectedProduct.descripcion, precio: selectedProduct.precio,)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: (){}
        )
      );
  }

  Positioned cameraButton() {
    return Positioned(
          top: 20,
          right: 20,
          child: IconButton(
            onPressed: (){},
            icon: const Icon(Icons.camera_alt_rounded, size: 30,)));
  }

  Positioned backButton(BuildContext context) {
  
    return Positioned(
          top: 20,
          left: 20,
          child: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back_ios, size: 30,)));
  }
}

class ProductForm extends StatelessWidget {
  final String? descripcion;
  final int? precio;

  const ProductForm({super.key, this.descripcion, this.precio});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: buildDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Descripción del artículo'
              ),
              initialValue: descripcion,
            ),

            const SizedBox(height: 30,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Precio',
                hintText: '\$99.99'
              ),
              initialValue: '\$$precio',
            ),
            const SizedBox(height: 30,),
            SwitchListTile.adaptive(
              title: const Text('Disponible'),
              value: true, 
              onChanged: (value){}
              ),
            
          ],
        ),
      ),
    );
  }

  BoxDecoration buildDecoration() => const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black38,
        blurStyle: BlurStyle.outer,
        blurRadius: 2,
        spreadRadius: 0.1,
      )
    ]
  );
}