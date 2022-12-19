import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

import '../widgets/app_drawer.dart';
import '../widgets/custom_appbar.dart';

final Uri _url = Uri.parse('https://google.com'); //this will be O2 Tech url

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
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: thirdColor,
      drawer: const AppDrawer(),
      appBar: const CustomAppBar(
        id: '/about',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'About',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'A public jounral of what I perceive to be the more valuable of my ideas.\n\n'
                  'Why Matter of Movement?\n\n'
                  'I initially created this webpage to write about movement as it pertains to exercise and physical activity.\n\n'
                  'I now realise that my interests are far broader.\n\n'
                  'To enable me to write about whatever I want, here is my justification for continued use of the name:\n\n'
                  'A complete cessation of movement is death, therefore life consists of continuous movement.\n\n'
                  'Matters of movement are matters of life.',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: secondaryColor,
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Contact',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Sam Harvey\n\n'
                      'Oxygen Tech\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: secondaryColor,
                      ),
                    ),
                    const TextButton(
                      onPressed: _sendEmail,
                      child: Text(
                        'oxygentech@protonmail.com\n',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 74, 173),
                        ),
                      ),
                    ),
                    const TextButton(
                      onPressed: _launchUrl,
                      child: Text(
                        'oxygentech.com.au (coming soon)',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 74, 173),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/sam.jpeg'),
                    radius: 100,
                  ),
                ),
              ),
              SizedBox(
                width: mediaWidth <= 750 ? mediaWidth * 0.8 : mediaWidth * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
