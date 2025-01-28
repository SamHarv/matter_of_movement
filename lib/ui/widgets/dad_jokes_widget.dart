import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/config/constants.dart';

class DadJokeWidget extends StatefulWidget {
  /// Widget to display a random dad joke

  const DadJokeWidget({super.key});

  @override
  State<DadJokeWidget> createState() => _DadJokeWidgetState();
}

class _DadJokeWidgetState extends State<DadJokeWidget> {
  String currentJoke = 'Bear with me...'; // Default
  bool isLoading = true;

  // Headers for the HTTP request
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'User-Agent': 'Thoughts (https://github.com/SamHarv/thoughts)'
  };

  @override
  void initState() {
    super.initState();
    fetchRandomJoke(); // Fetch a random joke on widget creation
  }

  Future<void> fetchRandomJoke() async {
    /// Fetch a random dad joke from icanhazdadjoke API
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('https://icanhazdadjoke.com/'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          currentJoke = data['joke'];
        });
      } else {
        setState(() {
          currentJoke = 'Error: Have you tried turning it off and on again?';
        });
      }
    } catch (e) {
      setState(() {
        currentJoke = 'Error: Have you tried turning it off and on again?';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Copy the current joke to the user's clipboard
  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: currentJoke));
    if (context.mounted) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Joke copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding,
      decoration: BoxDecoration(
        border: Border.all(color: colour, width: 0.3),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dad Joke",
            textAlign: TextAlign.left,
            style: titleStyle,
          ),
          Row(
            children: [
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: colour,
                      ))
                    : Text(
                        currentJoke,
                        textAlign: TextAlign.left,
                        style: bodyStyle,
                      ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: const Icon(Icons.refresh, color: colour),
                    onPressed: fetchRandomJoke,
                    tooltip: 'Get new joke',
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: colour),
                    onPressed: _copyToClipboard,
                    tooltip: 'Copy joke',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
