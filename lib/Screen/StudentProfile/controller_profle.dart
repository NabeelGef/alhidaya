//import 'dart:async';
import 'dart:io';

class ControllerProfile {
  File? image;
  File? get getImage => this.image;
  //StreamController<File?> controller = StreamController<File>();
  //Stream<File?> get onValueChanged => controller.stream;
  void updateValue(File? newImage) {
    image = newImage;
  }
}
