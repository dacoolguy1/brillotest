import 'package:brillotest/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String id = 'Homepage';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      appBar: AppBar(
        title: Text('Sports Network'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff0057C1)),
              onPressed: () {
                // TODO: implement create profile
              },
              child: Text('Create Profile'),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff0057C1)),
              onPressed: () {
                // TODO: implement find people
              },
              child: Text('Find People'),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xff0057C1)),
              onPressed: () {
                // TODO: implement record event
              },
              child: Text('Record Event'),
            ),
          ),
        ],
      ),
    );
  }
}
