import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/providers/favourite_provider.dart';
import '/widgets/post_tile_widget.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    final favouritePosts = provider.favouritePosts;

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
                // pinned: true,
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
                iconTheme: const IconThemeData(
                  color: secondaryColor,
                ),
                centerTitle: true,
                title: Text(
                  'Favourite Thoughts',
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
                      String location = post.id;
                      Beamer.of(context).beamToNamed('/article/$location',
                          data: {'post': post});
                    },
                    icon: IconButton(
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
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: secondaryColor,
                          action: SnackBarAction(
                            label: 'undo',
                            textColor: Colors.white,
                            onPressed: () => provider.toggleFavourite(post),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      color: secondaryColor,
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
