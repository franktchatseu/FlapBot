import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flap_bot/UI/round_input.dart';
import 'package:flap_bot/chat_list/chat_room.dart';
import 'package:flap_bot/model/thread.dart';
import 'package:flap_bot/services/chat_api.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SendMessageBar extends StatefulWidget {
  final ValueChanged<Thread> _handleSubmitted;

  SendMessageBar(this._handleSubmitted);

  @override
  _SendMessageBarState createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  final _textController = TextEditingController();
  bool _showMic = true;

  stt.SpeechToText _speech;
  bool _isListening = false;
  bool _botWrite = false;
  String _text = 'je ne comprends pas bien';
  double _confidence = 1.0;


  @override
  void initState(){
    super.initState();
    _speech = stt.SpeechToText();
  }

  _handleSubmittedLocal() {
    final text = _textController.text;

    // deal with local first
    _textController.clear();
    setState(() {
      _showMic = true;
    });

    // deal with parent later
    Thread message = new Thread(fromSelf: true, message: _text);
    widget._handleSubmitted(message);
  }
  // get response
  Future<void> _handleSubmitedServer1(String text) async {
    setState(() {
      this._botWrite = true;
      ChatRoom.isbotAlreadyWrite = true;
    });
    ChatApi _chatservice = new ChatApi();
    //send user text
    Thread message = new Thread(fromSelf: true, message: text);
    widget._handleSubmitted(message);
    _textController.clear();
    // get reponse to backend api
    final response = await _chatservice.getReponses(text);
    if (response.statusCode == 200) {
      var result = response.data;
      print(result);
      Thread message = new Thread(fromSelf: false, message: result["response"]);
      widget._handleSubmitted(message);
      _textController.clear();
      setState(() {
        _showMic = true;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text("Le système rencontre une erreur. Contactez l'administrateur svp"),
          ));
    }
    setState(() {
      this._botWrite = false;
      ChatRoom.isbotAlreadyWrite = false;

    });
  }
  void _handleChange(String text) {
    setState(() {
      _showMic = text.length == 0;
    });
  }

  sendMessageText(){
    final text = _textController.text;
    _handleSubmitedServer1(text);
  }

  sendMessageVoice(){
    if(!_text.isEmpty){
      Thread message = new Thread(fromSelf: true, message: _text);
      //widget._handleSubmitted(message);
      _handleSubmitedServer1(_text);
    }
    setState(() {
      this._send = false;
      _isListening = false;
      _text="";
    });
    _speech.stop();
  }
  bool _send = false;
  // use voice recongnisation
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val){
         print('onStatus: $val');
         if(val.toString()=="notListening"){
           setState(() => _send = true);
         }
        },
        onError: (val) => print('onError: $val'),

      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            //print(_text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }

    } else {
      setState((){
         _isListening = false;
         //widget._handleSubmitted(_text);
         //_text="";
      });
      print(_text);

      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RoundInput(
              textController: _textController,
              handleSubmitted: (String text) {
                _handleSubmittedLocal();
              },
              handleChange: _handleChange,
            ),
          ),

          _showMic?GestureDetector(
            onTap: _handleSubmittedLocal,
            child: AvatarGlow(
              animate: _isListening && _send==false,
              glowColor: Colors.teal.shade900,
              endRadius: 28.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: Container(
                height: 40,
                child: FloatingActionButton(
                  elevation: _isListening?45:0,
                  onPressed: _send == false?_listen: sendMessageVoice,
                  child: _send ==false?Icon(_isListening ? Icons.mic : Icons.mic_none):Icon(Icons.send),
                ),
              ),
            ),
          ):GestureDetector(
            onTap: this._botWrite==false? sendMessageText:null,
            child: CircleAvatar(
              child: Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}
