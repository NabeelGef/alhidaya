import 'package:alhidaya/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedBase {
  static Future<Map<String, String?>> saveUserData(String name,
      String phoneNumber, String nameRing, String numberRing) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('nameRing', nameRing);
    await prefs.setString('numberRing', numberRing);
    return await getUserData();
  }

  static Future<void> editName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    data = await getUserData();
  }

  static Future<void> editNumberPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phone);
    data = await getUserData();
  }

  static Future<void> editNumberRing(String numberring) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('numberRing', numberring);
    data = await getUserData();
  }

  static Future<void> editNameRing(String nameRing) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nameRing', nameRing);
    data = await getUserData();
  }

  static Future<void> editPhoto(String photo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('photo', photo);
    data = await getUserData();
  }

  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final phoneNumber = prefs.getString('phoneNumber');
    final nameRing = prefs.getString('nameRing');
    final numberRing = prefs.getString('numberRing');
    var photo = prefs.getString('photo');
    if (photo != null && photo.isEmpty) {
      photo = null;
    }
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'nameRing': nameRing,
      'numberRing': numberRing,
      'photo': photo
    };
  }

  static Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
