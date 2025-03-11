import 'package:flutter/material.dart';
import 'package:my_bank/pages/view.dart';
import 'package:my_bank/pages/manage_account/login.dart';
import 'package:my_bank/pages/manage_account/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final textTheme = const TextTheme(
      labelLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Poppins',
      ),
      bodySmall: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w300,
        fontFamily: 'Poppins',
      ),
      displayMedium: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: textTheme,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: textTheme,
      ),
      themeMode: ThemeMode.light,
      routes: {
        '/': (context) => const MainView(),
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
      },
      initialRoute: 'login',
    );
  }
}
