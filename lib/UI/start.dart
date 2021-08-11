import 'package:flap_bot/chat_list/chat_room.dart';
import 'package:flap_bot/login_screen.dart';
import 'package:flap_bot/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String assetName = 'assets/chat_logo.png';
  int color = 0xff5521;

  @override
  void initState() {
    //checkIfUserLoggedIn();
    super.initState();
  }

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
              fontSize: 30.0,
              fontFamily: 'Google Sans'
            ),
          ),
          SizedBox(height: 20.0,),
          InkWell(
            onTap: checkIfUserLoggedIn,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("START CONVERSATION",style: TextStyle(fontFamily: 'Google Sans',fontSize: 17,fontWeight: FontWeight.w600),),
              ) ,
            ),
          ),
        ],
      ),
    );
  }

  gotoLogin(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginScreen()
        )
    );
  }
  gotoSignup(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Splash()
        )
    );
  }

  // check if user is already connect
  checkIfUserLoggedIn()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool userLoggedIn  = (_prefs.getString('email')!=null?true:false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChatRoom()));

    /*if(userLoggedIn==true){
      print(_prefs.getString('email'));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChatRoom()));
    }else{
      gotoSignup();
    }*/

  }

}