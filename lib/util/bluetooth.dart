import 'dart:async';

import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:flutter_blue/flutter_blue.dart' as fBlue;

final StreamController<BlueScanResult> fBlueController = StreamController.broadcast();
final List<String> fBlueStack = [];

class BlueTooth {

  fBlue.FlutterBlue flutterBlue = fBlue.FlutterBlue.instance;

  Stream<BlueScanResult> get fBlueStream => fBlueController.stream;

  startScan() async {
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
            addScanDevice(
              deviceID: result.device.id.id,
              deviceName: result.device.name,
              data: result.advertisementData,
            );
          }
        }
        if (BlueScanSetting.maxRssi == null && BlueScanSetting.minRssi == null) {
          addScanDevice(
            deviceID: result.device.id.id,
            deviceName: result.device.name,
            data: result.advertisementData,
          );
        }
      }
    });
  }

  void addScanDevice ({
    required String deviceID,
    required String deviceName,
    required fBlue.AdvertisementData data,
  }) {
    if (!fBlueStack.contains(deviceID)) {
      print("deviceID:$deviceID");
      fBlueStack.add(deviceID);
      fBlueController.add(
        BlueScanResult(
          deviceID: deviceID,
          deviceName: deviceName,
          data: data,
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
  final fBlue.AdvertisementData data;
  BlueScanResult({
    required this.deviceID,
    required this.deviceName,
    required this.data,
  });
}