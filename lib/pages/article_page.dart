import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

import '../models/post_model.dart';
import '../providers/favourite_provider.dart';

import '../post_data.dart';

import '../widgets/custom_appbar.dart';

class ArticlePage extends StatefulWidget {
  final Post post;
  final String id;

  const ArticlePage({
    super.key,
    required this.post,
    required this.id,
  });

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<FavouriteProvider>(context);
    final favourites = provider.favouritePosts;
//Test
    final favouritePost = favourites.firstWhere(
      (post) => post.title == widget.post.title,
      orElse: () => widget.post,
    );
    final currentIndex = postData.indexOf(widget.post);
    final prevPost = currentIndex > 0 ? postData[currentIndex - 1] : null;
    final nextPost =
        currentIndex < postData.length - 1 ? postData[currentIndex + 1] : null;
    final currentFavouriteIndex = favourites.indexOf(widget.post);
    final prevFavouritePost = currentFavouriteIndex > 0
        ? favourites[currentFavouriteIndex - 1]
        : null;
    final nextFavouritePost = currentFavouriteIndex < favourites.length - 1
        ? favourites[currentFavouriteIndex + 1]
        : null;
    //End test

    // final favouritePost = favourites.firstWhere(
    //   (post) => post.title == widget.post.title,
    //   orElse: () => widget.post,
    // );
    // final currentIndex = postData.indexOf(widget.post);
    // final prevPost = currentIndex > 0 ? postData[currentIndex - 1] : null;
    // final nextPost =
    //     currentIndex < postData.length - 1 ? postData[currentIndex + 1] : null;
    // final currentFavouriteIndex = favourites.indexOf(widget.post);
    // final prevFavouritePost = currentFavouriteIndex > 0
    //     ? favourites[currentFavouriteIndex - 1]
    //     : null;
    // final nextFavouritePost = currentFavouriteIndex < favourites.length - 1
    //     ? favourites[currentFavouriteIndex + 1]
    //     : null;

    return GestureDetector(
      child: Scaffold(
        drawer: appDrawer,
        appBar: const CustomAppBar(id: '/article'),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: provider.isInFavourites(widget.post)
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          onPressed: () {
                            provider.toggleFavourite(widget.post);
                          },
                          iconSize: 24,
                          padding: kPadding,
                          color: secondaryColor,
                        ),
                        Expanded(
                          child: Container(
                            padding: kPadding,
                            child: Text(
                              favouritePost.title,
                              //post.title,
                              textAlign: TextAlign.center,
                              style: headingStyle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 56),
                      ],
                    ),
                    Container(
                      padding: kPadding,
                      child: Text(
                        favouritePost.body,
                        //post.body,
                        style: bodyStyle,
                      ),
                    ),
                    SizedBox(
                      width: mediaWidth <= 750
                          ? mediaWidth * 0.8
                          : mediaWidth * 0.4,
                      child: Padding(
                        padding: kPadding,
                        child: Image.asset(fullLogo),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  provider.isInFavourites(widget.post)
                      ? FloatingActionButton(
                          onPressed: () {
                            if (prevFavouritePost != null) {
                              String location = prevFavouritePost.id;
                              context.go('/article/$location',
                                  extra: prevFavouritePost);
                            }
                          },
                          backgroundColor: secondaryColor,
                          heroTag: null,
                          child: const RotatedBox(
                            quarterTurns: 3,
                            child: Icon(
                              Icons.star,
                              color: thirdColor,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  provider.isInFavourites(widget.post)
                      ? const SizedBox(height: 16)
                      : const SizedBox(),
                  FloatingActionButton(
                    onPressed: () {
                      if (prevPost != null) {
                        String location = prevPost.id;
                        context.go('/article/$location', extra: prevPost);
                      }
                    },
                    backgroundColor: secondaryColor,
                    heroTag: null,
                    child: const Icon(
                      Icons.navigate_before_rounded,
                      color: thirdColor,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  provider.isInFavourites(widget.post)
                      ? FloatingActionButton(
                          onPressed: () {
                            if (nextFavouritePost != null) {
                              String location = nextFavouritePost.id;
                              context.go('/article/$location',
                                  extra: nextFavouritePost);
                            }
                          },
                          backgroundColor: secondaryColor,
                          heroTag: null,
                          child: const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.star,
                              color: thirdColor,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  provider.isInFavourites(widget.post)
                      ? const SizedBox(height: 16)
                      : const SizedBox(),
                  FloatingActionButton(
                    onPressed: () {
                      if (nextPost != null) {
                        String location = nextPost.id;
                        context.go('/article/$location', extra: nextPost);
                      }
                    },
                    backgroundColor: secondaryColor,
                    heroTag: null,
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      color: thirdColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
