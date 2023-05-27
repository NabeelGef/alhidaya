import 'dart:async';

class ControllerMyProfile {
  String? numberPhone;
  String? name;
  String? nameRing;
  String? numRing;
  ControllerMyProfile(this.name, this.numberPhone, this.nameRing, this.numRing);
  StreamController<String> controllerNameRing = StreamController<String>();
  Stream<String> get onValueNameRingChanged => controllerNameRing.stream;
  StreamController<String> controllerNumRing = StreamController<String>();
  Stream<String> get onValueNumRingChanged => controllerNumRing.stream;
  StreamController<String> controllerPhone = StreamController<String>();
  Stream<String> get onValuePhoneChanged => controllerPhone.stream;
  StreamController<String> controllerName = StreamController<String>();
  Stream<String> get onValueNameChanged => controllerName.stream;
  setterPhone(String newPhone) {
    numberPhone = newPhone;
    controllerPhone.add(numberPhone!);
  }

  setterName(String newName) {
    name = newName;
    controllerName.add(name!);
  }

  setterNameRing(String newRingName) {
    nameRing = newRingName;
    controllerNameRing.add(nameRing!);
  }

  setterNumRing(String newRingNumber) {
    numRing = newRingNumber;
    controllerNumRing.add(numRing!);
  }
}
