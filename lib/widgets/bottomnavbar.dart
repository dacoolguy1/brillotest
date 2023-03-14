//import 'package:eronville/mainScreens/tenantexplore.dart';
import 'package:brillotest/MainScreens/profile.dart';
import 'package:brillotest/MainScreens/settings.dart';
import 'package:brillotest/PreScreens/register.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[50],
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/');
                },
                icon: Icon(
                  Icons.home,
                  color: Color(0xff0057C1),
                )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, UserProfile.id);
                },
                icon: Icon(Icons.person, color: Color(0xff0057C1))),
            IconButton(
                onPressed: () {
                  //Navigator.pushNamed(context, tenantExplore.id);
                },
                icon: Icon(Icons.people_alt_rounded, color: Color(0xff0057C1))),
            IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/');
                },
                icon: Icon(Icons.search, color: Color(0xff0057C1))),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingsPage.main);
                },
                icon: Icon(Icons.settings, color: Color(0xff0057C1)))
          ],
        ),
      ),
    );
  }
}
