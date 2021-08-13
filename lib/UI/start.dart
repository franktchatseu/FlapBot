import 'package:firebase_auth/firebase_auth.dart';
import 'package:flap_bot/chat_list/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  // sig
  Future<dynamic> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);
    //return await FirebaseAuth.instance.signInWithCredential(credential);
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
            "Welcome to FLAP BOT UY1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 27.0,
              fontFamily: 'Google Sans'
            ),
          ),
          SizedBox(height: 20.0,),
          InkWell(
            onTap: (){
              print("ds");
              signInWithGoogle();
            },
            child: Container(
                width: MediaQuery.of(context).size
                    .width/2 +20,
                height: MediaQuery.of(context).size.height/18,
                margin: EdgeInsets.only(top: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:Colors.white
                ),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/google.jpg'),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text('Sign in with Google',
                          style: TextStyle(
                            fontFamily: 'Google Sans',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                      ],
                    )
                )
            ),
          ),
        ],
      ),
    );
  }

  gotoLogin(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StartPage()
        )
    );
  }
  gotoConversation(){
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatRoom()
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