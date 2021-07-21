import 'package:flap_bot/UI/clip_r_thread.dart';
import 'package:flap_bot/model/thread.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatThread extends StatelessWidget {
  final Thread thread;
  final AnimationController animationController;
  // controller to be initialized by parent
  // so that parent can have control over when to animate

  ChatThread(this.thread, this.animationController);
  @override
  Widget build(BuildContext context) {
    Widget child;

    if (thread.fromSelf == true) {
      child = Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _RightThread(
              thread.message,
              backgroundColor: Theme.of(context).indicatorColor,
            ),
          ],
        ),
      );
    } else {
      child = Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _LeftThread(
              thread.message,
              backgroundColor: Color(0xFFfff3e0),
            ),
          ],
        ),
      );
    }

    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

class _LeftThread extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final double r;
  final Color chatLeftThread = Color(0xFFf0f0f0);

  _LeftThread(this.message,
      {this.r = 2.5, this.backgroundColor = Colors.white});
  void _launchURL(String _url) async =>
      await canLaunch(Uri.encodeFull(_url)) ? await launch(Uri.encodeFull(_url)) : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClipRThread(r),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(r)),
        child: Container(
          constraints: BoxConstraints.loose(MediaQuery.of(context).size * 0.8),
          padding: EdgeInsets.fromLTRB(8.0 + 2 * r, 8.0, 8.0, 8.0),
          color: this.chatLeftThread,
          child: Linkify(
            text: message,
            style: TextStyle(
              color: Color(0xFF353535),
              fontFamily: 'Google Sans'
            ),
            onOpen: (link)  {
              print("Linkify link = ${link.url}");
              print(link.url);
              _launchURL(link.url);
            },
            options: LinkifyOptions(humanize: false),
            softWrap: true,
          )
        ),
      ),
    );
  }
}

class _RightThread extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final double r;
  final Color chatRightThread = Color(0xFF3c8fd5);
  _RightThread(this.message,
      {this.r = 2.5, this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    final clipped = ClipPath(
      clipper: ClipRThread(r),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(r)),
        child: Container(
          constraints: BoxConstraints.loose(MediaQuery.of(context).size * 0.8),
          padding: EdgeInsets.fromLTRB(8.0 + 2 * r, 8.0, 8.0, 8.0),
          color: chatRightThread,
          child: Transform(
            transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
            child: Text(
              this.message,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                  fontFamily: 'Google Sans'
              ),
            ),
            alignment: Alignment.center,
          ),
        ),
      ),
    );
    return Transform(
      transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
      child: clipped,
      alignment: Alignment.center,
    );
  }
}
