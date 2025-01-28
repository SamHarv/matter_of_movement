import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Primary colour
const colour = Colors.black;

/// Black O2Tech logo
const logo = 'images/o2tech_black.png';

const kPadding = EdgeInsets.all(16.0);
const bodyPadding = EdgeInsets.fromLTRB(16, 0, 16, 0);

/// SliverAppBar height
const appBarHeight = Size.fromHeight(120);

// Spacing widgets
const gapH16 = SizedBox(width: 16);
const emptyBox = SizedBox();

final titleStyle = GoogleFonts.patrickHand(
  textStyle: const TextStyle(
    color: colour,
    fontSize: 26,
    fontFamily: 'Patrick Hand',
  ),
);

final bodyStyle = GoogleFonts.patrickHand(
  textStyle: const TextStyle(
    color: colour,
    fontSize: 22,
    fontFamily: 'Patrick Hand',
  ),
);
