import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/post_model.dart';

class FavouriteProvider extends ChangeNotifier {
  bool _darkMode = true;
  bool get darkMode => _darkMode;

  void getMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('darkMode');
    _darkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  ThemeMode get themeMode {
    getMode();
    if (darkMode) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  Future<void> toggleDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_darkMode) {
      prefs.setBool('darkMode', false);
      _darkMode = false;
    } else {
      prefs.setBool('darkMode', true);
      _darkMode = true;
    }
    notifyListeners();
  }

  List<Post?> _favouritePosts = [];
  List<Post?> get favouritePosts => _favouritePosts;

  final String postHiveBox = 'post-box';

  Future<void> createItem(Post post) async {
    Box<Post> box = Hive.box(postHiveBox);
    getItems();
    await box.add(post);
    _favouritePosts.add(post);
    notifyListeners();
  }

  Future<void> getItems() async {
    Box<Post> box = Hive.box(postHiveBox);
    _favouritePosts = box.values.toList();
  }

  void removeItem(Post post) {
    Box<Post> box = Hive.box(postHiveBox);
    getItems();
    box.delete(post.key);
    _favouritePosts.remove(post);
    notifyListeners();
  }

  Future<void> toggleFavourite(Post post) async {
    await getItems();
    final inFavourites = isInFavourites(post);
    if (inFavourites) {
      removeItem(post);
    } else {
      await createItem(post);
    }
    notifyListeners();
  }

  bool isInFavourites(Post post) {
    getItems();
    return _favouritePosts.contains(post);
  }
}
