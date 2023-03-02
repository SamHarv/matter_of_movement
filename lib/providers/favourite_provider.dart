import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/post_model.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Post> _favouritePosts = [];
  List<Post> get favouritePosts => _favouritePosts;

  final String postHiveBox = 'post-box';

  Future<void> createItem(Post post) async {
    Box<Post> box = Hive.box(postHiveBox);
    await box.add(post);
    notifyListeners();
    _favouritePosts.add(post);
    _favouritePosts = box.values.toList();
    notifyListeners();
  }

  Future<void> getItems() async {
    Box<Post> box = await Hive.openBox<Post>(postHiveBox);
    _favouritePosts = box.values.toList();
    notifyListeners();
  }

  void removeItem(Post post) {
    Box<Post> box = Hive.box(postHiveBox);
    box.delete(post.key);
    notifyListeners();
    _favouritePosts = box.values.toList();
    notifyListeners();
  }

  void toggleFavourite(Post post) async {
    final inFavourites = isInFavourites(post);
    if (inFavourites) {
      _favouritePosts.remove(post);
      removeItem(post);
    } else {
      _favouritePosts.add(post);
      createItem(post);
    }
    notifyListeners();
  }

  bool isInFavourites(Post post) {
    getItems();
    final inFavourites = _favouritePosts.contains(post);
    return inFavourites;
  }
}
