import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_bank/custom_widgets/cards.dart';
import 'package:my_bank/custom_widgets/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Supabase.instance.client.auth.onAuthStateChange.listen((AuthState data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        print('User signed in: ${session.user.email}');
      } else if (event == AuthChangeEvent.signedOut) {
        print('User signed out');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isOrietationLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return (isOrietationLandscape)
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                accountBalance(),
                cardCarousel(),
                moneyTransactionButtons(),
                accountSection()
              ],
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              accountBalance(),
              cardCarousel(),
              moneyTransactionButtons(),
              accountSection()
            ],
          );
  }

  // account balance view
  Widget accountBalance() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
          width: 2.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Account number',
                  style: Theme.of(context).textTheme.bodySmall),
              Text(
                '00231782109',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Account balance',
                      style: Theme.of(context).textTheme.bodySmall),
                  Text('2000',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w500))
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.visibility_rounded),
              )
            ],
          )
        ],
      ),
    );
  }

  // carousel
  Widget cardCarousel() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: CarouselSlider(
        items: const [Card1(), Card2(), Card3()],
        options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 750),
          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
          autoPlayInterval: const Duration(seconds: 3),
          enlargeCenterPage: true,
        ),
      ),
    );
  }

  // money transaction buttons
  Widget moneyTransactionButtons() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 2.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CustomButton(
              icon: Icon(Icons.send_rounded),
              textFeature: 'Send money',
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, 'chart');
              },
              icon: const Icon(Icons.show_chart_rounded),
              textFeature: 'Transaction charts',
            ),
            const CustomButton(
              icon: Icon(Icons.payments_rounded),
              textFeature: 'Pay bills',
            ),
            const CustomButton(
              icon: Icon(Icons.send_to_mobile),
              textFeature: 'Mobile money',
            ),
          ],
        ),
      ),
    );
  }

  Widget accountSection() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.inversePrimary,
            width: 2.5,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              icon: FaIcon(FontAwesomeIcons.wallet),
              textFeature: 'My cards',
            ),
            CustomButton(
              icon: FaIcon(FontAwesomeIcons.moneyCheck),
              textFeature: 'My loans',
            ),
            CustomButton(
                icon: Icon(FontAwesomeIcons.bullseye), textFeature: 'My goals')
          ],
        ),
      ),
    );
  }
}
