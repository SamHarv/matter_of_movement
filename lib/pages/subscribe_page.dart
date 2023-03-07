import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/text_field.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  void createUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: nameController.text.trim(),
      );
      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  //error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: appDrawer,
      appBar: const CustomAppBar(id: '/subscribe'),
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
              MyTextField(
                mediaWidth: mediaWidth,
                controller: emailController,
                hintText: 'Email Address',
                obscure: false,
              ),
              gapH20,
              MyTextField(
                mediaWidth: mediaWidth,
                controller: nameController,
                hintText: 'Create Password',
                obscure: true,
              ),
              gapH20,
              SizedBox(
                height: 51,
                width: mediaWidth <= 750 ? mediaWidth * 0.7 : mediaWidth * 0.4,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      color,
                    ),
                  ),
                  onPressed: createUser,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
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
