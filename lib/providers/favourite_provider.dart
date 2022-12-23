import 'package:flutter/material.dart';

//import 'package:firebase_database/firebase_database.dart';

import '../models/post_model.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Post> _favouritePosts = [];
  List<Post> get favouritePosts => _favouritePosts;
  // FirebaseDatabase db = FirebaseDatabase.instance;
  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  void toggleFavourite(Post post) {
    final inFavourites = _favouritePosts.contains(post);
    if (inFavourites) {
      _favouritePosts.remove(post);
    } else {
      _favouritePosts.add(post);
    }
    notifyListeners();
  }

  bool isInFavourites(Post post) {
    final inFavourites = _favouritePosts.contains(post);
    return inFavourites;
  }
}
