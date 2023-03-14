import 'package:brillotest/PreScreens/verificationpage.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is the route : ${settings.name}');

    switch (settings.name) {
      // if the selected routename then return that route
      case verificationCode.id:
        return verificationCode.route('ss', 'dd');
      // case HomeScreen.routeName:
      //   return HomeScreen.route();
      // case CartScreen.routeName:
      //   return CartScreen.route();

      default:
        return _errorRoute();
    }
  }
  // Splashscreen.id: (context) => Splashscreen(),
  //             Signin.id: (context) => Signin(),
  //             signupScreen.id: (context) => signupScreen(),
  //             'SplashScreen2': (context) => const Signin(),
  //             verificationCode.id: (context) => verificationCode(),
  //             Homepage.id: (context) => Homepage(),
  //             tenantorraltor.id: (context) => tenantorraltor(),
  //             setProfile.id: (context) => setProfile(),
  //             tenantHomeFeatures.id: (context) => tenantHomeFeatures(),
  //             availableRealtor.id: (context) => availableRealtor(),
  //             realtorFound.id: (context) => realtorFound(),
  //             AgentProfile.id: (context) => AgentProfile()

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text('Error')),
            ));
  }
}
