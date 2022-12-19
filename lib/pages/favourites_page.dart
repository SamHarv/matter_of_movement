import 'package:flutter/material.dart';

import '../main.dart';

import '../widgets/app_drawer.dart';
import '../widgets/custom_appbar.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: thirdColor,
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(id: '/favourites'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Favourites Page',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Favourites page functionality is under construction.\n\n'
                  'Please check back soon.',
                  style: TextStyle(
                    fontSize: 20,
                    color: secondaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: mediaWidth <= 750 ? mediaWidth * 0.8 : mediaWidth * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(fullLogo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
