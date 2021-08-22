import 'package:flap_bot/UI/start.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<Introduction> {
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
        title: "Demarage rapide avec FlatBot UY1",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  child: Text("FlatBot est votre agent conversationnel qui vous donne toutes les informations très utiles concernant Université de Yaounde I",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Google Sans",
                      // letterSpacing: 0.8,
                    ),)),
            ),
          ],
        ),
        image: Image.asset("assets/chat_logo.png")
    ),
    PageViewModel(
      title: "Info sur les procédures inscription/pré-inscription",
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
                child: Text("Poser vos questions à FlatBot afin de bénéficier de toutes les informations relatives sur les procédures d'inscription/pré-inscription à Université de Yaoundé I",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Google Sans",
                     // letterSpacing: 0.8,
                    ),)),
          ),
        ],
      ),
      image: Image.asset("assets/chatvec1.png")
    ),
    PageViewModel(
        title: "Localiser rapidement les institutions de UY1",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  child: Text("Diriger rapidement vers un emplacement précis de UY1 à travers les liens Map que FlatBot vous retournera",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Google Sans",
                      // letterSpacing: 0.8,
                    ),)),
            ),
          ],
        ),
        image: Image.asset("assets/vect2.jpg")
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: "Demarrage rapide avec FlatBot UY1",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      child: Text("FlatBot est votre agent conversationnel qui vous donne toutes les informations très utiles concernant Université de Yaounde I",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Google Sans",
                          // letterSpacing: 0.8,
                        ),)),
                ),
              ],
            ),
            image: Image.asset("assets/girl.jpg")
        ),
        PageViewModel(
            title: "Info sur les procédures inscription/pré-inscription",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      child: Text("Poser vos questions à FlatBot afin de bénéficier de toutes les informations relatives sur les procédures d'inscription/pré-inscription à Université de Yaoundé I",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Google Sans",
                          // letterSpacing: 0.8,
                        ),)),
                ),
              ],
            ),
            image: Image.asset("assets/chatvec1.png")
        ),
        PageViewModel(
            title: "Localiser rapidement les institutions de UY1",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      child: Text("Diriger rapidement vers un emplacement précis de UY1 à travers les liens Map que FlatBot vous retournera",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Google Sans",
                          // letterSpacing: 0.8,
                        ),)),
                ),
              ],
            ),
            image: Image.asset("assets/vect2.jpg")
        ),

      ],
      onDone: () async {
        // When done button is press
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("firstload", true);
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => StartPage()
            )
        );
      },
      onSkip: () {
        // You can also override onSkip callback
      },
      showSkipButton: true,
      skip: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColorDark
        ),
        child: const Icon(Icons.skip_next,color: Colors.white,),
      ),
      next: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).accentColor
        ),
        child: const Icon(Icons.navigate_next,color: Colors.white,),
      ),
      done: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).accentColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Terminer", style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Google Sans')),
          )),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).accentColor,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
