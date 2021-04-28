import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:tile_blue/util/export.dart';

class BlueScanSetting {

  static final BlueScanSetting _scanSetting = BlueScanSetting();

  factory BlueScanSetting() => _scanSetting;

  static int mode;
  static int maxRssi;
  static int minRssi;
  static String bleMac;

  static final List<ScanModeItem> modes = [
    ScanModeItem(
      index: 0,
      scanModeText: '平衡',
      mode: ScanMode.balanced,
    ),
    ScanModeItem(
      index: 1,
      scanModeText: '低耗能',
      mode: ScanMode.lowPower,
    ),
    ScanModeItem(
      index: 2,
      scanModeText: '延遲低',
      mode: ScanMode.lowLatency,
    ),
    ScanModeItem(
      index: 3,
      scanModeText: 'opportunistic',
      mode: ScanMode.opportunistic,
    ),
  ];

}