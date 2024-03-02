import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/providers/favourite_provider.dart';
import '/widgets/custom_appbar_widget.dart';
import '/widgets/custom_text_field_widget.dart';

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
    final mediaWidth = MediaQuery.of(context).size.width;
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;
    TextStyle headingStyle = TextStyle(
      fontSize: 30.0,
      color: isDarkMode ? Colors.blueAccent : color,
    );
    return Scaffold(
      drawer: appDrawer,
      appBar: const CustomAppBarWidget(id: '/subscribe'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: kPadding,
                child: Text(
                  'Subscribe',
                  style: headingStyle,
                ),
              ),
              gapH35,
              CustomTextFieldWidget(
                mediaWidth: mediaWidth,
                controller: emailController,
                hintText: 'Email Address',
                obscure: false,
              ),
              gapH20,
              CustomTextFieldWidget(
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  onPressed: createUser,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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
