import 'package:firebase_auth/firebase_auth.dart';
import 'package:flap_bot/View_Model/sign_in_view_model.dart';
import 'package:flap_bot/auth/phone-auth.dart';
import 'package:flap_bot/chat_list/chat_room.dart';
import 'package:flap_bot/utils/routeNames.dart';
import 'package:flap_bot/utils/view_state.dart';
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
  FirebaseUser _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
   bool loginstatus = false;

  bool isSignIn =false;
  bool google =false;
  @override
  void initState() {
    checkIfUserLoggedIn();
    super.initState();
  }
  Future<FirebaseUser> signInWithGoogle() async {
    setState(() {
      this.loginstatus = true;
    });
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication googleSignInAuthentication =

    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(

      accessToken: googleSignInAuthentication.accessToken,

      idToken: googleSignInAuthentication.idToken,

    );

    setState(() {
      this.loginstatus = false;
    });
    AuthResult authResult = await _auth.signInWithCredential(credential);

    _user = authResult.user;

    assert(!_user.isAnonymous);

    assert(await _user.getIdToken() != null);

    FirebaseUser currentUser = await _auth.currentUser();

    assert(_user.uid == currentUser.uid);


    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");
    // save user credential
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("email",_user.displayName );
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
              signInWithGoogle()
                  .then((FirebaseUser user){

                Navigator.of(context).pushNamedAndRemoveUntil
                  (RouteName.Home, (Route<dynamic> route) => false
                );}
              ).catchError((e) => print(e));
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
                        this.loginstatus==false?Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage('assets/google.jpg'),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        ):CircularProgressIndicator(),
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
          SizedBox(height: 20.0,),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PhoneAuthPage()
                  )
              );
            },
            child: Container(
              height: 40,
              width: 215,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  "Par numéro de télephone",
                  style: TextStyle(
                      fontFamily: 'Google Sans',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
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
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChatRoom()));
    if(userLoggedIn==true){
      print(_prefs.getString('email'));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ChatRoom()));
    }

  }



}