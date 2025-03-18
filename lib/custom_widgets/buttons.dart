import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final dynamic icon;
  final String textFeature;

  const CustomButton(
      {super.key, required this.icon, required this.textFeature});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: icon,
            color: Theme.of(context).colorScheme.primary,
            iconSize: 30,
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            textFeature,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
            softWrap: true,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
