import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:matterofmovement/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

import './app_bar_menu_item.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  final String id;

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;

    return AppBar(
      automaticallyImplyLeading: mediaWidth < 750 ? true : false,
      iconTheme: IconThemeData(
        color: isDarkMode ? thirdColor : secondaryColor,
      ),
      //backgroundColor: thirdColor,
      title: Center(
        child: mediaWidth < 750
            ? InkWell(
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                  height: 50.0,
                ),
                onTap: () => Beamer.of(context).beamToNamed('/home'),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBarMenuItem(
                        title: 'Home',
                        function: () => Beamer.of(context).beamToNamed('/home'),
                      ),
                      AppBarMenuItem(
                        title: 'Favourites',
                        function: () =>
                            Beamer.of(context).beamToNamed('/favourites'),
                      ),
                      AppBarMenuItem(
                        title: 'About',
                        function: () =>
                            Beamer.of(context).beamToNamed('/about'),
                      ),
                      AppBarMenuItem(
                        title: 'Book List',
                        function: () =>
                            Beamer.of(context).beamToNamed('/books'),
                      ),
                      AppBarMenuItem(
                        title: 'Subscribe',
                        function: () => Beamer.of(context).beamToNamed('/auth'),
                      ),
                      AppBarMenuItem(
                        title: isDarkMode ? 'Light Mode' : 'Dark Mode',
                        function: () => darkModeProvider.toggleDarkMode(),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      height: 50.0,
                    ),
                    onTap: () => Beamer.of(context).beamToNamed('/home'),
                  ),
                ],
              ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () => Beamer.of(context).beamToNamed('/about'),
            icon: const Icon(Icons.info),
            color: isDarkMode ? thirdColor : secondaryColor,
          ),
        ),
      ],
    );
  }
}
