import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/extensions/validate_extension.dart';
import 'package:shop_app/services/firebase_auth_service.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: const [
          // FONDO
          _Background(),
          // SlingeChild ---- PANTALLA 
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
            // ---------------CARD----------------------------
            ElasticIn(child: _LoginCard()),

            const SizedBox(height: 30),
            // BOTON INICIAR SESIÓN

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
        height: mediaSize.height * 0.6,
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
//==================== SCREEN CARD ===============================
class _SingForm extends StatefulWidget {

  @override
  State<_SingForm> createState() => _SingFormState();
}

class _SingFormState extends State<_SingForm> {
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<FirebaseAuthService>(context);

    final formKey = GlobalKey<FormState>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height:20),
                const Icon(Icons.person_pin, size: 100,),
                const Text('Crear cuenta', 
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                // CORREO
                CustomFormField(
                  helperText: 'Email@email.com',
                  icon: Icons.email,
                  labelText: 'Ingrese su correo electronico',
                  onChanged: ( value ){

                    authService.emailAddress = value;
                    print(authService.emailAddress);
                    
                  },
                  validator: (value){
                    if (!value!.isValidEmail) {
                      return 'Ingresa un correo válido';
                    }
                    return null;
                  },
                  
                ),
                const SizedBox(height: 20),
                // CONTRASEÑA
                CustomFormField(
                  helperText: '******',
                  icon: Icons.lock_open_sharp,
                  labelText: 'Ingrese su contraseña',
                  onChanged: ( value ){
                    authService.password = value;
                    print('FIREBASE');
                    print(authService.password);
                  },
                  validator: (value){
                    if (!value!.isValidPassword) {
                      return 'Ingrese una contraseña de almenos 8 caracteres';
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 10),
                const ForgetPassWidget(),
                // const SizedBox(height: 20),
                
                SingUpButton(
                  onPressed: () { 
                    if (formKey.currentState!.validate()) {
                      // print('${formKey.currentState!.validate()}');
                      authService.createAccount();
                      
                      Navigator.pushReplacementNamed(context, 'home');

                    }
                   },
                )
                
              ],
            ))
        ],
      ),
    
    );
  }
}

class ForgetPassWidget extends StatelessWidget {
  const ForgetPassWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          child: const Text('Ya tengo cuenta')
        ),                  ],
    );
  }
}

class CustomFormField extends StatelessWidget {

  final IconData icon;
  final String labelText;
  final String helperText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  
  const CustomFormField({Key? key, 
    required this.icon,
    required this.labelText,
    required this.helperText,
    this.inputFormatters,
    this.validator, this.onChanged
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        icon: Icon(icon),
        iconColor: Colors.lightBlue.shade500,
        labelText: labelText,
        helperText: helperText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 10, color: Colors.black54)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(width: 3, color: Colors.lightBlue.shade500)),
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

  final void Function() onPressed;

  const SingUpButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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

