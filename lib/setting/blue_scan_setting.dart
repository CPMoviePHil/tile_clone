import 'package:tile_blue/util/export.dart';
import 'package:flutter_blue/flutter_blue.dart' as fBlue;

class BlueScanSetting {

  static final BlueScanSetting _scanSetting = BlueScanSetting();

  factory BlueScanSetting() => _scanSetting;

  static int? mode;
  static int? maxRssi;
  static int? minRssi;
  static String? bleMac;
  static String? serverDomain;

  static final List<ScanModeItem> modes = [
    ScanModeItem(
      index: 0,
      scanModeText: '平衡',
      mode: fBlue.ScanMode.balanced,
    ),
    ScanModeItem(
      index: 1,
      scanModeText: '低耗能',
      mode: fBlue.ScanMode.lowPower,
    ),
    ScanModeItem(
      index: 2,
      scanModeText: '延遲低',
      mode: fBlue.ScanMode.lowLatency,
    ),
    ScanModeItem(
      index: 3,
      scanModeText: 'opportunistic',
      mode: fBlue.ScanMode.opportunistic,
    ),
  ];

}