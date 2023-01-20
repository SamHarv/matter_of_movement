import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutterwebapp_reload_detector/flutterwebapp_reload_detector.dart';

import '../constants.dart';

import '../providers/favourite_provider.dart';

import '../post_data.dart';

import '../widgets/custom_appbar.dart';

class ArticlePage extends StatefulWidget {
  final int postIndex;

  const ArticlePage({
    super.key,
    required this.postIndex,
  });

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  void initState() {
    // Make sure to Call this on Top Level Widget only once
    WebAppReloadDetector.onReload(() {
      setState(() {
        context.go('/');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final post = postData[widget.postIndex];
    final provider = Provider.of<FavouriteProvider>(context);
    return GestureDetector(
      child: Scaffold(
        drawer: appDrawer,
        appBar: const CustomAppBar(id: '/article'),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        provider.isInFavourites(post)
                            ? IconButton(
                                icon: const Icon(Icons.star),
                                onPressed: () {
                                  provider.toggleFavourite(post);
                                },
                                iconSize: 24,
                                padding: kPadding,
                                color: secondaryColor,
                              )
                            : IconButton(
                                icon: const Icon(Icons.star_border),
                                onPressed: () {
                                  provider.toggleFavourite(post);
                                },
                                iconSize: 24,
                                padding: kPadding,
                                color: secondaryColor,
                              ),
                        Expanded(
                          child: Container(
                            padding: kPadding,
                            child: Text(
                              postData[widget.postIndex].title,
                              textAlign: TextAlign.center,
                              style: headingStyle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 56),
                      ],
                    ),
                    Container(
                      padding: kPadding,
                      child: Text(
                        postData[widget.postIndex].body,
                        style: bodyStyle,
                      ),
                    ),
                    SizedBox(
                      width: mediaWidth <= 750
                          ? mediaWidth * 0.8
                          : mediaWidth * 0.4,
                      child: Padding(
                        padding: kPadding,
                        child: Image.asset(fullLogo),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () =>
                    (widget.postIndex >= postData.length - postData.length + 1)
                        ? context.go('/article', extra: widget.postIndex - 1)
                        : context.go('/article', extra: widget.postIndex),
                backgroundColor: secondaryColor,
                heroTag: null,
                child: const Icon(
                  Icons.navigate_before_rounded,
                  color: thirdColor,
                ),
              ),
              FloatingActionButton(
                onPressed: () => (widget.postIndex < postData.length - 1)
                    ? context.go('/article', extra: widget.postIndex + 1)
                    : context.go('/article', extra: widget.postIndex),
                backgroundColor: secondaryColor,
                heroTag: null,
                child: const Icon(
                  Icons.navigate_next_rounded,
                  color: thirdColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
