import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '/constants.dart';
import '/post_data.dart';
import '/providers/favourite_provider.dart';
import '/widgets/post_tile_widget.dart';

// TODO: use flex to display the posts

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);

    return Scaffold(
      drawer: appDrawer,
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
                    child: Image.asset(
                      'images/o2tech_black.png',
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(80),
                      onTap: () =>
                          Beamer.of(context).beamToNamed('/favourites'),
                      child: const Icon(
                        Icons.star,
                        color: secondaryColor,
                      ),
                    ),
                  )
                ],
                iconTheme: const IconThemeData(
                  color: secondaryColor,
                ),
                centerTitle: true,
                title: Text(
                  'Thoughts',
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
                childCount: postData.length,
                (context, index) {
                  final post = postData[index];
                  return PostTileWidget(
                    title: post.title,
                    image: post.image,
                    content: post.body,
                    datePosted: post.datePosted,
                    onTap: () {
                      String location = post.id;
                      Beamer.of(context).beamToNamed('/article/$location',
                          data: {'post': post});
                    },
                    icon: IconButton(
                      icon: provider.isInFavourites(post)
                          ? const Icon(
                              Icons.star,
                              color: secondaryColor,
                            )
                          : const Icon(
                              Icons.star_border,
                              color: secondaryColor,
                            ),
                      onPressed: () {
                        provider.toggleFavourite(post);
                        //Animate icon
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
                      color: thirdColor,
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
