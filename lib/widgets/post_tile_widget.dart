import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/constants.dart';

class PostTileWidget extends StatelessWidget {
  final String title;
  final String image;
  final DateTime datePosted;
  final List<String>? tags;
  final VoidCallback onTap;
  final IconButton icon;

  const PostTileWidget({
    required this.title,
    required this.image,
    required this.datePosted,
    required this.onTap,
    required this.icon,
    this.tags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: color,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: kPadding,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black45,
              Colors.black54,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                image,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: icon,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(datePosted),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
