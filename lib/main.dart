import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './providers/favourite_provider.dart';

import './routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MoM());
}

class MoM extends StatelessWidget {
  const MoM({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteProvider(),
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Matter of Movement',
      ),
    );
  }
}

//todo: 
//add data persistence 
//commit and deploy
//check out all Firebase features (set them up)

//fix refresh/ link copy & paste issue - try to replace extra with params?
//add search functionality with topic tags/ keys
//add comment functionality
//implement switch to enable dark mode
//improve performance
//work on O2 Tech webpage

//To Update Firebase:
//Save project;
//Change the version on pubspec.yaml (from 1.0.0+1 to 1.0.1+1 for example);
//Run flutter build web.
//Run firebase deploy.

//Update Github
//git add .
//git commit -m "Customisable Message which describes changes"
//git push