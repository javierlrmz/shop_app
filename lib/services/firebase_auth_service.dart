import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FirebaseAuthService extends ChangeNotifier {
  
  var _emailAddress;

  get emailAddress => _emailAddress;

  set emailAddress(emailAddress) {
    _emailAddress = emailAddress;
  }
  var _password;

  get password => _password;

  set password(password) {
    _password = password;
  }
  
  Future createAccount() async {
    
    // final String emailAddress;

    // final String password;
    try {

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

    } catch (e) {
      print(e);
    }
    
  notifyListeners();
  }

}