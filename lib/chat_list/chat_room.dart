import 'package:flap_bot/UI/start.dart';
import 'package:flap_bot/chat_list/chat_room_app_bar.dart';
import 'package:flap_bot/chat_list/chat_thread.dart';
import 'package:flap_bot/chat_list/send_message_bar.dart';
import 'package:flap_bot/login_screen.dart';
import 'package:flap_bot/model/thread.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatRoom extends StatefulWidget {
  static bool isbotAlreadyWrite = false;

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
  final List<ChatThread> _chatThreads = [];


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
    ));

    setState(() {
      _chatThreads.add(ct);
    });

    ct.animationController.forward();
  }

  @override
  void initState() {
    final threads = [
      Thread(fromSelf: false, message: '/start'),

    ];

    threads.forEach((thread) {
      final ct = _buildChatThread(thread);
      _chatThreads.add(ct);
      ct.animationController.forward();
    });

    super.initState();
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
            SendMessageBar(_handleSubmitted),
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
              builder: (context) => LoginScreen()
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
