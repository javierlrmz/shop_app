import 'dart:io';

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
        child: getImage(url)
        
      ),
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    

  );

  Widget getImage( String? picture) {

    if ( picture == null ) {
      return const Image(
            image: AssetImage('placeholder.jpg'),
            fit: BoxFit.cover,
            );
    }

    if ( picture.startsWith('http') ) {
      return FadeInImage(
        fit: BoxFit.cover,
        placeholder: const AssetImage('placeholder.jpg'),
        image: NetworkImage(url!));
    }
        
    return Image.file(
      File( picture),
      fit: BoxFit.cover
    );
  }
}