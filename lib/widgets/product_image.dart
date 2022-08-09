import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: buildDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const FadeInImage(
        fit: BoxFit.cover,
        placeholder: NetworkImage('https://thumbs.dreamstime.com/b/ninguna-imagen-de-la-u%C3%B1a-del-pulgar-placeholder-para-los-foros-blogs-y-las-p%C3%A1ginas-web-148010362.jpg'),
        image: NetworkImage('https://thumbs.dreamstime.com/b/ninguna-imagen-de-la-u%C3%B1a-del-pulgar-placeholder-para-los-foros-blogs-y-las-p%C3%A1ginas-web-148010362.jpg'),),
      ),
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    

  );
}