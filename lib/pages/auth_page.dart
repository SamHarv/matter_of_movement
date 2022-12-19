import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:matterofmovement/pages/subscribe_page.dart';

import '../pages/already_subscribed.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => snapshot.hasData
            ? const AlreadySubscribed()
            : const SubscribePage(),
      ),
    );
  }
}
