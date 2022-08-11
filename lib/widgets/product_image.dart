import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  
  final String? url;

  const ProductImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: buildDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: url == null 
        ? const Image(
          image: AssetImage('placeholder.jpg'),
          fit: BoxFit.cover,
          ) 
        : FadeInImage(
        fit: BoxFit.cover,
        placeholder: const AssetImage('placeholder.jpg'),
        image: NetworkImage(url!),),
      ),
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    

  );
}