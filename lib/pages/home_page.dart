import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../post_data.dart';

import '../providers/favourite_provider.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/post_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<FavouriteProvider>(context);

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
      appBar: const CustomAppBar(id: '/'),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.only(top: 16),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: adaptiveWidth(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: postData.length,
                (context, index) {
                  final post = postData[index];
                  return PostTile(
                    title: post.title,
                    image: post.image,
                    datePosted: post.datePosted,
                    onTap: () {
                      String location = post.id;
                      Beamer.of(context).beamToNamed('/article/$location',
                          data: {'post': post});
                    },
                    icon: IconButton(
                      icon: provider.isInFavourites(post)
                          ? const Icon(Icons.star)
                          : const Icon(Icons.star_border),
                      onPressed: () {
                        provider.toggleFavourite(post);
                        //Animate icon
                        HapticFeedback.mediumImpact();
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
                        // WidgetsBinding.instance
                        //     .addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //});
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Beamer.of(context).beamToNamed('/favourites'),
        backgroundColor: secondaryColor,
        child: const Icon(
          Icons.star,
          color: thirdColor,
        ),
      ),
    );
  }
}
