import 'package:flap_bot/chat_list/chat_room_app_bar.dart';
import 'package:flap_bot/chat_list/chat_thread.dart';
import 'package:flap_bot/chat_list/send_message_bar.dart';
import 'package:flap_bot/model/thread.dart';
import 'package:flutter/material.dart';


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
      Thread(fromSelf: false, message: 'Bonjour Frank!'),
      Thread(fromSelf: false, message: 'Que puis je faire pour vous?'),
      Thread(fromSelf: true, message: 'Comment faire pour ce preincrire à UY1?'),
      Thread(fromSelf: false, message: 'il vous suffit juste de ... ?'),
      Thread(fromSelf: true, message: 'Merci'),
      Thread(fromSelf: false, message: 'Bonjour Frank!'),
      Thread(fromSelf: false, message: 'Que puis je faire pour vous?'),
      Thread(fromSelf: true, message: 'Où se trouve le departement informatique?'),
      Thread(fromSelf: false, message: 'tres simple. dirige toi vers ... ?'),
      Thread(fromSelf: true, message: 'tu es un genie'),
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
      backgroundColor: Color(0xFFECE5DD),
      appBar: buildChatRoomAppBar(Icon(Icons.person), 'FlapBot UY1',ChatRoom.isbotAlreadyWrite),
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

  @override
  void dispose() {
    _chatThreads.forEach((ct) {
      ct.animationController.dispose();
    });

    super.dispose();
  }
}
