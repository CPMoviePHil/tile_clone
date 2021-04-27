import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BlueScanSetting {

  static final BlueScanSetting _scanSetting = BlueScanSetting();

  factory BlueScanSetting() => _scanSetting;

  static ScanMode mode;
  static int maxRssi;
  static int minRssi;
  static String bleMac;

}