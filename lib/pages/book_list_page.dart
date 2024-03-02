import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants.dart';
import '/providers/favourite_provider.dart';
import '/widgets/custom_appbar_widget.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  static const Map<int, String> bookList = <int, String>{
    1: 'Essentialism - Greg McKeown',
    2: 'Limitless - Jim Kwik',
    3: 'Think Again - Adam Grant',
    4: 'Chatter - Ethan Kross',
    5: 'Atomic Habits - James Clear',
    6: 'Tao Te Ching - Lao Tzu',
    7: 'The One Thing - Gary Keller',
    8: 'Happy - Derren Brown ',
    9: 'Meditations - Marcus Aurelius',
    10: 'Quiet - Susan Cain',
    11: 'Deep Work - Cal Newport',
    12: 'Mindset - Carol Dweck',
    13: 'The Creative Act - Rick Rubin',
    14: 'Start With Why - Simon Sinek',
    15: 'Smart Brevity - Jim VandeHei',
    16: 'Silence - Thich Nhat Hanh',
    17: 'Thinking, Fast and Slow - D.K.',
    18: 'The 7 Habits - Stephen Covey',
    19: 'Never Split the Difference - C.V.',
    20: 'Moonwalking with Einstein - J.F.',
    21: 'Influence - Robert Cialdini',
    22: 'Hackers - Steven Levy',
    23: 'The Elegant Universe - B. Greene',
    24: 'Tuesdays with Morrie - M. Albom',
    25: 'Sapiens - Yuval Noah Harari',
    26: 'Ego is the Enemy - Ryan Holiday',
    27: 'Creativity Inc - Ed Catmull',
    28: 'Zero to One - Peter Thiel',
    29: 'Ikigai - Hector Garcia',
    30: 'Extreme Ownership - J. Willink',
  };

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final darkModeProvider = Provider.of<FavouriteProvider>(context);
    final isDarkMode = darkModeProvider.darkMode;
    TextStyle headingStyle = TextStyle(
      fontSize: 30.0,
      color: isDarkMode ? Colors.blueAccent : color,
    );
    TextStyle bodyStyle = TextStyle(
      fontSize: 20.0,
      color: isDarkMode ? thirdColor : secondaryColor,
    );
    return Scaffold(
      drawer: appDrawer,
      appBar: const CustomAppBarWidget(id: '/books'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  'Top 30 Books',
                  style: headingStyle,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 1,
                padding: kPadding,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    String key = bookList.keys.elementAt(index).toString();
                    String values = bookList.entries.elementAt(index).value;
                    return ListTile(
                      title: Row(
                        children: [
                          SizedBox(
                            width: 32,
                            child: Text(
                              key,
                              style: TextStyle(
                                color: isDarkMode ? Colors.blueAccent : color,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            values,
                            style: bodyStyle,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: mediaWidth <= 750 ? mediaWidth * 0.8 : mediaWidth * 0.4,
                child: Padding(
                  padding: kPadding,
                  child: Image.asset(fullLogo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
