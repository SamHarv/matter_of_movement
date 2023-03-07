import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

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
            () => Beamer.of(context).beamToNamed('/'),
          ),
          const Divider(),
          buildListTile(
            'Favourites',
            Icons.star,
            () => Beamer.of(context).beamToNamed('/favourites'),
          ),
          const Divider(),
          buildListTile(
            'About',
            Icons.info,
            () => Beamer.of(context).beamToNamed('/about'),
          ),
          const Divider(),
          buildListTile(
            'Book List',
            Icons.book,
            () => Beamer.of(context).beamToNamed('/books'),
          ),
          const Divider(),
          buildListTile(
            'Subscribe',
            Icons.email,
            () => Beamer.of(context).beamToNamed('/auth'),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
