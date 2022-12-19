import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MoM());
}

bool darkMode = false;
final Color secondaryColor = darkMode ? Colors.white : Colors.black;
final Color thirdColor = darkMode ? Colors.black : Colors.white;
final String fullLogo = darkMode ? 'images/3.png' : 'images/2.png';
final String logo = darkMode ? 'images/4.png' : 'images/1.png';

class MoM extends StatelessWidget {
  const MoM({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 74, 173),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Matter of Movement',
    );
  }
}

//todo: 
//add section to subscribe via email
//add comment/ like (Favourite) functionality with shared prefs & riverpod

//check out all Firebase features (set them up)
//fix refresh/ link copy & paste issue - try to replace extra with params?
//copy to GitHub
//add search functionality with topic tags/ keys
//implement switch to enable dark mode
//improve performance
//work on O2 Tech webpage

//To Update:
//Save project;
//Change the version on pubspec.yaml (from 1.0.0+1 to 1.0.1+1 for example);
//Run flutter build web.
//Run firebase deploy.
