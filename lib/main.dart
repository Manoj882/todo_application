import 'package:flutter/material.dart';
import 'package:todo_application/theme/theme_data.dart';
import '/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import '/screens/login_screen.dart';
import '/screens/register_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.0
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: lightTheme(context),
    
      home:  LoginScreen(),
    );
  }
}

