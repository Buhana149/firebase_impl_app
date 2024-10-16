import 'package:firebase_impl_app/home_page.dart';
import 'package:firebase_impl_app/register_pages/login_view.dart';
import 'package:firebase_impl_app/register_pages/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login' : (context) => const LoginView(),
        '/register' : (context) => const RegisterView(),
      },
    );
  }
}
