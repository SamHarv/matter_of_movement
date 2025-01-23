import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

import 'providers/favourite_provider.dart';
import 'routes.dart';
import 'constants.dart';
import 'models/post_model.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Post>('post-box');
  setPathUrlStrategy();
  runApp(ChangeNotifierProvider(
      child: const MoM(), create: (_) => FavouriteProvider()));
  FlutterNativeSplash.remove();
}

class MoM extends StatelessWidget {
  const MoM({super.key});

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    return Consumer(
      builder: (context, provider, child) {
        return MaterialApp.router(
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: secondaryColor,
            scaffoldBackgroundColor: Color.fromARGB(1, 238, 222, 138),
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: darkModeProvider.themeMode,
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerParser(),
          debugShowCheckedModeBanner: false,
          title: 'Thoughts',
        );
      },
    );
  }
}
