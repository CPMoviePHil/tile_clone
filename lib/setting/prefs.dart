import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {

  final SharedPreferences preferences;

  Prefs({
    this.preferences,
  });

  Future<void> saveSetting({
    ScanMode mode,
    int maxRssi,
    int minRssi,
    String bleMac,
  }) async {
    preferences.setString("scanMode", mode==null?'':mode.index.toString(),);
    preferences.setString("maxRssi", maxRssi.toString()??'',);
    preferences.setString("maxRssi", minRssi.toString()??'',);
    preferences.setString('bleMac', bleMac??'',);
  }

}