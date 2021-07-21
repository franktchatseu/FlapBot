import 'package:flap_bot/chat_list/chat_room.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget buildChatRoomAppBar(Widget avatar, String title,bool botWrite) {
  final avatarRadius = 20.0;
  final defaultIconButtonPadding = 8.0;
  final leftOffset = -25.0;
  final titleLineHeight = 2.0;


  return AppBar(
    toolbarHeight: 60,
    title: Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 40,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: defaultIconButtonPadding,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      image: DecorationImage(
                        fit:BoxFit.cover,
                        image: NetworkImage("https://us.123rf.com/450wm/klauts/klauts1007/klauts100700010/7319401-cute-illustration-of-a-smiling-woman.jpg?ver=6"),
                      )
                  ),
                ),
              ),
              Positioned(
                left: leftOffset + avatarRadius * 2 + 32.0,
                top: defaultIconButtonPadding*2,
                child: Text(title),
              ),
            ],
          ),
        ),
    ChatRoom.isbotAlreadyWrite==true?Padding(
          padding: const EdgeInsets.only(left:8.0,top: 10,bottom: 10),
          child: Text("Flapbot est entrain d'ecrire ...", style: TextStyle(fontSize: 12),)
        ):Text(""),
      ],
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.phone),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {},
      ),
    ],
  );
}
