import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tile_blue/bloc/dropdown/scan_dropdown_bloc.dart';
import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:tile_blue/setting/prefs.dart';
import 'package:tile_blue/util/export.dart';

class Scan extends StatefulWidget{
  @override
  _Scan createState() => _Scan();
}

class _Scan extends State<Scan> {

  final minRssiController = TextEditingController(
    text: BlueScanSetting.minRssi==null?'':BlueScanSetting.minRssi.toString(),
  );
  final minRssiFocusNode = FocusNode();
  final maxRssiController = TextEditingController(
    text: BlueScanSetting.maxRssi==null?'':BlueScanSetting.maxRssi.toString(),
  );
  final maxRssiFocusNode = FocusNode();
  //final deviceMacController = TextEditingController();

  DropdownButton chooseMenu({
    @required Bloc bloc,
    @required String hintText,
    @required List<ScanModeItem> options,
  }) {
    return DropdownButton(
      hint: Text("${hintText??''}"),
      items: options.map((value) {
        return DropdownMenuItem(
          value: value.scanModeText,
          child: Text("${value.scanModeText}"),
        );
      },).toList(),
      onChanged: (item) async {
        int itemIndex;
        BlueScanSetting.modes.map((e) {
          if (e.scanModeText == item) {
            itemIndex = e.index;
          }
        }).toList();
        BlueScanSetting.mode = itemIndex;
        bloc.add(
          ScanDropdownChose(mode: itemIndex,),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanDropdownBloc = BlocProvider.of<ScanDropdownBloc>(context);
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
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (minRssiController.text != '-' && minRssiController.text != '') {
                    BlueScanSetting.minRssi = int.tryParse(minRssiController.text);
                  }
                  if (minRssiController.text == '') {
                    BlueScanSetting.minRssi = null;
                  }
                  if (maxRssiController.text != '-' && maxRssiController.text != '') {
                    BlueScanSetting.maxRssi = int.tryParse(maxRssiController.text);
                  }
                  if (maxRssiController.text == '') {
                    BlueScanSetting.maxRssi = null;
                  }
                  final prefs = Prefs(preferences: await SharedPreferences.getInstance(),);
                  String responseError = await prefs.saveScanSetting(
                    mode: BlueScanSetting.mode ?? 0,
                    maxRssi: BlueScanSetting.maxRssi,
                    minRssi: BlueScanSetting.minRssi,
                  );
                  if (responseError == '') {
                    Dialogs.showMessageDialog(
                      success: true,
                      context: context,
                      msg: '設置成功',
                    );
                  } else {
                    Dialogs.showMessageDialog(
                      success: false,
                      context: context,
                      msg: responseError,
                    );
                  }
                  Future.delayed(Duration(seconds: 2,), () => Navigator.of(context).pop(),);
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
                  BlocBuilder<ScanDropdownBloc, ScanDropdownState>(
                    builder: (context, state) {
                      String dropdownText;
                      if (state is ScanDropdownInitial) {
                        if (BlueScanSetting.mode == null) {
                          dropdownText = '掃描模式';
                        } else {
                          dropdownText = BlueScanSetting.modes[BlueScanSetting.mode].scanModeText;
                        }
                      }
                      if (state is ScanDropdownItem) {
                        dropdownText = BlueScanSetting.modes[state.mode].scanModeText;
                      }
                      return chooseMenu(
                        bloc: scanDropdownBloc,
                        hintText: "$dropdownText",
                        options: BlueScanSetting.modes,
                      );
                    },
                  ),
                ],
              ),
              TextField(
                focusNode: minRssiFocusNode,
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