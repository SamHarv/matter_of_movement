import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../data/models/post_model.dart';

class FavouriteProvider extends ChangeNotifier {
  /// Manipulate selected favourite posts with Hive

  List<Post?> _favouritePosts = [];
  List<Post?> get favouritePosts => _favouritePosts;

  final String postHiveBox = 'post-box';

  /// Add a post to the favourites
  Future<void> createItem(Post post) async {
    Box<Post> box = Hive.box(postHiveBox);
    getItems();
    await box.add(post);
    _favouritePosts.add(post);
    notifyListeners();
  }

  /// Get all the favourite posts
  Future<void> getItems() async {
    Box<Post> box = Hive.box(postHiveBox);
    _favouritePosts = box.values.toList();
  }

  /// Remove a post from the favourites
  void removeItem(Post post) {
    Box<Post> box = Hive.box(postHiveBox);
    getItems();
    box.delete(post.key);
    _favouritePosts.remove(post);
    notifyListeners();
  }

  /// Toggle a post in and out of the favourites
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

  /// Check whether a post is in the favourites
  bool isInFavourites(Post post) {
    getItems();
    return _favouritePosts.contains(post);
  }
}
