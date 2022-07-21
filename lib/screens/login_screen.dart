import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Fondo azul
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.cyanAccent),
              ),

          // CARD
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: deviceSize.height,
                  
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
              )
            ],
          )
        ]
        ),
    );
  }
}

