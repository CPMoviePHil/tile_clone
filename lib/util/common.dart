import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class ScanModeItem {
  final int index;
  final String scanModeText;
  final ScanMode mode;

  ScanModeItem({
    @required this.index,
    @required this.scanModeText,
    @required this.mode,
  });

}