import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:tile_blue/util/bluetooth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tile_blue/util/dialogs.dart';

class BleList extends StatefulWidget {
  @override
  _BleList createState() => _BleList();
}

class _BleList extends State<BleList> {

  Stream<BlueScanResult>? scanDevices;

  List<BlueScanResult> scanResults = [];

  BlueTooth blue = BlueTooth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blue.startScan();
    scanDevices = blue.fBlueStream;
    //scanDevices!.listen((event) => setState(() => scanResults.add(event)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    blue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 5,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '搜尋藍芽裝置',
              ),
              GestureDetector(
                child: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text("1. rssi:${BlueScanSetting.minRssi??'無設定(預設)'} ~ ${BlueScanSetting.maxRssi??'無設定(預設)'}"),
                Text("2. 藍芽掃描模式${(BlueScanSetting.mode==null?'(預設)':'')}:${BlueScanSetting.modes[BlueScanSetting.mode??2].scanModeText}"),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (BuildContext context) {
                return ListView.builder(
                  itemCount: scanResults.length,
                  itemBuilder: (BuildContext context, int index,) {
                    List<Widget> actions = [];
                    actions.add(
                      IconSlideAction(
                        caption: '登錄',
                        color: Colors.black38,
                        icon: Icons.add_sharp,
                        onTap: () async {
                          if (BlueScanSetting.serverDomain != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('登錄至資料庫'),
                                  content: Container(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(bottom: 5,),
                                          /*width: 100,*/
                                          child: Text('伺服器:${BlueScanSetting.serverDomain}',),
                                        ),
                                        Text('名稱:${scanResults[index].deviceName}'),
                                        Text('裝置mac:${scanResults[index].deviceID}'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      child: Text('確認'),
                                      onPressed: (){

                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            Dialogs.showMessageDialog(
                              success: false,
                              context: context,
                              msg: '請先至設定設置伺服器網址',
                            );
                            Future.delayed(Duration(seconds: 2,), () => Navigator.of(context).pop(),);
                          }
                        },
                      ),
                    );
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Colors.white,
                        child: InkWell(
                          onLongPress: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('裝置資訊'),
                                  content: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('名稱:${scanResults[index].deviceName}'),
                                        Text('Mac:${scanResults[index].deviceID}'),
                                        Text('data: ${scanResults[index].data}'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: ListTile(
                            title: Text(
                              '裝置名稱: ${scanResults[index].deviceName==''?'unknown':'${scanResults[index].deviceName}'}',
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "MAC: ${scanResults[index].deviceID}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      actions: actions,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}