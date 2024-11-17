import 'package:financial_management/firebase_options.dart';
import 'package:financial_management/src/ui/screens/login/login.dart';
import 'package:financial_management/src/ui/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  await Future.delayed(const Duration(milliseconds: 100)); // Small delay
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Financial Management',
        theme: customTheme,
        home: const LoginScreen());
  }
}
