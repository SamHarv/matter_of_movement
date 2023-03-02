import 'package:go_router/go_router.dart';

import './pages/subscribed.dart';
import './pages/auth_page.dart';
import './pages/book_list.dart';
import './pages/subscribe_page.dart';
import './pages/home_page.dart';
import './pages/about_page.dart';
import './pages/favourites_page.dart';
import './pages/article_page.dart';
import 'models/post_model.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/favourites',
      builder: (context, state) => const FavouritesPage(),
    ),
    GoRoute(
      path: '/books',
      builder: (context, state) => const BookListPage(),
    ),
    GoRoute(
      path: '/subscribe',
      builder: (context, state) => const SubscribePage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/subscribed',
      builder: (context, state) => const Subscribed(),
    ),
    GoRoute(
      path: '/article',
      builder: (context, state) => ArticlePage(post: state.extra! as Post),
    ),
  ],
);
