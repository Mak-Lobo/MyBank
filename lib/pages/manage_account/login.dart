import 'package:flutter/material.dart';

import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:text_divider/text_divider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double? width, height;

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
                    child: pinColumn(),
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
        Text('Use PIN Number', style: Theme.of(context).textTheme.bodySmall),
        PinInputTextField(
          pinLength: 4,
          decoration: CirclePinDecoration(
            strokeColorBuilder:
                FixedColorBuilder(Theme.of(context).colorScheme.primary),
            obscureStyle: ObscureStyle(
              obscureText: '*',
              isTextObscure: true,
            ),
          ),
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
}
