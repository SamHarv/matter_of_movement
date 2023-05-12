import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:matterofmovement/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

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
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;
    return Padding(
      padding: kPadding,
      child: InkWell(
        child: Text(
          title,
          style: TextStyle(color: isDarkMode ? thirdColor : color),
        ),
        onTap: () => Beamer.of(context).beamToNamed(route),
      ),
    );
  }
}
