import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:tile_blue/setting/prefs.dart';

class Scan extends StatefulWidget{
  @override
  _Scan createState() => _Scan();
}

class _Scan extends State<Scan> {

  final minRssiController = TextEditingController();
  final minRssiFocusNode = FocusNode();
  final maxRssiController = TextEditingController();
  final maxRssiFocusNode = FocusNode();
  //final deviceMacController = TextEditingController();

  List<ScanMode> modes = [
    ScanMode.balanced,
    ScanMode.lowPower,
    ScanMode.lowLatency,
    ScanMode.opportunistic,
  ];

  DropdownButton chooseMenu({
    @required String hintText,
    @required List options,
  }) {
    return DropdownButton(
      hint: Text("${hintText??''}"),
      items: options.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text("$value"),
        );
      },).toList(),
      onChanged: (item) async => BlueScanSetting.mode = item ,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Scan Setting',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final prefs = Prefs(preferences: await SharedPreferences.getInstance());
                  prefs.saveSetting(
                    mode: BlueScanSetting.mode,
                    maxRssi: BlueScanSetting.maxRssi,
                    minRssi: BlueScanSetting.minRssi,
                  );
                },
                child: Text(
                  "確認",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20,),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  chooseMenu(
                    hintText: "Scan Mode",
                    options: modes,
                  ),
                ],
              ),
              TextField(
                focusNode: minRssiFocusNode,
                onChanged: (text) {
                  if (text != '-') {
                    BlueScanSetting.minRssi = int.parse(text);
                  }
                },
                controller: minRssiController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'),),
                ],
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: "min rssi",
                ),
              ),
              TextField(
                focusNode: maxRssiFocusNode,
                onChanged: (text) {
                  if (text != "-") {
                    BlueScanSetting.maxRssi = int.tryParse(text);
                  }
                },
                controller: maxRssiController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'),),
                ],
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: "max rssi",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}