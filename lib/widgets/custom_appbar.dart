import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

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

    return AppBar(
      automaticallyImplyLeading: mediaWidth < 750 ? true : false,
      iconTheme: const IconThemeData(
        color: secondaryColor,
      ),
      backgroundColor: thirdColor,
      title: Center(
        child: mediaWidth < 750
            ? InkWell(
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                  height: 50.0,
                ),
                onTap: () => Beamer.of(context).beamToNamed('/'),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      AppBarMenuItem(
                        title: 'Home',
                        route: '/',
                      ),
                      AppBarMenuItem(
                        title: 'Favourites',
                        route: '/favourites',
                      ),
                      AppBarMenuItem(
                        title: 'About',
                        route: '/about',
                      ),
                      AppBarMenuItem(
                        title: 'Book List',
                        route: '/books',
                      ),
                      AppBarMenuItem(
                        title: 'Subscribe',
                        route: '/auth',
                      ),
                    ],
                  ),
                  InkWell(
                    child: Image.asset(
                      logo,
                      fit: BoxFit.contain,
                      height: 50.0,
                    ),
                    onTap: () => Beamer.of(context).beamToNamed('/'),
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
            color: secondaryColor,
          ),
        ),
      ],
    );
  }
}
