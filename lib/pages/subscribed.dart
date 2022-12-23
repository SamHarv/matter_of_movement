import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

import '../widgets/custom_appbar.dart';

class Subscribed extends StatefulWidget {
  const Subscribed({super.key});

  @override
  State<Subscribed> createState() => _SubscribedState();
}

class _SubscribedState extends State<Subscribed> {
  final user = FirebaseAuth.instance.currentUser!;

  void unsubscribe() {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    user.delete();
    Navigator.pop(context);
  }

  //void unsubscribe() => FirebaseAuth.instance.signOut();
  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: appDrawer,
      appBar: const CustomAppBar(id: '/subscribed'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: kPadding,
                child: const Text(
                  'Subscribe',
                  style: headingStyle,
                ),
              ),
              gapH35,
              Container(
                padding: kPadding,
                child: Text(
                  'You have successfully subscribed with: ${user.email!}',
                  style: bodyStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: kPadding,
                child: TextButton(
                  onPressed: unsubscribe,
                  child: const Text(
                    'Unsubscribe',
                    style: TextStyle(
                      fontSize: 20,
                      color: color,
                    ),
                  ),
                ),
              ),
              gapH35,
              SizedBox(
                width: mediaWidth <= 750 ? mediaWidth * 0.8 : mediaWidth * 0.4,
                child: Padding(
                  padding: kPadding,
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
