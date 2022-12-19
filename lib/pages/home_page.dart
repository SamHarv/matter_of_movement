import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';

import '../post_data.dart';

import '../widgets/app_drawer.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/post_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: thirdColor,
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(id: '/'),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: mediaWidth <= 750 ? 2 : 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: postData.length,
                (context, postIndex) {
                  return PostTile(
                    title: postData[postIndex].title,
                    image: postData[postIndex].image,
                    datePosted: postData[postIndex].datePosted,
                    onTap: () => context.go(
                      '/article',
                      extra: postIndex,
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
                    padding: const EdgeInsets.all(16.0),
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
        onPressed: () => context.go('/favourites'),
        backgroundColor: secondaryColor,
        child: Icon(
          Icons.star,
          color: thirdColor,
        ),
      ),
    );
  }
}
