// ignore_for_file: depend_on_referenced_packages

import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:text_divider/text_divider.dart';

import '../../service_control/user_control.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? width, height;
  TextEditingController? pinController, emailController;
  late final LocalAuthentication auth;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Map<String, dynamic> cachedMap = {}; // holds the cached data
  bool isCached = false; // flag to check if data is cached
  bool canFingerPrint = false; // using fingerprint to login

  final sharedPrefs = GetIt.instance.get<SharedPreferences>();

  // initializing variables upon page initialzation
  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    pinController = TextEditingController();
    emailController = TextEditingController();
  }

  // disposing controllers
  @override
  void dispose() {
    pinController!.dispose();
    emailController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'Login in to your account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.inversePrimary,
                      border: Border.all(
                        style: BorderStyle.solid,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: height! * 0.25,
                        child: Form(
                          key: loginFormKey,
                          child: pinColumn(),
                        ),
                      ),
                      TextDivider(
                        text: const Text('OR'),
                        thickness: 5,
                        direction: Direction.horizontal,
                        size: 10,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(
                        height: height! * 0.3,
                        child: fingerprintColumn(),
                      ),
                      linkToRegister(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // pin column
  Widget pinColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Use PIN Number and email',
            style: Theme.of(context).textTheme.bodySmall),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                labelStyle: Theme.of(context).textTheme.bodySmall,
                prefixIcon: Icon(
                  Icons.email,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              validator: (_email) {
                RegExp emailFormat =
                    RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                if (_email!.isEmpty || !emailFormat.hasMatch(_email)) {
                  return 'Invalid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            PinInputTextField(
              controller: pinController,
              pinLength: 6,
              decoration: CirclePinDecoration(
                strokeColorBuilder:
                    FixedColorBuilder(Theme.of(context).colorScheme.primary),
                obscureStyle: ObscureStyle(
                  obscureText: '*',
                  isTextObscure: true,
                ),
                strokeWidth: 2,
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 20),
            loginButton(),
          ],
        ),
      ],
    );
  }

  // fingerprint column
  Widget fingerprintColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Use fingerprint',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: (canFingerPrint == true) ? redirectToHome : noFingerPrintLogin,
          child: CircleAvatar(
            radius: 75,
            backgroundColor: Colors.transparent,
            child: Image(
              image: const AssetImage(
                'images/fingerprint.png',
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  // registration link
  Widget linkToRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Don\'t have an account?',
            style: Theme.of(context).textTheme.bodySmall),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'register');
          },
          child: Text(
            'Click here to register',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
          ),
        )
      ],
    );
  }

  // login with fingerprint
  void loginWithBiometrics() async {
    final bool biometricEnabled = await auth.isDeviceSupported();
    final bool canAuthenticateWithBiometrics =
        await auth.canCheckBiometrics || biometricEnabled;

    if (canAuthenticateWithBiometrics) {
      if (cachedMap.isNotEmpty && isCached == true) {
        await auth.authenticate(
          localizedReason: 'Use biometrics to login',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Use biometrics to login',
              cancelButton: 'Cancel',
            ),
            IOSAuthMessages(
              cancelButton: 'Cancel',
            ),
          ],
        );
      } else {
        noFingerPrintLogin();
      }
    }
  }

  void noFingerPrintLogin() {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 4),
      alignment: Alignment.bottomCenter,
      title: const Text(
          'Kindly register first or login in with email and pin if already registered.'),
      type: const ToastificationType.custom(
          'Kindly register first or login in with email and pin if already registered.',
          Colors.red,
          Icons.error_rounded),
      style: ToastificationStyle.flatColored,
    );
  }

  //login button using email and pin/password
  Widget loginButton() {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: TextButton(
          onPressed: redirectToHome,
          child: Text(
            'Login now',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        ),
      ),
    );
  }

  // cached data
  Future<void> cachedData() async {
    // saving data to shared preferences
    if (emailController!.text.isNotEmpty && pinController!.text.isNotEmpty) {
      // if the cached data is empty and data is available
      final userControl = UserControl();
      final confirmed = await userControl.confirmUser(
          emailController!.text, int.parse(pinController!.text));

      if (confirmed == true) {
        sharedPrefs.setString('email', emailController!.text);
        sharedPrefs.setInt('pin', int.parse(pinController!.text));
      } else {
        incorrectCredentials();
      }
    } else {
      developer.log('Shared preferences is empty. => $sharedPrefs');
      toastification.show(
        style: ToastificationStyle.simple,
        description: const Text('Unable to get store persistent data'),
      );
    }

    // set preferences to map variable
    setState(() {
      cachedMap['email'] = sharedPrefs.getString('email');
      cachedMap['pin'] = sharedPrefs.getInt('pin');

      print(cachedMap);
      isCached = true;
      canFingerPrint = true;
    });
  }

  // redirect to home page after login
  void redirectToHome() async {
    if (emailController!.text.isNotEmpty && pinController!.text.isNotEmpty) {
      await cachedData();

      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController!.text,
        password: pinController!.text,
      );
      homeNavigate();
    } else if (canFingerPrint == true) {
      loginWithBiometrics();
      await Supabase.instance.client.auth.signInWithPassword(
        email: cachedMap['email'],
        password: cachedMap['pin'].toString(),
      );
      Future.delayed(const Duration(seconds: 2), () {
        toastification.show(
            style: ToastificationStyle.flatColored,
            type: const ToastificationType.custom(
                'Login successful', Colors.blue, Icons.check_circle_rounded));
      });
      homeNavigate();
    } else {
      incorrectCredentials();
      print(cachedMap);
    }
  }

  // incorrect credentials
  void incorrectCredentials() {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      style: ToastificationStyle.flatColored,
      title: const Text('Incorrect details'),
      type: const ToastificationType.custom(
        'Incorrect credentials',
        Colors.red,
        Icons.error_rounded,
      ),
    );
  }

  void homeNavigate() {
    Navigator.popAndPushNamed(context, '/');
  }
}
