import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';

import 'package:tile_blue/screen/page/subpage/export.dart';

class Home extends StatefulWidget {

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  List<Widget> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items.add(
      addBlue(
        context: context,
        icon: Icons.bluetooth,
        routes: '',
      ),
    );

    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          child: SwitchListTile(
            title: const Text(
              '藍芽',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            subtitle:
            Text(
              '開啟藍芽',
              style: TextStyle(
                color: Colors.blueGrey[600],
              ),
            ),
            secondary: Icon(Icons.bluetooth, size: 30,),
            controlAffinity: ListTileControlAffinity.trailing,
            value: _bluetoothState.isEnabled,
            onChanged: (bool result) async {
              Future<void> blueAction() async {
                if (result) {
                  await FlutterBluetoothSerial.instance.requestEnable();
                }
                else {
                  await FlutterBluetoothSerial.instance.requestDisable();
                }
              }
              blueAction().then((_) {
                setState(() {});
              });
            },
          ),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: items,
          ),
        )
      ],
    );
  }

  Widget addBlue({
    @required BuildContext context,
    @required IconData icon,
    @required String routes,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(25.0,),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 50,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () async {
              if (_bluetoothState.isEnabled) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scan(),
                  ),
                ).then((value){
                  setState((){

                  });
                });
              } else {
                bool blueEnabled = await FlutterBluetoothSerial.instance.requestEnable();
                if (blueEnabled) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scan(),
                    ),
                  ).then((value){
                    setState((){

                    });
                  });
                }
              }
            },
            child: Icon(
              Icons.add_sharp,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}