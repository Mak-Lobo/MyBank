import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_bank/custom_widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        accountBalance(),
        cardCarousel(),
      ],
    );
  }

  // account balance view
  Widget accountBalance() {
    return Row(
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
        ),
      ),
    );
  }
}
