import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/screens.dart';
import 'package:shop_app/screens/singup_screen.dart';
import 'package:shop_app/services/firebase_auth_service.dart';
import 'package:shop_app/services/product_service.dart';

import 'theme/app_theme.dart';

class MyHttpOverrides extends HttpOverrides {
@override
HttpClient createHttpClient(SecurityContext? context) {
return super.createHttpClient(context)
  ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true; }}
      
void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const AppState());
  }


class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => FirebaseAuthService())
      ],
      child: const MyApp(),
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'home'      : (_) => const HomeScreen(),
        'product'   : (_) => const ProductScreen(),
        'login'     : (_) => const LoginScreen(),
        'singup'    : (_) => const SingUpScreen()
      },
      theme: AppTheme().appTheme,
    );
  }
}