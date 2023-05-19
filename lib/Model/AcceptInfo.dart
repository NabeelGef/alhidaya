import 'dart:async';

class AcceptInfo {
  bool isAccept = false;
  StreamController<bool> _controller = StreamController<bool>();
  Stream<bool> get onValueChanged => _controller.stream;

  void updateValue() {
    isAccept = true;
    _controller.add(isAccept);
  }
}
