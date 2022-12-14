import 'package:flutter/material.dart';
import 'package:shop_app/models/products_model.dart';

class ProductCard extends StatelessWidget {

  final Product producto;

  const ProductCard({Key? key, required this.producto}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom:10 ),
      child: Stack(
        children: [
          // Card
          Container(
            
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  
                )
              ],
            ),
            width: 360,
            height: 360,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: producto.imagen == null 
              ? const Image(
                fit: BoxFit.cover,
                image: AssetImage('placeholder.jpg')
                )
              : FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage('placeholder.jpg'),
                image: NetworkImage('${producto.imagen}'),
              ),
            )
          ),
          
          //Price
          Container(
            decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: Colors.black,
            ),
            width: 80,
            height: 40,
            
            child: Center(
              child: Text('\$ ${producto.precio}', style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            )
          ),

          // Descripción
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              
              decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.black,
              ),
              width: 300,
              height: 40,
              
              child: Center(
                
                child: Text(producto.descripcion, style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            )
            ),
          )
        ],
      ),
    );
  }
}