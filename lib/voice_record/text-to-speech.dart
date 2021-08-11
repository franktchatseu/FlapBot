
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech extends StatefulWidget {
  String text;
  bool isPlaying = false;
  bool isFast = false;
  TextToSpeech(this.text);
  @override
  _TTSPluginRecipeState createState() => _TTSPluginRecipeState();
}

class _TTSPluginRecipeState extends State<TextToSpeech> {
  String description =
      "The Griffith Observatory is the most iconic building in Los Angeles, perched high in the Hollywood Hills, 1,134 feet above sea level.";

  FlutterTts _flutterTts;

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  initializeTts() async {
    _flutterTts = FlutterTts();

    setTtsLanguage();
    _flutterTts.setStartHandler(() {
      setState(() {
        widget.isPlaying = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        print("FINISH");
        widget.isPlaying = false;
      });
    });

    _flutterTts.setErrorHandler((err) {
      setState(() {
        print("error occurred: " + err);
        widget.isPlaying = false;
      });
    });
  }

  void setTtsLanguage() async {
    await _flutterTts.setLanguage("fr-FR");
  }

  void speechSettings1() {
   // _flutterTts.setVoice("en-us-x-sfg#male_1-local");
    _flutterTts.setPitch(1);
    if(widget.isFast){
      setState(() {
        _flutterTts.setSpeechRate(1);
      });
    }
    else{
      setState(() {
        _flutterTts.setSpeechRate(2);
      });
    }
    setState(() {
      widget.isFast = !widget.isFast;
    });
  }

  void speechSettings2() {
   // _flutterTts.setVoice("en-us-x-sfg#male_2-local");
    _flutterTts.setPitch(1);
    _flutterTts.setSpeechRate(0.5);
  }

  Future _speak(String text) async {
    if (text != null && text.isNotEmpty) {
      await _flutterTts.awaitSpeakCompletion(true).then((value){
        setState(() {
          widget.isPlaying = true;
        });
      });
      var result = await _flutterTts.speak(text);
      if (result == 1)
        setState(() {
          widget.isPlaying = false;
        });
    }

  }

  Future _stop() async {
    var result = await _flutterTts.stop();
    if (result == 1)
      setState(() {
        widget.isPlaying = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          playButton(context),
          SpeedButton(context)
        ],
      ),
    );
  }

  Widget playButton(BuildContext context) {
    return Container(

      child: FlatButton(
        onPressed: () {
          //fetch another image
          setState(() {
            //speechSettings1();
            widget.isPlaying ? _stop() : _speak(widget.text);
          });
        },
        child: widget.isPlaying
            ? Icon(
          Icons.stop,
          size: 27,
          color: Colors.red,
        )
            : Icon(
          Icons.play_arrow,
          size: 27,
          color: Colors.green,
        ),
      ),
    );
  }
  Widget SpeedButton(BuildContext context) {
    return Container(

      child: FlatButton(
        onPressed: () {
          //fetch another image
          setState(() {
            //speechSettings1();
            speechSettings1();
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left:7),
          child: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                size: 20,
                color: Color(0xFF3c8fd5),
              ),
              Text(widget.isFast?"x1":"x2",style: TextStyle(fontFamily: 'Google Sans',color: Colors.amber,fontWeight: FontWeight.bold,fontSize: 13),)
            ],
          ),
        )
      ),
    );
  }
}