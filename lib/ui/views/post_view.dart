import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../config/constants.dart';
import '../../data/models/post_model.dart';
import '../../logic/providers/favourite_provider.dart';
import '../../data/post_data.dart';

class PostView extends StatefulWidget {
  /// UI to display the selected post

  final Post post;
  final String id;

  const PostView({
    super.key,
    required this.post,
    required this.id,
  });

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    // Get favourite posts
    final provider = Provider.of<FavouriteProvider>(context);
    final favourites = provider.favouritePosts;
    // Get current, previous and next posts for pagination
    final currentIndex = postData.indexOf(widget.post);
    final prevPost = currentIndex > 0 ? postData[currentIndex - 1] : null;
    final nextPost =
        currentIndex < postData.length - 1 ? postData[currentIndex + 1] : null;
    // Get current, previous and next favourite posts for pagination
    final currentFavouriteIndex = favourites.indexOf(widget.post);
    final prevFavouritePost = currentFavouriteIndex > 0
        ? favourites[currentFavouriteIndex - 1]
        : null;
    final nextFavouritePost = currentFavouriteIndex < favourites.length - 1
        ? favourites[currentFavouriteIndex + 1]
        : null;

    return Scaffold(
      body: Container(
        // Parchment style background image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/parchment.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: bodyPadding,
        child: CustomScrollView(
          slivers: [
            PreferredSize(
              preferredSize: appBarHeight,
              child: SliverAppBar(
                toolbarHeight: 120,
                flexibleSpace: emptyBox,
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: kPadding,
                  child: Tooltip(
                    message: 'Back to Home',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(80),
                      // Navigate back to home
                      onTap: () => Beamer.of(context).beamToNamed('/'),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    // Toggle favourite status
                    child: IconButton(
                      tooltip: provider.isInFavourites(widget.post)
                          ? 'Remove from Favourites'
                          : 'Add to Favourites',
                      icon: provider.isInFavourites(widget.post)
                          ? Icon(Icons.star)
                          : Icon(Icons.star_border),
                      onPressed: () {
                        provider.toggleFavourite(widget.post);
                        HapticFeedback.mediumImpact();
                        // Build snackbar to show favourite status
                        final snackBar = SnackBar(
                          content: Text(
                            provider.isInFavourites(widget.post)
                                ? 'Removed from Favourites'
                                : 'Added to Favourites',
                            style: const TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: colour,
                          action: SnackBarAction(
                            label: 'undo',
                            textColor: Colors.white,
                            onPressed: () =>
                                provider.toggleFavourite(widget.post),
                          ),
                        );
                        // Show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      iconSize: 24,
                      padding: kPadding,
                      // color: colour,
                    ),
                  )
                ],
                iconTheme: const IconThemeData(
                  color: colour,
                ),
                centerTitle: true,
                // Display post title
                title: Text(
                  widget.post.title,
                  maxLines: 4,
                  style: titleStyle,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Display post body
                  Padding(
                    padding: kPadding,
                    child: Text(
                      widget.post.body,
                      style: bodyStyle,
                    ),
                  ),
                  // Display O2Tech logo
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        logo,
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
        padding: kPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Navigate to previous post
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                provider.isInFavourites(widget.post)
                    ? IconButton(
                        tooltip: 'Previous Favourite',
                        iconSize: 30,
                        onPressed: () {
                          // Navigate to previous favourite post
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
                            color: colour,
                          ),
                        ),
                      )
                    : emptyBox,
                // Add space between buttons
                provider.isInFavourites(widget.post) ? gapH16 : emptyBox,
                // Navigate to previous post whether a favourite or not
                IconButton(
                  tooltip: 'Previous Post',
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
                    color: colour,
                  ),
                ),
              ],
            ),
            // Navigate to next post
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                provider.isInFavourites(widget.post)
                    ? IconButton(
                        tooltip: 'Next Favourite',
                        iconSize: 30,
                        onPressed: () {
                          // Navigate to next favourite post
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
                            color: colour,
                          ),
                        ),
                      )
                    : emptyBox,
                // Add space between buttons
                provider.isInFavourites(widget.post) ? gapH16 : emptyBox,
                // Navigate to next post whether a favourite or not
                IconButton(
                  tooltip: 'Next Post',
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
                    color: colour,
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
