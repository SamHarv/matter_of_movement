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
  notFoundRedirectNamed: '/',
  initialPath: '/',
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) => const HomePage(),
      '/about': (context, state, data) => const AboutPage(),
      '/favourites': (context, state, data) => const FavouritesPage(),
      '/books': (context, state, data) => const BookListPage(),
      '/subscribe': (context, state, data) => const SubscribePage(),
      '/auth': (context, state, data) => const AuthPage(),
      '/subscribed': (context, state, data) => const Subscribed(),
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
