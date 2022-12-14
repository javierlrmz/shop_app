import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    child: _ProductScrenBody(selectedProduct: selectedProduct, productService: productService,));
  }
}

class _ProductScrenBody extends StatelessWidget {

  final Product selectedProduct;
  final ProductService productService;

  const _ProductScrenBody({required this.selectedProduct, required this.productService});

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormService>(context);
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
                      icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.white,))),
                  
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.camera_alt_rounded, size: 30, color: Colors.white,)))
      
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
        child: const Icon(Icons.save),
        onPressed: () async {
          
          if ( !productForm.isValidForm()) return;
          
          FocusManager.instance.primaryFocus?.unfocus();

          await productService.saveOrCreateProduct(productForm.product);

        }
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
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: productform.formkey,
          child: Column(
            children: [
        
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descripci??n',
                  hintText: 'Descripci??n del art??culo'
                ),
                initialValue: product.descripcion,
                onChanged: ( value ) => product.descripcion = value,
                validator:  ( value ) {
                  if ( value == null || value.isEmpty) {
                    return 'La descripci??n es obligatoria';
                  }
                  return null;
                },
                
              ),
        
              const SizedBox(height: 30,),
        
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  hintText: '\$99.99'
                ),
                initialValue: '\$${product.precio}',
                onChanged: ( value ) {
                  if (double.tryParse(value) == null){
                    product.precio = 0;
                  } else {
                    product.precio = int.parse(value);
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        
                ],
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