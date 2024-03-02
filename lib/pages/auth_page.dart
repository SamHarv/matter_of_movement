import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'subscribe_page.dart';
import 'already_subscribed_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => snapshot.hasData
            ? const AlreadySubscribedPage()
            : const SubscribePage(),
      ),
    );
  }
}
