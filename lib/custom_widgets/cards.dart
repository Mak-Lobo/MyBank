import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: NetworkImage(
                'https://www.mypeoples.bank/uploads/blog/fcf7470f5e608060f48a9cd00f83c589.jpg'),
            opacity: 0.6,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Get loans at affordable rates to grow your business.',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: NetworkImage(
                'https://www.processmaker.com/wp-content/uploads/2019/02/people-at-bank-iStock_0.jpg'),
            opacity: 0.6,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'We always appreciate our loyal customers\' feedback and suggestions.',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class Card3 extends StatelessWidget {
  const Card3({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).colorScheme.inversePrimary,
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: NetworkImage(
                'https://media.istockphoto.com/id/1415838837/photo/row-of-people-to-the-bank-teller-cashier-defocused-background.jpg?s=612x612&w=0&k=20&c=s6b2aaMgmom79LYlIbHzD0le8vhZnaGlnE954X4rZ-Y='),
            opacity: 0.6,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            'Bank with us today and take your business to the next level.',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
