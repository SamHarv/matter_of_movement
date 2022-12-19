//import 'dart:js';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

import '../widgets/app_drawer.dart';
import '../widgets/custom_appbar.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final emailController = TextEditingController();

  var acs = ActionCodeSettings(
    url: 'https://matterofmovement.page.link/success',
    handleCodeInApp: true,
    iOSBundleId: 'com.example.matterofmovement',
    androidPackageName: 'com.example.matterofmovement',
    androidInstallApp: true,
    androidMinimumVersion: '12',
  );

  void signInUser() async {
    await FirebaseAuth.instance
        .sendSignInLinkToEmail(
          email: emailController.text.trim(),
          actionCodeSettings: acs,
        )
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) => print('Successfully sent email verification'));
  }

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: thirdColor,
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(id: '/subscribe'),
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
              SizedBox(
                height: 51,
                width: mediaWidth <= 750 ? mediaWidth * 0.7 : mediaWidth * 0.4,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 51,
                width: mediaWidth <= 750 ? mediaWidth * 0.7 : mediaWidth * 0.4,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 74, 173),
                    ),
                  ),
                  onPressed: signInUser,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                    ),
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
