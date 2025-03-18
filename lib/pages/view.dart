import 'package:flutter/material.dart';
import 'package:my_bank/pages/account.dart';
import 'package:my_bank/pages/discover.dart';
import 'package:my_bank/pages/home.dart';

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

  int page = 0;

  // page controller
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: page == 0
            ? AppBar(
                title: Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
