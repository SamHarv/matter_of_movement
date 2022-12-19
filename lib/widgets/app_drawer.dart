import 'package:flutter/material.dart';

import '../main.dart';

import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget buildListTile(String title, IconData icon, dynamic tapHandler) {
    return ListTile(
      tileColor: thirdColor,
      leading: Icon(
        icon,
        size: 26,
        color: const Color.fromARGB(255, 0, 74, 173),
      ),
      title: Text(
        title,
        style: TextStyle(
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
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: secondaryColor,
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 26, color: thirdColor),
            ),
          ),
          const SizedBox(height: 20),
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
