// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

class Product {
    Product({
        this.id,
        required this.descripcion,
        this.imagen,
        required this.precio,
    });
    String? id;
    String descripcion;
    String? imagen;
    int precio;
    

     factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        descripcion: json["descripcion"],
        imagen: json["imagen"],
        precio: json["precio"],
        id: json["id"],
    );
 
    Map<String, dynamic> toMap() => {
        "descripcion": descripcion,
        "imagen": imagen,
        "precio": precio, 
    };
}

