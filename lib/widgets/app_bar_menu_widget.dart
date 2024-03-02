import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/favourite_provider.dart';
import '/constants.dart';

class AppBarMenuWidget extends StatelessWidget {
  final String title;
  final dynamic onTap;

  const AppBarMenuWidget({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;
    return Padding(
      padding: kPadding,
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(color: isDarkMode ? thirdColor : color),
        ),
      ),
    );
  }
}
