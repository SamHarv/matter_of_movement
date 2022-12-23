import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

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
                crossAxisCount: mediaWidth <= 750 ? 2 : 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: favouritePosts.length,
                (context, postIndex) {
                  final post = favouritePosts[postIndex];
                  return PostTile(
                    title: post.title,
                    image: post.image,
                    datePosted: post.datePosted,
                    isFavourite: post.isFavourite,
                    onTap: () => context.go(
                      '/article',
                      extra: postIndex,
                    ),
                    icon: IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: () {
                        provider.toggleFavourite(post);
                        //delete from Hive Box
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
