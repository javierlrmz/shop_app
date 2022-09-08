import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/screens.dart';
import 'package:shop_app/screens/singup_screen.dart';
import 'package:shop_app/services/firebase_auth_service.dart';
import 'package:shop_app/services/product_service.dart';

import 'firebase_options.dart';
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

  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCwek9MgZ2ygsbBAkGm8TdnYDfsXMqXzlY',
        appId: '1:451218686097:android:758959d01b0cf077903f30',
        messagingSenderId: '451218686097',
        projectId: 'mygymapp-6238a',
        authDomain: 'mygymapp-6238a.firebaseapp.com',
        databaseURL: 'https://mygymapp-6238a-default-rtdb.firebaseio.com',
        storageBucket: 'mygymapp-6238a.appspot.com',
      ),
    );

  runApp( AppState());
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

  String get name => 'foo';

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Initialized default app $app');
  }

  Future<void> initializeDefaultFromAndroidResource() async {
    if (defaultTargetPlatform != TargetPlatform.android || kIsWeb) {
      print('Not running on Android, skipping');
      return;
    }
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app from Android resource');
  }

  Future<void> initializeSecondary() async {
    FirebaseApp app = await Firebase.initializeApp(
      name: name,
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('Initialized $app');
  }

  void apps() {
    final List<FirebaseApp> apps = Firebase.apps;
    print('Currently initialized apps: $apps');
  }

  void options() {
    final FirebaseApp app = Firebase.app();
    final options = app.options;
    print('Current options for app ${app.name}: $options');
  }

  Future<void> delete() async {
    final FirebaseApp app = Firebase.app(name);
    await app.delete();
    print('App $name deleted');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: FirebaseAuth.instance.currentUser?.uid != null
      ? 'home' : 'login',  
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