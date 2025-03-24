import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../service_control/user_control.dart';
import 'package:get_it/get_it.dart';
import '../../models/users_register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double? width, height;
  bool isHidden = true;
  late TextEditingController lastNameController,
      firstNameController,
      emailController,
      phoneNumberController,
      pinController;
  UserControl? userControl;
  Color? borderColor, snackbarColor;

  final supabase = Supabase.instance.client;

  void initState() {
    super.initState();
    userControl = GetIt.instance.get<UserControl>();

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    pinController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    borderColor = Theme.of(context).colorScheme.primary;
    snackbarColor = Theme.of(context).colorScheme.secondary;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to MyBank.',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 40,
                ),
                Text('Join us today by registering for our services.',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(decoration: TextDecoration.underline)),
                const SizedBox(
                  height: 30,
                ),
                registrationForm(context),
                linkToLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registrationForm(BuildContext context) {
    return Container(
      height: height! * 0.6,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.inversePrimary,
        border: Border.all(
          style: BorderStyle.solid,
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            nameRow(),
            TextFormField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary),
                ),
                prefixIcon: const Icon(Icons.phone),
              ),
              validator: (_phoneNumber) {
                RegExp numberFormat = RegExp(r'^[0-9]+$');
                if (_phoneNumber!.isEmpty ||
                    !numberFormat.hasMatch(_phoneNumber)) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  prefixIcon: const Icon(Icons.email_rounded)),
              validator: (_email) {
                RegExp emailFormat =
                    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                if (_email!.isEmpty || !emailFormat.hasMatch(_email)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: pinController,
              decoration: InputDecoration(
                labelText: 'PIN number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                prefixIcon: const Icon(Icons.password_rounded),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: (isHidden)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              obscureText: isHidden,
              validator: (_pin) {
                RegExp pinFormat = RegExp(r'^[0-9]');
                if (_pin!.isEmpty || !pinFormat.hasMatch(_pin)) {
                  return 'Please enter your PIN number';
                } else if (_pin.length < 6) {
                  return 'PIN number must be at least 6 digits';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Re-enter PIN number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                prefixIcon: const Icon(Icons.password_rounded),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: (isHidden)
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              obscureText: isHidden,
              validator: (_pin) {
                RegExp pinFormat = RegExp(r'^[0-9]');
                if (_pin!.isEmpty || !pinFormat.hasMatch(_pin)) {
                  return 'Please enter your PIN number';
                }
                if (_pin != pinController.text) {
                  return 'PIN numbers do not match';
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.topRight,
              child: forgotPin(),
            ),
            register(context),
          ],
        ),
      ),
    );
  }

  // register button
  Widget register(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: TextButton(
          onPressed: registerUser,
          child: Text(
            'Register now',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        ),
      ),
    );
  }

  // login link
  Widget linkToLogin() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Already have an account?',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
          child: Text(
            'Click here to sign in!',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }

  // name row
  Widget nameRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: firstNameController,
          decoration: InputDecoration(
            labelText: 'First name',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        SizedBox(
          height: height! * 0.005,
        ),
        TextFormField(
          controller: lastNameController,
          decoration: InputDecoration(
            labelText: 'Last name',
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            prefixIcon: const Icon(Icons.person),
          ),
        ),
      ],
    );
  }

  // forgot pin link
  Widget forgotPin() {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Forgot PIN?',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  // register function
  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print('Clicked button');

      try {
        final userReg = await supabase.auth.signUp(
          email: emailController.text,
          password: pinController.text,
        );

        final Session? session = userReg.session;
        final User? user = session?.user;

        // pushing the registered person to the database
        RegisteredUser newUser = RegisteredUser(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phoneNumber: num.tryParse(phoneNumberController.text) ?? 0,
          pin: num.tryParse(pinController.text) ?? 0,
          createdAt: DateTime.now(),
        );

        await userControl!.createUser(newUser);

        // popup showing registration success
        SnackBar(
          content: const Text('Registration successful!'),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            side: BorderSide(
              color: borderColor!,
            ),
          ),
          elevation: 10,
          backgroundColor: snackbarColor,
        );

        Navigator.pushReplacementNamed(context, 'login');
      } on AuthException catch (e) {
        SnackBar(content: Text('${e.message}\nTry again to register.'));
      }
    }
  }
}
