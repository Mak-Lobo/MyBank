import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_bank/pages/view.dart';
import 'package:my_bank/pages/manage_account/login.dart';
import 'package:my_bank/pages/manage_account/register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service_control/user_control.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // getting configurations from file
  final config = await rootBundle.loadString('configurations/main.json');
  Map configJson = jsonDecode(config);

  // initializing Supabase
  await Supabase.initialize(
      url: configJson['SUPERBASE_URL'],
      anonKey: configJson['SUPERBASE_API_KEY']);

  // 'UserControl' singleton
  GetIt.instance.registerSingleton<UserControl>(UserControl());

  // 'SharedPreferences' singleton
  final prefs = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(prefs);

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
