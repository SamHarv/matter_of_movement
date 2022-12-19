import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:matterofmovement/main.dart';

import '../pages/search_page.dart';

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
    double mediaWidth = MediaQuery.of(context).size.width;

    return AppBar(
      automaticallyImplyLeading: mediaWidth < 750 ? true : false,
      iconTheme: IconThemeData(
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
                onTap: () => context.go('/'),
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
                    onTap: () => context.go('/'),
                  ),
                ],
              ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SearchPage(),
              ),
            ),
            icon: const Icon(Icons.search),
            color: secondaryColor,
          ),
        ),
      ],
    );
  }
}
