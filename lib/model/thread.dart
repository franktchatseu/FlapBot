import 'package:meta/meta.dart';

class Thread {
  final bool fromSelf;
  final String message;
  bool showVoice = true;

  Thread({@required bool fromSelf, @required String message,this.showVoice})
      : fromSelf = fromSelf ?? true,
        message = message ?? '';
}
