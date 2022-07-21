import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: const [
          // FONDO
          _Background(),
          // SlingeChild
          ScrollArea(),
        ]
      ),
    );
  }
}

class ScrollArea extends StatelessWidget {
  const ScrollArea({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            
            SizedBox(height: mediaSize.height * 0.1),
            // TARJETA
            ElasticIn(child: _LoginCard()),

            const SizedBox(height: 30),
            // BOTON INICIAR SESIÓN
            ElasticIn(child: const SingUpButton()),

            SizedBox(height: mediaSize.height * 0.1),
          ],
        )
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  final mediaSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: mediaSize.width,
        height: mediaSize.height * 0.46,
        decoration: BoxDecoration(
          boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 1
                    )
                  ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
        ),
        child: _SingForm(),
      ),
    );
  }
}

class _SingForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                const SizedBox(height:10),
                const Icon(Icons.person_pin, size: 100),

                const Text('Iniciar Sesión', 
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                // CORREO
                TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email),
                    iconColor: Colors.lightBlue.shade500,
                    labelText: 'Correo',
                    helperText: 'Introduzca su correo electronico personal',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 10, color: Colors.black54)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(width: 3, color: Colors.lightBlue.shade500)),
                    
                  ),
                ),

                const SizedBox(height: 20),

                // CONTRASEÑA
                TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock_outlined),
                    iconColor: Colors.lightBlue.shade500,
                    helperText: 'Ingrese 8 carácteres o más',
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 10, color: Colors.black54)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(width: 3, color: Colors.lightBlue.shade500)),
                    
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextButton(
                      style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: (){},
                      child: const Text('¿Olvidaste tu contraseña?')
                      ),
                    const Text('/'),
                    TextButton(
                      style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: (){},
                      child: const Text('Crear cuenta')
                    ),                  ],
                ),

                
              ],
            ))
        ],
      ),
    
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          colors: [
            Colors.lightBlue.shade500,
            Colors.lightBlue.shade700,
          ]
        )
      ),
    );
  }
}

class SingUpButton extends StatelessWidget {
  const SingUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        
        Navigator.pushReplacementNamed(context, 'home');
        },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1
              )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text(
              'Iniciar sesión',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,


            ),),
          ),
        ),
      )
      );
  }
}