import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/favourite_provider.dart';
import '/constants.dart';
import 'app_bar_menu_widget.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWidget({
    super.key,
    required this.id,
  });
  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  final String id;

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;

    return AppBar(
      automaticallyImplyLeading: mediaWidth < 750 ? true : false,
      iconTheme: IconThemeData(
        color: isDarkMode ? thirdColor : secondaryColor,
      ),
      centerTitle: true,
      title: mediaWidth < 750
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
                    AppBarMenuWidget(
                      title: 'Home',
                      onTap: () => Beamer.of(context).beamToNamed('/home'),
                    ),
                    AppBarMenuWidget(
                      title: 'Favourites',
                      onTap: () =>
                          Beamer.of(context).beamToNamed('/favourites'),
                    ),
                    AppBarMenuWidget(
                      title: 'About',
                      onTap: () => Beamer.of(context).beamToNamed('/about'),
                    ),
                    AppBarMenuWidget(
                      title: isDarkMode ? 'Light Mode' : 'Dark Mode',
                      onTap: () => darkModeProvider.toggleDarkMode(),
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
    );
  }
}
