import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '/constants.dart';

class PostTileWidget extends StatelessWidget {
  final String title;
  final String image;
  final DateTime datePosted;
  final List<String>? tags;
  final VoidCallback onTap;
  final IconButton icon;
  final String content;

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

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       splashColor: color,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         padding: kPadding,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.black45,
//               Colors.black54,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Stack(
//           children: [
//             Center(
//               child: Image.asset(
//                 image,
//               ),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: icon,
//             ),
//             Align(
//               alignment: Alignment.bottomLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     title,
//                     overflow: TextOverflow.fade,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   ),
//                   Text(
//                     DateFormat.yMMMMd().format(datePosted),
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: kPadding,
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
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: mediaWidth * 0.8,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.patrickHand(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontFamily: 'Merienda',
                        ),
                      ),
                    ),
                  ),
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
                    color: Colors.black,
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
