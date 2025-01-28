import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

import 'logic/providers/favourite_provider.dart';
import 'logic/routes/routes.dart';
import 'config/constants.dart';
import 'data/models/post_model.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Preserving the splash screen while the app is loading
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter(); // To save favourite posts locally
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Post>('post-box');
  setPathUrlStrategy();
  runApp(ChangeNotifierProvider(
      child: const Thoughts(), create: (_) => FavouriteProvider()));
  FlutterNativeSplash.remove();
}

class Thoughts extends StatelessWidget {
  const Thoughts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, provider, child) {
        return MaterialApp.router(
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: colour,
            scaffoldBackgroundColor: Color.fromARGB(1, 238, 222, 138),
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: ThemeMode.dark,
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerParser(),
          debugShowCheckedModeBanner: false,
          title: 'Thoughts',
        );
      },
    );
  }
}
