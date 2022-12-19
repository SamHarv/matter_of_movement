import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

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
    const Color primaryColor = Color.fromARGB(255, 0, 74, 173);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        child: Text(
          title,
          style: const TextStyle(color: primaryColor),
        ),
        onTap: () => context.go(route),
      ),
    );
  }
}
