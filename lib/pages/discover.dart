import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Discover page under construction!',
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
