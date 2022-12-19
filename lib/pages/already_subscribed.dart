import 'package:flutter/material.dart';

import '../main.dart';

import '../widgets/app_drawer.dart';
import '../widgets/custom_appbar.dart';

class AlreadySubscribed extends StatelessWidget {
  const AlreadySubscribed({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: thirdColor,
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(id: '/subscribed'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Subscribe',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'You have already subscribed',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: secondaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 35),
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
