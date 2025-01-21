import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/models/post_model.dart';
import '/providers/favourite_provider.dart';
import '/post_data.dart';

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
    final provider = Provider.of<FavouriteProvider>(context);
    final favourites = provider.favouritePosts;
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

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/parchment.png'), fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: CustomScrollView(
          slivers: [
            PreferredSize(
              preferredSize: const Size.fromHeight(120),
              child: SliverAppBar(
                toolbarHeight: 120,
                flexibleSpace: SizedBox(),
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: EdgeInsets.all(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(80),
                    onTap: () => Beamer.of(context).beamToNamed('/'),
                    child: Icon(
                      Icons.arrow_back,
                      color: secondaryColor,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: IconButton(
                      icon: provider.isInFavourites(widget.post)
                          ? Icon(Icons.star, color: secondaryColor)
                          : Icon(Icons.star_border, color: secondaryColor),
                      onPressed: () {
                        provider.toggleFavourite(widget.post);
                        HapticFeedback.mediumImpact();
                        final snackBar = SnackBar(
                          content: Text(
                            provider.isInFavourites(widget.post)
                                ? 'Removed from Favourites'
                                : 'Added to Favourites',
                            style: const TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: secondaryColor,
                          action: SnackBarAction(
                            label: 'undo',
                            textColor: Colors.white,
                            onPressed: () =>
                                provider.toggleFavourite(widget.post),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      iconSize: 24,
                      padding: kPadding,
                      color: secondaryColor,
                    ),
                  )
                ],
                iconTheme: const IconThemeData(
                  color: secondaryColor,
                ),
                centerTitle: true,
                title: Text(
                  widget.post.title,
                  maxLines: 4,
                  style: GoogleFonts.patrickHand(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontFamily: 'Merienda',
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: kPadding,
                    child: Text(
                      widget.post.body,
                      style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Merienda',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        'images/o2tech_black.png',
                        height: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                provider.isInFavourites(widget.post)
                    ? IconButton(
                        iconSize: 30,
                        onPressed: () {
                          if (prevFavouritePost != null) {
                            String location = prevFavouritePost.id;
                            Beamer.of(context).beamToNamed(
                              '/article/$location',
                              data: {
                                'post': prevFavouritePost,
                                'isForward': false,
                              },
                            );
                          }
                        },
                        icon: const RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.star,
                            color: secondaryColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
                provider.isInFavourites(widget.post)
                    ? const SizedBox(height: 16)
                    : const SizedBox(),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    if (prevPost != null) {
                      String location = prevPost.id;
                      Beamer.of(context).beamToNamed(
                        '/article/$location',
                        data: {
                          'post': prevPost,
                          'isForward': false,
                        },
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.navigate_before_rounded,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                provider.isInFavourites(widget.post)
                    ? IconButton(
                        iconSize: 30,
                        onPressed: () {
                          if (nextFavouritePost != null) {
                            String location = nextFavouritePost.id;
                            Beamer.of(context).beamToNamed(
                              '/article/$location',
                              data: {
                                'post': nextFavouritePost,
                                'isForward': true,
                              },
                            );
                          }
                        },
                        icon: const RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.star,
                            color: secondaryColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
                provider.isInFavourites(widget.post)
                    ? const SizedBox(height: 16)
                    : const SizedBox(),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    if (nextPost != null) {
                      String location = nextPost.id;
                      Beamer.of(context).beamToNamed(
                        '/article/$location',
                        data: {
                          'post': nextPost,
                          'isForward': true,
                        },
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.navigate_next_rounded,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
