import 'package:flap_bot/UI/start.dart';
import 'package:flap_bot/chat_list/chat_room.dart';
import 'package:flap_bot/home_screen.dart';
import 'package:flap_bot/login_screen.dart';
import 'package:flap_bot/splash.dart';
import 'package:flap_bot/utils/routeNames.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => StartPage());
      case RouteName.USER_LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteName.Home:
        return MaterialPageRoute(builder: (_) => ChatRoom());
      case RouteName.Home:
        return MaterialPageRoute(builder: (_) => ChatRoom());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                  Image.asset('assets/images/error.jpg'),
                  Text(
                    "${settings.name} does not exists!",
                    style: TextStyle(fontSize: 24.0),
                  )
                ],
              ),
            ),
          ),
        );
    }
  }
}


