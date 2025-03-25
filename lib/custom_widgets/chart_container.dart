import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Widget child;
  const ChartContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(5),
      child: child,
    );
  }
}