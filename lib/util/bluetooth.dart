import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BlueTooth {

  static StreamController<BlueScanResult> controllerFRBle;
  Stream<BlueScanResult> get fRBleStream => controllerFRBle.stream;
  StreamSubscription fBleSubscription;

  static final flutterReactiveBle = FlutterReactiveBle();

  static BlueTooth get instance => BlueTooth();

  static List stack = [];
  static List fBlueStack = [];

  startScan() {
    controllerFRBle = StreamController();
    fBleSubscription = flutterReactiveBle.scanForDevices(
      withServices: [],
      scanMode: ScanMode.lowLatency,
      requireLocationServicesEnabled: false,
    ).listen((event) => event);
    fBleSubscription.onData((device) {
      if (!stack.contains(device.id)) {
        stack.add(device.id);
        controllerFRBle.sink.add(
          BlueScanResult(
            scanStatus: true,
            deviceID: device.id,
          ),
        );
      }
    });

    fBleSubscription.onError((error){
      controllerFRBle.sink.add(
        BlueScanResult(
          scanStatus: false,
          error: '$error',
        ),
      );
    });
  }

  stopScan() {
    fBleSubscription.cancel();
    controllerFRBle.close();
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