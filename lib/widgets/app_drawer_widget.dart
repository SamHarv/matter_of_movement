import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/favourite_provider.dart';
import '/constants.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  Widget buildListTile(String title, IconData icon, dynamic tapHandler,
      Color iconColour, Color textColour) {
    return ListTile(
      //tileColor: thirdColor,
      leading: Icon(
        icon,
        size: 26,
        color: iconColour,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          color: textColour,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;
    Color paleBlue = Colors.blueAccent;

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Image.asset(isDarkMode ? logo : fullLogo),
            ),
            const Divider(),
            buildListTile(
              'Home',
              Icons.home,
              () => Beamer.of(context).beamToNamed('/home'),
              isDarkMode ? paleBlue : color,
              isDarkMode ? thirdColor : secondaryColor,
            ),
            const Divider(),
            buildListTile(
              'Favourites',
              Icons.star,
              () => Beamer.of(context).beamToNamed('/favourites'),
              isDarkMode ? paleBlue : color,
              isDarkMode ? thirdColor : secondaryColor,
            ),
            const Divider(),
            buildListTile(
              'About',
              Icons.info,
              () => Beamer.of(context).beamToNamed('/about'),
              isDarkMode ? paleBlue : color,
              isDarkMode ? thirdColor : secondaryColor,
            ),
            const Divider(),
            buildListTile(
              isDarkMode ? 'Light Mode' : 'Dark Mode',
              isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              () => darkModeProvider.toggleDarkMode(),
              isDarkMode ? paleBlue : color,
              isDarkMode ? thirdColor : secondaryColor,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
