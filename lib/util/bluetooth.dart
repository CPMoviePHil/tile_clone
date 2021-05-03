import 'dart:async';

import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:flutter_blue/flutter_blue.dart' as fBlue;

class BlueTooth {

  final StreamController<BlueScanResult> fBlueController;
  final List<String> fBlueStack;

  BlueTooth({
    required this.fBlueController,
    required this.fBlueStack,
  });

  fBlue.FlutterBlue flutterBlue = fBlue.FlutterBlue.instance;

  Stream<BlueScanResult> get fBlueStream => fBlueController.stream;

  startScan() async {
    print("fBlueStack:$fBlueStack");
    print("controller:${fBlueController.hashCode}");
    flutterBlue.startScan(
      timeout: Duration(seconds: 4,),
      scanMode: BlueScanSetting.mode == null
          ? fBlue.ScanMode.lowLatency
          : BlueScanSetting.modes[BlueScanSetting.mode!].mode,
    );

    flutterBlue.scanResults.listen((results) {
      for (fBlue.ScanResult result in results) {
        if (BlueScanSetting.maxRssi != null && BlueScanSetting.minRssi != null) {
          if (result.rssi > BlueScanSetting.minRssi! && result.rssi < BlueScanSetting.maxRssi!) {
            addScanDevice(deviceID: result.device.id.id, deviceName: result.device.name,);
          }
        }
        if (BlueScanSetting.maxRssi == null && BlueScanSetting.minRssi == null) {
          addScanDevice(deviceID: result.device.id.id, deviceName: result.device.name,);
        }
      }
    });
  }

  void addScanDevice ({
    required String deviceID,
    required String deviceName,
  }) {
    if (!fBlueStack.contains(deviceID)) {
      print("deviceID:$deviceID");
      fBlueStack.add(deviceID);
      fBlueController.add(
        BlueScanResult(
          deviceID: deviceID,
          deviceName: deviceName,
        ),
      );
    }
  }

  stopScan() {
    flutterBlue.stopScan();
    /*fBlueController.close();*/
  }

}

class BlueScanResult {

  final String deviceID;
  final String deviceName;

  BlueScanResult({
    required this.deviceID,
    required this.deviceName,
  });
}