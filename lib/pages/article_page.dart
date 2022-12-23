import 'package:flutter/material.dart';

import '../constants.dart';

import 'package:go_router/go_router.dart';

import '../post_data.dart';

import '../widgets/custom_appbar.dart';

class ArticlePage extends StatelessWidget {
  final int postIndex;

  const ArticlePage({
    super.key,
    required this.postIndex,
  });

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
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
                    Container(
                      padding: kPadding,
                      child: Text(
                        postData[postIndex].title,
                        textAlign: TextAlign.center,
                        style: headingStyle,
                      ),
                    ),
                    Container(
                      padding: kPadding,
                      child: Text(
                        postData[postIndex].body,
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
                    (postIndex >= postData.length - postData.length + 1)
                        ? context.go('/article', extra: postIndex - 1)
                        : context.go('/article', extra: postIndex),
                backgroundColor: secondaryColor,
                heroTag: null,
                child: const Icon(
                  Icons.navigate_before_rounded,
                  color: thirdColor,
                ),
              ),
              FloatingActionButton(
                onPressed: () => (postIndex < postData.length - 1)
                    ? context.go('/article', extra: postIndex + 1)
                    : context.go('/article', extra: postIndex),
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
