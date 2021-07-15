import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import '../UI/round_input.dart';
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
  String _text = 'Press the button and start speaking';
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

  // use voice recongnisation
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print(_text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
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
          !_showMic?GestureDetector(
            onTap: _handleSubmittedLocal,
            child: AvatarGlow(
              animate: _isListening,
              glowColor: Theme.of(context).primaryColorDark,
              endRadius: 45.0,
              duration: const Duration(milliseconds: 2000),
              repeatPauseDuration: const Duration(milliseconds: 100),
              repeat: true,
              child: FloatingActionButton(
                onPressed: _listen,
                child: Icon(_isListening ? Icons.mic : Icons.mic_none),
              ),
            ),
          ):Icon(Icons.animation),
        ],
      ),
    );
  }
}
