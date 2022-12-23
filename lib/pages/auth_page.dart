import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../pages/subscribe_page.dart';

import 'subscribed.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
            snapshot.hasData ? const Subscribed() : const SubscribePage(),
      ),
    );
  }
}
