import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_blue/flutter_blue.dart' as fBlue;

class BlueTooth {

  static final StreamController<BlueScanResult> controllerFRBle = StreamController.broadcast();
  Stream<BlueScanResult> get fRBleStream => controllerFRBle.stream;
  static final StreamController<BlueScanResult> controllerBlue = StreamController.broadcast();
  Stream<BlueScanResult> get blueStream => controllerBlue.stream;

  static final flutterReactiveBle = FlutterReactiveBle();
  static final flutterBlue = fBlue.FlutterBlue.instance;

  static BlueTooth get instance => BlueTooth();

  static List stack = [];
  static List fBlueStack = [];

  startScan() {
    flutterReactiveBle.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
    ).listen((device) {
      if (!stack.contains(device.id)) {
        stack.add(device.id);
        controllerFRBle.sink.add(
          BlueScanResult(
            scanStatus: true,
            deviceID: device.id,
          ),
        );
      }
      //code for handling results
    }, onError: (e) {
      controllerFRBle.sink.add(
        BlueScanResult(
          scanStatus: false,
          error: '$e',
        ),
      );
    });
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((event) {
      for (fBlue.ScanResult r in event) {
        if (!fBlueStack.contains(r.device.id)) {
          fBlueStack.add(r.device.id);
          controllerBlue.sink.add(
            BlueScanResult(
              scanStatus: true,
              deviceID: r.device.id.id,
            ),
          );
        }
      }
    });
  }

  stopScan() {
    controllerFRBle.close();
    controllerBlue.close();
  }

}

class BlueScanResult {
  final bool scanStatus;
  final String deviceID;
  final String error;

  BlueScanResult({
    @required this.scanStatus,
    this.deviceID,
    this.error,
  });
}