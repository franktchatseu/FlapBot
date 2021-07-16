import 'package:avatar_glow/avatar_glow.dart';
import 'package:flap_bot/UI/round_input.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SendMessageBar extends StatefulWidget {
  final ValueChanged<String> _handleSubmitted;

  SendMessageBar(this._handleSubmitted);

  @override
  _SendMessageBarState createState() => _SendMessageBarState();
}

class _SendMessageBarState extends State<SendMessageBar> {
  final _textController = TextEditingController();
  bool _showMic = true;

  stt.SpeechToText _speech;
  bool _isListening = false;
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
    widget._handleSubmitted(text);
  }

  void _handleChange(String text) {
    setState(() {
      _showMic = text.length == 0;
    });
  }
  sendMessage(){
    if(!_text.isEmpty){
      widget._handleSubmitted(_text);
    }
    setState(() {
      this._send = false;
      _isListening = false;
      _text="";
    });
    _speech.stop();
    print("ss");
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
          SizedBox(
            width: 5.0,
          ),
          _showMic?GestureDetector(
            onTap: _handleSubmittedLocal,
            child: AvatarGlow(
              animate: _isListening && _send==false,
              glowColor: Theme.of(context).primaryColorDark,
              endRadius: 45.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                onPressed: _send == false?_listen: sendMessage,
                child: _send ==false?Icon(_isListening ? Icons.mic : Icons.mic_none):Icon(Icons.send),
              ),
            ),
          ):GestureDetector(
            onTap: _handleSubmittedLocal,
            child: CircleAvatar(
              child: Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}
