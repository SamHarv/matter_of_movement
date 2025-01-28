import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../config/constants.dart';
import '../../logic/providers/favourite_provider.dart';
import '../widgets/post_tile_widget.dart';

class FavouritesPage extends StatelessWidget {
  /// UI to display favourite posts

  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    final favouritePosts = provider.favouritePosts;

    return Scaffold(
      body: Container(
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
                // pinned: true,
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: kPadding,
                  child: Tooltip(
                    message: 'Back to Home',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(80),
                      // Navigate back home
                      onTap: () => Beamer.of(context).beamToNamed('/'),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: colour,
                ),
                centerTitle: true,
                title: Text(
                  'Favourite Thoughts',
                  style: titleStyle,
                ),
              ),
            ),
            // Display favourite posts
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: favouritePosts.length,
                (context, index) {
                  final post = favouritePosts[index];
                  return PostTileWidget(
                    title: post!.title,
                    image: post.image,
                    content: post.body,
                    datePosted: post.datePosted,
                    onTap: () {
                      // Navigate to selected post
                      String location = post.id;
                      Beamer.of(context).beamToNamed('/article/$location',
                          data: {'post': post});
                    },
                    // Add to or remove from favourites
                    icon: Tooltip(
                      message: 'Remove from Favourites',
                      child: IconButton(
                        icon: const Icon(Icons.star),
                        onPressed: () {
                          provider.toggleFavourite(post);
                          HapticFeedback.mediumImpact();
                          final snackBar = SnackBar(
                            content: Text(
                              provider.isInFavourites(post)
                                  ? 'Removed from Favourites'
                                  : 'Added to Favourites',
                              style: const TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: colour,
                            action: SnackBarAction(
                              label: 'undo',
                              textColor: Colors.white,
                              onPressed: () => provider.toggleFavourite(post),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        color: colour,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
