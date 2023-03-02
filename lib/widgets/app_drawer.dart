import 'package:flutter/material.dart';

import '../constants.dart';

import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget buildListTile(String title, IconData icon, dynamic tapHandler) {
    return ListTile(
      tileColor: thirdColor,
      leading: Icon(
        icon,
        size: 26,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          color: secondaryColor,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: thirdColor,
      child: Column(
        children: [
          Container(
            //height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: thirdColor,
            child: Image.asset(fullLogo),
          ),
          const Divider(),
          buildListTile(
            'Home',
            Icons.home,
            () => context.go('/'),
          ),
          const Divider(),
          buildListTile(
            'Favourites',
            Icons.star,
            () => context.go('/favourites'),
          ),
          const Divider(),
          buildListTile(
            'About',
            Icons.info,
            () => context.go('/about'),
          ),
          const Divider(),
          buildListTile(
            'Book List',
            Icons.book,
            () => context.go('/books'),
          ),
          const Divider(),
          buildListTile(
            'Subscribe',
            Icons.email,
            () => context.go('/auth'),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
