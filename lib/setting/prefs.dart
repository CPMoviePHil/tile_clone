import 'dart:convert';

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
    print(mode.index);
    preferences.setString("scanMode", json.encode(mode.index));
    preferences.setInt("maxRssi", maxRssi,);
    preferences.setInt("maxRssi", minRssi,);
    preferences.setString('bleMac', bleMac,);
  }

}