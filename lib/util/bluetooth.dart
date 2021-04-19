import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BlueTooth {

  static final StreamController controller = StreamController.broadcast();
  static Stream get myStream => controller.stream;

  static final flutterReactiveBle = FlutterReactiveBle();

  static BlueTooth _blueTooth = BlueTooth();

  factory BlueTooth() => _blueTooth;

  static startScan() {
    flutterReactiveBle.scanForDevices(withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
      //code for handling results
    }, onError: () {
      //code for handling error
    });
    /*flutterBlue.startScan(timeout: Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      controller.sink.add(results);
      *//*for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
      *//*
    });*/

  }

  static stopScan() {
    flutterBlue.stopScan();
    controller.close();
  }
}