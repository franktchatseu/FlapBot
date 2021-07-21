import 'package:flutter/material.dart';

class RoundInput extends StatelessWidget {
  final Color _color;
  final TextEditingController _textController;
  final ValueChanged<String> _handleSubmitted;
  final ValueChanged<String> _handleChange;

  RoundInput({
    @required TextEditingController textController,
    @required ValueChanged<String> handleSubmitted,
    ValueChanged<String> handleChange,
    color,
  })  : _textController = textController,
        _handleSubmitted = handleSubmitted,
        _handleChange = handleChange,
        _color = color ?? Color(0xFFf0f0f0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: _color,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 8.0,
              ),
              Icon(
                Icons.insert_emoticon,
                size: 30.0,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Poser votre question',
                    border: InputBorder.none,
                  ),
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: (String text) {
                    if (_handleChange == null) {
                      return;
                    }

                    _handleChange(text);
                  },
                ),
              ),
             /* Icon(
                Icons.attach_file,
                size: 30.0,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(
                width: 8.0,
              ),
              Icon(
                Icons.camera_alt,
                size: 30.0,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(
                width: 8.0,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
