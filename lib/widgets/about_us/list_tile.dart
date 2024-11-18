import 'package:flutter/material.dart';

class ListTileAboutUs extends StatelessWidget {
  final icon;
  final direction;
  final value;

  const ListTileAboutUs({
    super.key,
    required this.direction,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        value,
        textDirection: direction,
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.left,
      ),
      leading: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
