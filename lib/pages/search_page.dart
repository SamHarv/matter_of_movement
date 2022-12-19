import 'package:flutter/material.dart';

import '../main.dart';

import '../widgets/app_drawer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: thirdColor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: thirdColor,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: thirdColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: secondaryColor,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  hintText: 'Search...',
                  //todo input search functionality
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Search functionality is under construction.\n\n'
                  'Please check back soon.',
                  style: TextStyle(
                    fontSize: 20,
                    color: secondaryColor,
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
