import 'package:flutter/material.dart';

import '../constants.dart';

import '../widgets/custom_appbar.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  static const List<String> bookList = [
    '1. Limitless - Jim Kwik',
    '2. Essentialism - Greg McKeown',
    '3. Think Again - Adam Grant',
    '4. Meditations - Marcus Aurelius',
    '5. Atomic Habits - James Clear',
    '6. Chatter - Ethan Kross',
    '7. Quiet - Susan Cain',
    '8. Deep Work - Cal Newport',
    '9. Mindset - Carol Dweck',
    '10. Start With Why - Simon Sinek',
    '11. Smart Brevity - Jim VandeHei, Mark Allen & Roy Schwartz',
    '12. Thinking, Fast and Slow - Daniel Kahneman',
    '13. The 7 Habits of Highly Effective People - Stephen Covey',
    '14. Never Split the Difference - Chris Voss',
    '15. Moonwalking with Einstein - Joshua Foer',
    '16. Happy - Derren Brown',
    '17. Sapiens - Noah Yuval Harari',
    '18. Ego is the Enemy - Ryan Holiday',
    '19. Stillness is the Key - Ryan Holiday',
    '20. The Obstacle is the Way - Ryan Holiday',
    '21. Can\'t Hurt Me - David Goggins',
    '22. The War of Art - Steven Pressfield',
    '23. Creativity Inc - Ed Catmull',
    '24. Ikigai - Hector Garcia & Francesc Miralles',
    '25. The Power of Now - Eckhart Tolle',
    '26. The Lean Startup - Eric Ries',
    '27. Influence: the psychology of persuasion - Robert Cialdini',
    '28. How to Win Friends and Influence People - Dale Carnegie',
    '29. Rework - David Heinemeier Hansson & Jason Fried',
    '30. The Personal MBA - Josh Kaufman',
    '31. Outgrowing God - Richard Dawkins',
    '32. Tuesdays with Morrie - Mitch Albom',
    '33. The Code of the Extraordinary Mind - Vishen Lakhiani',
    '34. Antifragility - Nassim Nicholas Taleb',
    '35. The Innovators - Walter Isaacson',
    '36. The Elegant Universe - Brian Greene',
    '37. Extreme Ownership - Jocko Willink',
    '38. Life 3.0 - Max Tegmark',
    '39. Superintelligence - Nick Bostrom',
    '40. The Future of the Mind - Michio Kaku',
    '41. Enlightenment Now - Steven Pinker',
    '42. Grit - Angela Duckworth',
    '43. Pitch Anything - Oren Klaff',
    '44. The Future of Humanity - Michio Kaku',
    '45. Death by Black Hole - Neil Degrasse Tyson',
    '46. Homo Deus - Noah Yuval Harari',
    '47. The First 20 Hours - Josh Kaufman',
    '48. Zero to One - Peter Thiel',
    '49. Courage is Calling - Ryan Holiday',
    '50. Who Moved My Cheese? - Spencer Johnson',
    '51. TED Talks - Chris Anderson',
    '52. The Practice - Seth Godin',
    '53. Freakonomics - Stephen Dubner & Steven Levitt',
    '54. The Art of Resilience - Ross Edgley',
    '55. The \$100 Startup - Chris Guillebeau',
    '56. Making Money Made Simple - Noel Whittaker',
    '57. The 80/20 Principle - Richard Koch',
    '58. The Checklist Manifesto - Atul Gawande',
    '59. Breath - James Nestor',
    '60. Eat that Frog - Brian Tracy',
    '61. Tiny Habits - BJ Fogg',
    '62. The Compound Effect - Darren Hardy',
    '63. The Willpower Instinct - Kelly McGonigal',
    '64. Tao Te Ching - Lao Tzu',
    '65. Digital Minimalism - Cal Newport',
    '66. Losing My Virginity - Richard Branson',
    '67. Give and Take - Adam Grant',
    '68. Daring Greatly - Brene Brown',
    '69. The 4 Hour Work Week - Tim Ferris',
    '70. The Wim Hof Method - Wim Hof',
    '71. Why We Sleep - Matthew Walker',
    '72. The Hungry Brain - Stephan Guyenet',
    '73. When Breath Becomes Air - Paul Kalanithi',
    '74. A Guide to the Good Life - William Irvine',
    '75. Greenlights - Matthew McConaughey',
    '76. 21 Lessons for the 21st Century - Noah Harari',
    '77. The Creative Destruction of Medicine - Eric Topol',
    '78. The Patient Will See You Now - Eric Topol',
    '79. Deep Medicine - Eric Topol',
    '80. Getting Things Done - David Allen',
    '81. Do Epic Shit - Ankur Warikoo',
    '82. Make Your Bed - William McRaven',
    '83. Ultramarathon Man - Dean Karnazes',
    '84. A Runner\'s High - Dean Karnazes ',
    '85. Better - Atul Gawande',
    '86. The God Equation - Michio Kaku',
    '87. Relativity - Albert Einstein',
    '88. Outliers - Malcolm Gladwell',
    '89. Tools of Titans - Tim Ferris',
    '90. The Oxygen Advantage - Patrick McKeown',
    '91. First, Break All the Rules - Marcus Buckingham & Curt Coffman',
    '92. The Happiness Advantage - Shawn Achor',
    '93. Why Buddhism is True - Robert Wright',
    '94. A Short History of Nearly Everything - Bill Bryson',
    '95. The Science of Interstellar - Kip Thorne',
    '96. Until the End of Time - Brian Greene',
    '97. The Everything Store - Brad Stone',
    '98. The Black Swan - Nassim Nicholas Taleb',
    '99. One Small Step Can Change Your Life - Robert Maurer',
    '100. Retirement Made Simple - Noel Whittaker',
  ];

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: appDrawer,
      appBar: const CustomAppBar(id: '/books'),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: kPadding,
                child: const Text(
                  'Top 100 Books',
                  style: headingStyle,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                padding: kPadding,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        bookList[index],
                        style: bodyStyle,
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
