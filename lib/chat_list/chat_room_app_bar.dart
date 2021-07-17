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
                child: CircleAvatar(
                  radius: avatarRadius,
                  child: avatar,
                ),
              ),
              Positioned(
                left: leftOffset + avatarRadius * 2 + 32.0,
                top: defaultIconButtonPadding,
                child: Text(title),
              ),
            ],
          ),
        ),
    ChatRoom.isbotAlreadyWrite==true?Padding(
          padding: const EdgeInsets.only(left:45.0),
          child: Text("Flapbot est entrain d'ecrire ...", style: TextStyle(fontSize: 10),)
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
