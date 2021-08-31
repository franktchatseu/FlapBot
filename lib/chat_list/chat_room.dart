import 'package:flap_bot/UI/start.dart';
import 'package:flap_bot/chat_list/chat_room_app_bar.dart';
import 'package:flap_bot/chat_list/chat_thread.dart';
import 'package:flap_bot/chat_list/send_message_bar.dart';
import 'package:flap_bot/model/thread.dart';
import 'package:flap_bot/voice_record/text-to-speech.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        builder: Builder(
          builder: (context)=>ChatRoom(),
        )
    );
  }
}


class ChatRoom extends StatefulWidget {
  static bool isbotAlreadyWrite = false;

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
  final List<dynamic> _chatThreads = [];
  String WelcomeMessage = "Salut moi c'est FlapBot UY1 je suis à ta disposition.  As tu besoin des informations liées aux procédures de préinscriptions, locations des lieux de UY1, obtention d'une chambre d'étudiant,...?";
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();


  ChatThread _buildChatThread(Thread thread) {
    final ct = ChatThread(
      thread,
      AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 250),
      ),
    );

    return ct;
  }

  Widget _buildMessageDisplay() {
    return ListView.builder(
      itemCount: _chatThreads.length,
      reverse: true,
      itemBuilder: (context, index) {
        final ct = _chatThreads.reversed.toList()[index];

        return Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            ct,
          ],
        );
      },
    );
  }
  void _handleSubmitted(Thread message) {
    final ct = _buildChatThread(Thread(
      fromSelf: message.fromSelf,
      message: message.message,
      showVoice: true
    ));

    setState(() {
      _chatThreads.add(ct);
    });

    ct.animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    final threads = [
      Thread(fromSelf: true, message: "Salut je viens d'arriver à l'université et j'aimerais savoir comment m'y prendre"),
      // Thread(fromSelf: false, message: "👋 Salut moi c'est FlapBot UY1 je suis à ta disposition.  As tu besoin des informations liées aux procédures de préinscriptions, locations des lieux de UY1, obtention d'une chambre d'étudiant,...? ",showVoice: false),
      Thread(fromSelf: false, message: "Je suis à toi. Quelle est ta préoccupation?",showVoice: true),

    ];

    threads.forEach((thread) {
      final ct = _buildChatThread(thread);
      _chatThreads.add(ct);
      ct.animationController.forward();
    });
    final other = _buildChatThread(Thread(fromSelf: false, message: WelcomeMessage,showVoice: false));
    _chatThreads.insert(1,
        Row(
          children: [
            other,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Showcase(
                  key: _two,
                  description: "Cliquez sur l'icone en vert pour écouter Flapbot",
                  child: TextToSpeech(WelcomeMessage,withButton: 1,),
                ),
                SizedBox(height: 10,),
                Showcase(
                  key: _three,
                  description: "Augmenter la vitesse de lecture 😊",
                  child: TextToSpeech("message",withButton: 2,),
                ),
              ],
            )
          ],
        )
    );
    other.animationController.forward();
    displayShowcase().then((status) {
      if (status) {
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            ShowCaseWidget.of(context)
                .startShowCase([_one, _two, _three, _four, _five]));
      }
    });


  }


  SharedPreferences preferences;

  displayShowcase() async {
    preferences = await SharedPreferences.getInstance();
    bool showcaseVisibilityStatus = preferences.getBool("showShowcase");

    if (showcaseVisibilityStatus == null) {
      preferences.setBool("showShowcase", false).then((bool success) {
        if (success)
          print("Successfull in writing showshoexase");
        else
          print("some bloody problem occured");
      });

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildChatRoomAppBar(Icon(Icons.person), 'FlapBot UY1',ChatRoom.isbotAlreadyWrite),
      drawer: Drawer(

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Theme.of(context).primaryColor,Theme.of(context).primaryColorDark])
                  ),
                  child: Center(
                    child: Container(
                      height: 140,
                      width: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          image: DecorationImage(
                            fit:BoxFit.cover,
                            image: NetworkImage("https://us.123rf.com/450wm/klauts/klauts1007/klauts100700010/7319401-cute-illustration-of-a-smiling-woman.jpg?ver=6"),
                          )
                      ),
                    )
                  )
              ),
              ListTile(
                leading: Icon(Icons.contact_page_outlined,color: Theme.of(context).primaryColor,),
                title: Text('About us',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontFamily: 'Google Sans'),),
                onTap: () {
                  //deconnection();
                },
              ),
              ListTile(
                leading: Icon(Icons.phone,color: Theme.of(context).primaryColor,),
                title: Text('Contact Us',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontFamily: 'Google Sans'),),
                onTap: () {
                  //deconnection();
                },
              ),
              ListTile(
                leading: Icon(Icons.help,color: Theme.of(context).primaryColor,),
                title: Text('Help',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontFamily: 'Google Sans'),),
                onTap: () {
                  //deconnection();
                },
              ),
              ListTile(
                leading: Icon(Icons.logout,color: Theme.of(context).primaryColor,),
                title: Text('Déconnexion',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontFamily: 'Google Sans'),),
                onTap: () {
                  signup();
                },
              ),
            ],
          )),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildMessageDisplay(),
            ),
            Showcase(
                key: _one,
                description: 'Taper sur le micro et poser votre question en parlant',
                contentPadding: EdgeInsets.all(6.0),
                showcaseBackgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
                shapeBorder: CircleBorder(),
                child: SendMessageBar(_handleSubmitted)),
          ],
        ),
      ),
    );
  }

  void signup() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.clear();
    if(Navigator.canPop(context)){
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => StartPage()
          )
      );
    }
  }

  @override
  void dispose() {
    _chatThreads.forEach((ct) {
      ct.animationController.dispose();
    });

    super.dispose();
  }
}


class KeysToBeInherited extends InheritedWidget {
  final GlobalKey cartIndicatorKey;
  final GlobalKey categoriesKey;
  final GlobalKey optionsKey;
  final GlobalKey searchKey;
  final GlobalKey nameKey;

  KeysToBeInherited({
    this.cartIndicatorKey,
    this.categoriesKey,
    this.optionsKey,
    this.nameKey,
    this.searchKey,
    Widget child,
  }) : super(child: child);

  static KeysToBeInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<KeysToBeInherited>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}