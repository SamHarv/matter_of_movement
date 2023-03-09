import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

import '../providers/favourite_provider.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/post_tile.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<FavouriteProvider>(context);
    final favouritePosts = provider.favouritePosts;
    int adaptiveWidth() {
      if (mediaWidth <= 750) {
        return 2;
      } else if (mediaWidth > 750 && mediaWidth <= 1250) {
        return 3;
      } else {
        return 4;
      }
    }

    return Scaffold(
      drawer: appDrawer,
      appBar: const CustomAppBar(id: '/favourites'),
      body: Container(
        padding: kPadding,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: kPadding,
                  child: const Text(
                    'Favourites',
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                ),
              ]),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: adaptiveWidth(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: favouritePosts.length,
                (context, index) {
                  final post = favouritePosts[index];
                  return PostTile(
                    title: post!.title,
                    image: post.image,
                    datePosted: post.datePosted,
                    onTap: () {
                      String location = post.id;
                      Beamer.of(context).beamToNamed('/article/$location',
                          data: {'post': post});
                    },
                    icon: IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text(
                            provider.isInFavourites(post)
                                ? 'Removed from Favourites'
                                : 'Added to Favourites',
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: color,
                          action: SnackBarAction(
                            label: 'undo',
                            textColor: Colors.white,
                            onPressed: () => provider.toggleFavourite(post),
                          ),
                        );
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                        provider.toggleFavourite(post);
                        HapticFeedback.mediumImpact();
                      },
                      color: thirdColor,
                    ),
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  width:
                      mediaWidth <= 750 ? mediaWidth * 0.8 : mediaWidth * 0.4,
                  child: Padding(
                    padding: kPadding,
                    child: Image.asset(fullLogo),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
