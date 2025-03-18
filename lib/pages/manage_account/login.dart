import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:text_divider/text_divider.dart';

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
  Map passedData = {};

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    pinController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Login in to your account',
              style: Theme.of(context).textTheme.labelLarge,
            ),
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
                    height: height! * 0.2,
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
          onTap: () {},
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
      final bool authenticated = await auth.authenticate(
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
    }
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
          onPressed: () {},
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
  void cachedData(BuildContext context) {
    // getting pushed data from register page
    passedData = passedData.isEmpty
        ? ModalRoute.of(context)!.settings.arguments as Map
        : passedData;
  }
}
