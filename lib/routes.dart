import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import 'post_data.dart';
import 'pages/home_page.dart';
import 'pages/favourites_page.dart';
import 'pages/article_page.dart';

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: '/home',
  initialPath: '/home',
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/home': (context, state, data) {
        return const BeamPage(
          key: ValueKey('home'),
          type: BeamPageType.slideLeftTransition,
          title: 'Thoughts',
          child: HomePage(),
        );
      },
      '/favourites': (context, state, data) {
        return const BeamPage(
          key: ValueKey('favourites'),
          type: BeamPageType.slideRightTransition,
          title: 'Thoughts',
          child: FavouritesPage(),
        );
      },
      '/article/:id': (context, state, data) {
        final postId = state.pathParameters['id'];
        final post = postData.firstWhere((post) => post.id == postId);
        // Get the navigation direction from the data
        final isForward =
            data is Map ? data['isForward'] as bool? ?? true : true;
        return BeamPage(
          key: ValueKey('article-$postId'),
          type: isForward
              ? BeamPageType.slideRightTransition
              : BeamPageType.slideLeftTransition,
          title: 'Thoughts',
          child: ArticlePage(post: post, id: postId!),
        );
      },
    },
  ).call,
);
