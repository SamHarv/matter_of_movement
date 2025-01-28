import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import '../../data/post_data.dart';
import '../../ui/views/home_view.dart';
import '../../ui/views/favourites_view.dart';
import '../../ui/views/post_view.dart';

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: '/',
  initialPath: '/',
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) {
        return const BeamPage(
          key: ValueKey('home'),
          type: BeamPageType.slideLeftTransition,
          title: 'Thoughts',
          child: HomeView(),
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
        // Get the navigation direction from the data for animation
        final isForward =
            data is Map ? data['isForward'] as bool? ?? true : true;
        return BeamPage(
          key: ValueKey('article-$postId'),
          // Animate to replicate page turn
          type: isForward
              ? BeamPageType.slideRightTransition
              : BeamPageType.slideLeftTransition,
          title: 'Thoughts',
          child: PostView(post: post, id: postId!),
        );
      },
    },
  ).call,
);
