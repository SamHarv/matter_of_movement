import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

import './providers/favourite_provider.dart';

import './routes.dart';
import './constants.dart';
import './models/post_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Post>('post-box');
  setPathUrlStrategy();
  runApp(ChangeNotifierProvider(
      child: const MoM(), create: (_) => FavouriteProvider()));
}

class MoM extends StatelessWidget {
  const MoM({super.key});

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    //final isDarkMode = darkModeProvider.darkMode;
    return Consumer(
      builder: (context, provider, child) {
        //create: (context) => FavouriteProvider(),
        return MaterialApp.router(
          theme: ThemeData(
            primaryColor: color,
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: darkModeProvider.themeMode,
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerParser(),
          debugShowCheckedModeBanner: false,
          title: 'Matter of Movement',
        );
      },
    );
  }
}

//todo: 
//Fix issue of toggleFavourite not working on HomePage after refresh

//To Update Firebase:
//Save project;
//Change the version on pubspec.yaml (from 1.0.0+1 to 1.0.1+1 for example);
//Run flutter build web.
//Run firebase deploy.

//Update Github
//git add .
//git commit -m "Customisable Message which describes changes"
//git push
