import 'package:flap_bot/chat_list/chat_room.dart';
import 'package:flap_bot/home/home.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String assetName = 'assets/chat_logo.png';
  int color = 0xff5521;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset(assetName , fit: BoxFit.contain,)
          ),
          SizedBox(height: 20.0,),
          Text(
            "Welcome to FLAP BOT",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0
            ),
          ),
          SizedBox(height: 20.0,),
          RaisedButton(
            padding: EdgeInsets.all(10),
            onPressed: () => gotoLogin(),
            color: Color(0xFFff5521),
            child: Text("ALREADY HAVE ACCOUNT"),
            textColor: Colors.white,
          ),
          RaisedButton(
            onPressed: () => gotoSignup(),
            child: Text("NEED A NEW ACCOUNT?"),
            color: Colors.white,
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  gotoLogin(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatRoom()
        )
    );
  }
  gotoSignup(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatRoom()
        )
    );
  }
}