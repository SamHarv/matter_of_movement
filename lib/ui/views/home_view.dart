import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '/config/constants.dart';
import '/data/post_data.dart';
import '/logic/providers/favourite_provider.dart';
import '/logic/services/url_launcher.dart';
import '../widgets/post_tile_widget.dart';
import '../widgets/dad_jokes_widget.dart';

class HomeView extends StatefulWidget {
  /// UI to display the list of thoughts and a dad joke

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final url = UrlLauncher();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3));
    FlutterNativeSplash.remove(); // Remove splash screen
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/parchment.png',
            ), // Parchment style background image
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
                    message: 'Launch O2Tech website',
                    child: InkWell(
                      borderRadius: BorderRadius.circular(80),
                      onTap: () => url.launchO2Tech(),
                      child: Image.asset(logo),
                    ),
                  ),
                ),
                actions: [
                  // Navigate to favourites view
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Tooltip(
                      message: 'View Favourites',
                      child: InkWell(
                        borderRadius: BorderRadius.circular(80),
                        onTap: () =>
                            Beamer.of(context).beamToNamed('/favourites'),
                        child: const Icon(Icons.star),
                      ),
                    ),
                  )
                ],
                iconTheme: const IconThemeData(
                  color: colour,
                ),
                centerTitle: true,
                title: Text(
                  'Thoughts',
                  style: titleStyle,
                ),
              ),
            ),
            // Dad joke widget
            SliverToBoxAdapter(child: DadJokeWidget()),
            // Spacing between dad joke and thoughts
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            // List of thoughts entries
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: postData.length,
                (context, index) {
                  final post = postData[index];
                  return PostTileWidget(
                    title: post.title,
                    image: post.image, // not in use
                    content: post.body,
                    datePosted: post.datePosted,
                    onTap: () {
                      // Navigate to article view
                      String location = post.id;
                      Beamer.of(context).beamToNamed('/article/$location',
                          data: {'post': post});
                    },
                    // Icon to toggle favourite status
                    icon: Tooltip(
                      message: provider.isInFavourites(post)
                          ? 'Remove from Favourites'
                          : 'Add to Favourites',
                      child: IconButton(
                        icon: provider.isInFavourites(post)
                            ? const Icon(
                                Icons.star,
                                color: colour,
                              )
                            : const Icon(
                                Icons.star_border,
                                color: colour,
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
                            backgroundColor: colour,
                            action: SnackBarAction(
                              label: 'undo',
                              textColor: Colors.white,
                              onPressed: () => provider.toggleFavourite(post),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        // color: thirdColor,
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
