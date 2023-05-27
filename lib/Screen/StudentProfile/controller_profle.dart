//import 'dart:async';
import 'dart:async';
import 'dart:io';

class ControllerProfile {
  File? image;
  File? get getImage => this.image;
  int point = 0;
  StreamController<int> controller = StreamController<int>();
  Stream<int> get onValueChanged => controller.stream;
  //StreamController<File?> controller = StreamController<File>();
  //Stream<File?> get onValueChanged => controller.stream;
  void updateValue(File? newImage) {
    image = newImage;
  }
  void setterPoint(int point){
    this.point = point;
    controller.add(point);
  }
  void addPoint(){
    point++;
    controller.add(point);
  }
  void minusPoint(){
    point--;
    controller.add(point);
  }
}
