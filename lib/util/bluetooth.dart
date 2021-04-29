import 'dart:async';

import 'package:flutter/cupertino.dart';
/*import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';*/
import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:flutter_blue/flutter_blue.dart' as fBlue;

class BlueTooth {

  /*static StreamController<BlueScanResult> controllerFRBle;
  Stream<BlueScanResult> get fRBleStream => controllerFRBle.stream;
  StreamSubscription fBleSubscription;*/

  static fBlue.FlutterBlue flutterBlue = fBlue.FlutterBlue.instance;
  static StreamController<BlueScanResult> fBlueController;
  Stream<BlueScanResult> get fBlueStream => fBlueController.stream;

  /*static final flutterReactiveBle = FlutterReactiveBle();*/

  static BlueTooth get instance => BlueTooth();

  static List stack;
  static List<String> fBlueStack;

  startScan() {

    stack = [];
    fBlueStack = [];

    /*controllerFRBle = StreamController();
    fBleSubscription = flutterReactiveBle.scanForDevices(
      withServices: [],
      scanMode: BlueScanSetting.mode == null
          ? ScanMode.lowLatency
          : BlueScanSetting.modes[BlueScanSetting.mode].mode,
      requireLocationServicesEnabled: false,
    ).listen((event) => event);
    fBleSubscription.onData((device) {
      DiscoveredDevice item = device as DiscoveredDevice;
      if (!stack.contains(item.id)) {
        if (BlueScanSetting.maxRssi != null && BlueScanSetting.minRssi != null) {
          if (item.rssi > BlueScanSetting.minRssi && item.rssi < BlueScanSetting.maxRssi) {
            stack.add(item.id);
            controllerFRBle.sink.add(
              BlueScanResult(
                scanStatus: true,
                deviceID: item.id,
              ),
            );
          }
        }
        if (BlueScanSetting.maxRssi == null && BlueScanSetting.minRssi == null) {
          stack.add(item.id);
          controllerFRBle.sink.add(
            BlueScanResult(
              scanStatus: true,
              deviceID: item.id,
            ),
          );
        }
      }
    });

    flutterBlue.startScan(
      scanMode: BlueScanSetting.mode == null
          ? fBlue.ScanMode.lowLatency
          : BlueScanSetting.modes[BlueScanSetting.mode].mode,
    );
    fBleSubscription.onError((error){
      controllerFRBle.sink.add(
        BlueScanResult(
          scanStatus: false,
          error: '$error',
        ),
      );
    });*/
    fBlueController = StreamController();

    flutterBlue.startScan(
      timeout: Duration(seconds: 4,),
      scanMode: BlueScanSetting.mode == null
          ? fBlue.ScanMode.lowLatency
          : BlueScanSetting.modes[BlueScanSetting.mode].mode,
    );

    flutterBlue.scanResults.listen((results) {
      for (fBlue.ScanResult result in results) {
        print(result);
        if (!fBlueStack.contains(result.device.id.id)) {
          if (BlueScanSetting.maxRssi != null && BlueScanSetting.minRssi != null) {
            if (result.rssi > BlueScanSetting.minRssi && result.rssi < BlueScanSetting.maxRssi) {
              /*print(result.device.id.id,);
              print(result.rssi,);*/
              fBlueStack.add(result.device.id.id);
              /*print(fBlueStack);*/
              fBlueController.sink.add(
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
            fBlueStack.add(result.device.id.id);
            fBlueController.sink.add(
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
    /*fBleSubscription.cancel();
    controllerFRBle.close();*/
    flutterBlue.stopScan();
    fBlueController.close();
    //fBlueSubscription.cancel();
  }

}

class BlueScanResult {
  final bool scanStatus;
  final String deviceID;
  final String deviceName;
  final fBlue.AdvertisementData data;
  final String error;
  final int rssi;

  BlueScanResult({
    @required this.scanStatus,
    this.deviceID,
    this.deviceName,
    this.data,
    this.error,
    this.rssi,
  });
}