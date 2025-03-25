import 'package:flutter/material.dart';
import 'package:my_bank/pages/account.dart';
import 'package:my_bank/pages/discover.dart';
import 'package:my_bank/pages/home.dart';

import '../service_control/user_control.dart';
import '../models/users_register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // navigation buttons
  List<Widget> destinations = const [
    HomePage(),
    AccountPage(),
    DiscoverPage(),
  ];
  final userControl = GetIt.instance.get<UserControl>();
  Map<String, dynamic> accountDetails = {};

  int page = 0;

  // page controller
  final pageController = PageController(initialPage: 0);

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
  void initState() {
    super.initState();
    fetchAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: page == 0
            ? AppBar(
                title: Text(
                  "Welcome, ${accountDetails['first_name']}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).colorScheme.primary,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    color: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () {},
                  ),
                ],
              )
            : null,
        body: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            setState(() {
              page = index;
            });
          },
          children: destinations,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
          unselectedItemColor: Theme.of(context).colorScheme.surface,
          currentIndex: page,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Account',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Discover',
            ),
          ],
        ),
      ),
    );
  }
}
