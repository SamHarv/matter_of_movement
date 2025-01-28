import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../config/constants.dart';

class PostTileWidget extends StatelessWidget {
  /// A widget to display a post tile

  final String title;
  final String image; // Not in use
  final DateTime datePosted;
  final List<String>? tags; // Not in use
  final VoidCallback onTap;
  final Tooltip icon;
  final String content; // body

  const PostTileWidget({
    required this.title,
    required this.image,
    required this.datePosted,
    required this.onTap,
    required this.icon,
    required this.content,
    this.tags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: bodyPadding,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: icon,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post title
                  SizedBox(
                    width: mediaWidth * 0.7, // avoid overlap with icon
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: titleStyle,
                    ),
                  ),
                  // Date posted
                  Text(
                    DateFormat.yMMMMd().format(datePosted),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.patrickHand(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Merienda',
                      ),
                    ),
                  ),
                  Divider(
                    color: colour,
                    thickness: 0.3,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
