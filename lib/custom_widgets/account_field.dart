import 'package:flutter/material.dart';

class AccountField extends StatelessWidget {
  final String label;
  final String data;

  const AccountField({required this.label, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: 2.5,
        ),
      ),
      child: ListTile(
        title: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                decoration: TextDecoration.underline,
              ),
        ),
        subtitle: Text(
          data,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
