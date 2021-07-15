import 'package:flap_bot/home/home.dart';
import 'package:flutter/material.dart';


class Dummy extends StatefulWidget {
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  void initState() {
    super.initState();

    isUserLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Empty Screen
    );
  }

  isUserLogin(){
    /*FirebaseAuth.instance.currentUser().then(
      (currentUser){
        if(currentUser != null){
          gotoHome();
        }
        else{
          gotoStartPage();
        }
      }
    );*/
  }

  gotoHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Home())
    );
  }

  gotoStartPage(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Home())
    );
  }
}