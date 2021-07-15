import 'package:flutter/material.dart';

PreferredSizeWidget buildChatRoomAppBar(Widget avatar, String title) {
  final avatarRadius = 20.0;
  final defaultIconButtonPadding = 8.0;
  final leftOffset = -25.0;
  final titleLineHeight = 2.0;

  return AppBar(
    title: SizedBox(
      width: double.infinity,
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
            left: leftOffset + avatarRadius * 2 + 48.0,
            top: defaultIconButtonPadding,
            child: Text(title),
          ),
        ],
      ),
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
