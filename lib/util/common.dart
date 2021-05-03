import 'package:flutter_blue/flutter_blue.dart' as fBlue;

class ScanModeItem {
  final int index;
  final String scanModeText;
  final fBlue.ScanMode mode;

  ScanModeItem({
    required this.index,
    required this.scanModeText,
    required this.mode,
  });
}