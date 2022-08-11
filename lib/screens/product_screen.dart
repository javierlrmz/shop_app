import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/products_model.dart';
import 'package:shop_app/services/product_form_service.dart';
import 'package:shop_app/services/product_service.dart';
import 'package:shop_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);
    final selectedProduct = productService.selectedProduct;
    
    return ChangeNotifierProvider(create: (_) => ProductFormService(productService.selectedProduct),
    child: _ProductScrenBody(selectedProduct: selectedProduct));
  }
}

class _ProductScrenBody extends StatelessWidget {
  const _ProductScrenBody({
    Key? key,
    required this.selectedProduct,
  }) : super(key: key);

  final Product selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
        
              Stack(
                children: [
      
                  ProductImage(url: selectedProduct.imagen,),
      
                  Positioned(
                    top: 20,
                    left: 20,
                    child: IconButton(
                      onPressed: (){Navigator.pop(context);},
                      icon: const Icon(Icons.arrow_back_ios, size: 30,))),
                  
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.camera_alt_rounded, size: 30,)))
      
                ],
              ),
              const SizedBox(height: 10,),
              const ProductForm()
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: (){}
        )
      );
  }
}

class ProductForm extends StatelessWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final productform = Provider.of<ProductFormService>(context);
  final product = productform.product; 
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
              initialValue: product.descripcion
            ),

            const SizedBox(height: 30,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Precio',
                hintText: '\$99.99'
              ),
              initialValue: '\$${product.precio}',
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