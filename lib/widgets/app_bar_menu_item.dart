import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AppBarMenuItem extends StatelessWidget {
  const AppBarMenuItem({
    Key? key,
    required this.title,
    required this.route,
  }) : super(key: key);

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: InkWell(
        child: Text(
          title,
          style: const TextStyle(color: color),
        ),
        onTap: () => Beamer.of(context).beamToNamed(route),
      ),
    );
  }
}
