import 'package:flutter/material.dart';
import 'package:matterofmovement/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AppBarMenuItem extends StatelessWidget {
  const AppBarMenuItem({
    Key? key,
    required this.title,
    required this.function,
  }) : super(key: key);

  final String title;
  final dynamic function;

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;
    return Padding(
      padding: kPadding,
      child: InkWell(
        onTap: function,
        child: Text(
          title,
          style: TextStyle(color: isDarkMode ? thirdColor : color),
        ),
      ),
    );
  }
}
