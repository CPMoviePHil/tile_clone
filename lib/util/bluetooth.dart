import 'dart:async';

import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:flutter_blue/flutter_blue.dart' as fBlue;

class BlueTooth {
  static fBlue.FlutterBlue flutterBlue = fBlue.FlutterBlue.instance;
  static StreamController<BlueScanResult>? fBlueController;
  Stream<BlueScanResult> get fBlueStream => fBlueController!.stream;

  static BlueTooth get instance => BlueTooth();

  static List? stack;
  static List<String>? fBlueStack;

  startScan() {

    fBlueController = StreamController();
    stack = [];
    fBlueStack = [];

    flutterBlue.startScan(
      timeout: Duration(seconds: 4,),
      scanMode: BlueScanSetting.mode == null
          ? fBlue.ScanMode.lowLatency
          : BlueScanSetting.modes[BlueScanSetting.mode!].mode,
    );

    flutterBlue.scanResults.listen((results) {
      for (fBlue.ScanResult result in results) {
        print(result);
        if (!fBlueStack!.contains(result.device.id.id)) {
          if (BlueScanSetting.maxRssi != null && BlueScanSetting.minRssi != null) {
            if (result.rssi > BlueScanSetting.minRssi! && result.rssi < BlueScanSetting.maxRssi!) {
              /*print(result.device.id.id,);
              print(result.rssi,);*/
              fBlueStack!.add(result.device.id.id);
              /*print(fBlueStack);*/
              fBlueController!.sink.add(
                BlueScanResult(
                  scanStatus: true,
                  deviceName: result.device.name,
                  deviceID: result.device.id.id,
                  data: result.advertisementData,
                  rssi: result.rssi,
                ),
              );
            }
          }
          if (BlueScanSetting.maxRssi == null && BlueScanSetting.minRssi == null) {
            fBlueStack!.add(result.device.id.id);
            fBlueController!.sink.add(
              BlueScanResult(
                scanStatus: true,
                deviceName: result.device.name,
                deviceID: result.device.id.id,
                data: result.advertisementData,
                rssi: result.rssi,
              ),
            );
          }
        }
      }
    });
  }

  stopScan() {
    flutterBlue.stopScan();
    fBlueController!.close();
  }

}

class BlueScanResult {
  final bool scanStatus;
  final String deviceID;
  final String deviceName;
  final fBlue.AdvertisementData data;
  final String? error;
  final int rssi;

  BlueScanResult({
    required this.scanStatus,
    required this.deviceID,
    required this.deviceName,
    required this.data,
    this.error,
    required this.rssi,
  });
}