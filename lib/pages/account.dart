import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../service_control/user_control.dart';
import '../custom_widgets/account_field.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Map<String, dynamic>? accountDetails;
  double? height;
  final userControl = UserControl();

  // initialization with account details
  @override
  void initState() {
    super.initState();
    fetchAccountDetails();
  }

  // fetch account details
  Future<void> fetchAccountDetails() async {
    final User? currentUser = Supabase.instance.client.auth.currentUser;

    if (currentUser != null) {
      final fetchedProfile =
          await userControl.getCurrentUserData(currentUser.email.toString());

      setState(() {
        accountDetails = fetchedProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Profile details', style: Theme.of(context).textTheme.titleLarge),
        accountBox(),
        logOutButton(),
      ],
    );
  }

  // account form
  Widget accountBox() {
    height = MediaQuery.of(context).size.height;
    return Container(
      height: height! * 0.5,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 2.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountField(
            label: 'First name',
            data: accountDetails?['first_name'] ?? 'N/A',
          ),
          AccountField(
            label: 'Last name',
            data: accountDetails?['last_name'] ?? 'N/A',
          ),
          AccountField(
            label: 'Email',
            data: accountDetails?['email'] ?? 'N/A',
          ),
          AccountField(
            label: 'Phone number',
            data: accountDetails?['phone_number']?.toString() ?? '000-000-0000',
          ),
          AccountField(
            label: 'Created at',
            data: accountDetails?['created_at'].toString() ?? 'N/A',
          ),
        ],
      ),
    );
  }

  // log out button
  Widget logOutButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        await userControl.userSignOut();
        Navigator.popAndPushNamed(context, 'login');
      },
      label: const Text('Log out'),
      icon: const Icon(Icons.logout),
    );
  }
}
