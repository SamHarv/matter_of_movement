import 'package:flutter/material.dart';
import 'package:matterofmovement/providers/favourite_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_appbar.dart';

final Uri _url = Uri.parse('https://oxygentech.com.au');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

//async after _sendMail()
void _sendEmail() {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'oxygentech@protonmail.com',
  );
  launchUrl(emailLaunchUri);
  //await before launchUrl
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
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
      appBar: const CustomAppBar(
        id: '/about',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: kPadding,
                child: Text(
                  'About',
                  textAlign: TextAlign.center,
                  style: headingStyle,
                ),
              ),
              Container(
                padding: kPadding,
                child: Text(
                  'A public jounral of what I perceive to be the more valuable of my ideas.\n\n'
                  'Why Matter of Movement?\n\n'
                  'I initially created this webpage to write about movement as it pertains to exercise and physical activity.\n\n'
                  'I now realise that my interests are far broader.\n\n'
                  'To enable me to write about whatever I want, here is my justification for continued use of the name:\n\n'
                  'A complete cessation of movement is death, therefore life consists of continuous movement.\n\n'
                  'Matters of movement are matters of life.',
                  style: bodyStyle,
                ),
              ),
              const Divider(),
              Container(
                padding: kPadding,
                child: Text(
                  'Contact',
                  textAlign: TextAlign.center,
                  style: headingStyle,
                ),
              ),
              Container(
                padding: kPadding,
                child: Column(
                  children: [
                    Text(
                      'Sam Harvey\n\n'
                      'Oxygen Tech\n',
                      textAlign: TextAlign.center,
                      style: bodyStyle,
                    ),
                    TextButton(
                      onPressed: _sendEmail,
                      child: Text(
                        'oxygentech@protonmail.com\n',
                        style: bodyStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: _launchUrl,
                      child: Text(
                        'oxygentech.com.au',
                        style: bodyStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                child: Padding(
                  padding: kPadding,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/sam.jpeg',
                    ),
                    radius: 100,
                  ),
                ),
              ),
              SizedBox(
                width: mediaWidth <= 750 ? mediaWidth * 0.8 : mediaWidth * 0.4,
                child: Padding(
                  padding: kPadding,
                  child: Image.asset(
                    fullLogo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
