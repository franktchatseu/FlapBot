import 'package:flap_bot/UI/start.dart';
import 'package:flap_bot/introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GobalHomeScreen extends StatefulWidget {
  @override
  _GobalHomeScreenState createState() => _GobalHomeScreenState();
}



class _GobalHomeScreenState extends State<GobalHomeScreen> {

  @override
  void initState() {
    //checkIfUserLoggedIn();
    super.initState();
    fistload().then((value) {
      if(value){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => Introduction()
            )
        );
      }
      else{
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => StartPage()
            )
        );
      }
    });
  }

  bool isload;
  fistload() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isfirstload = pref.getBool("firstload");
    if(isfirstload==null){
     // pref.setBool("firstload", true);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    fistload().then((value) {
      if(value){
        return Introduction();
      }
      else{
        return StartPage();
      }
    });
    return Scaffold(body: Container(
      child: Center(child: CircularProgressIndicator(

      )),
    ));
  }
}
