import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import '../post_data.dart';

import './pages/subscribed.dart';
import './pages/auth_page.dart';
import './pages/book_list.dart';
import './pages/subscribe_page.dart';
import './pages/home_page.dart';
import './pages/about_page.dart';
import './pages/favourites_page.dart';
import './pages/article_page.dart';

final routerDelegate = BeamerDelegate(
  notFoundRedirectNamed: '/home',
  initialPath: '/home',
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/home': (context, state, data) {
        return const BeamPage(
          key: ValueKey('home'),
          type: BeamPageType.fadeTransition,
          title: 'Matter of Movement',
          child: HomePage(),
        );
      },
      '/about': (context, state, data) {
        return const BeamPage(
          key: ValueKey('about'),
          type: BeamPageType.fadeTransition,
          title: 'About - Matter of Movement',
          child: AboutPage(),
        );
      },
      '/favourites': (context, state, data) {
        return const BeamPage(
          key: ValueKey('favourites'),
          type: BeamPageType.fadeTransition,
          title: 'Favourite Posts - Matter of Movement',
          child: FavouritesPage(),
        );
      },
      '/books': (context, state, data) {
        return const BeamPage(
          key: ValueKey('books'),
          type: BeamPageType.fadeTransition,
          title: 'Top 100 Books - Matter of Movement',
          child: BookListPage(),
        );
      },
      '/subscribe': (context, state, data) {
        return const BeamPage(
          key: ValueKey('subscribe'),
          type: BeamPageType.fadeTransition,
          title: 'Subscribe - Matter of Movement',
          child: SubscribePage(),
        );
      },
      '/auth': (context, state, data) {
        return const BeamPage(
          key: ValueKey('auth'),
          type: BeamPageType.fadeTransition,
          title: 'Subscribe - Matter of Movement',
          child: AuthPage(),
        );
      },
      '/subscribed': (context, state, data) {
        return const BeamPage(
          key: ValueKey('subscribed'),
          type: BeamPageType.fadeTransition,
          title: 'Subscribed - Matter of Movement',
          child: Subscribed(),
        );
      },
      '/article/:id': (context, state, data) {
        final postId = state.pathParameters['id'];
        final post = postData.firstWhere((post) => post.id == postId);
        return BeamPage(
          key: ValueKey('article-$postId'),
          type: BeamPageType.fadeTransition,
          title: post.title,
          child: ArticlePage(post: post, id: postId!),
        );
      },
    },
  ),
);
