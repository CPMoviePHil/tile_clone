import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:tile_blue/util/bluetooth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BleList extends StatefulWidget {
  @override
  _BleList createState() => _BleList();
}

class _BleList extends State<BleList> {

  Stream scanDevices;

  List<BlueScanResult> scanResults = [];

  BlueTooth blue = BlueTooth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blue.startScan();
    scanDevices = blue.fBlueStream;
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
          SizedBox(
            height: 15,
          ),
          Text("1. rssi:${BlueScanSetting.minRssi??'無設定(預設)'} ~ ${BlueScanSetting.maxRssi??'無設定(預設)'}"),
          Text("2. 藍芽掃描模式${(BlueScanSetting.mode==null?'(預設)':'')}:${BlueScanSetting.modes[BlueScanSetting.mode??2].scanModeText}"),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<BlueScanResult>(
              stream: scanDevices,
              builder: (BuildContext context, AsyncSnapshot<BlueScanResult> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.data.scanStatus) {
                  print("scan error:${snapshot.data.error}");
                }
                final BlueScanResult receivedResult = snapshot.data;
                print(receivedResult.deviceID);
                scanResults.add(receivedResult);
                return ListView.builder(
                  itemCount: scanResults.length,
                  itemBuilder: (BuildContext context, int index,) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            '藍芽裝置',
                          ),
                          subtitle: Text(
                            "${scanResults[index].deviceID}",
                          ),
                          trailing: Text(
                            '${scanResults[index].rssi}',
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: '設置',
                          color: Colors.blue,
                          icon: Icons.archive,
                          onTap: () {

                          },
                        ),
                        IconSlideAction(
                          caption: '登錄',
                          color: Colors.black38,
                          icon: Icons.add_sharp,
                          onTap: () async {
                            await showDialog(
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
                                          Text('${receivedResult.deviceID}'),
                                          Container(
                                            /*width: 100,*/
                                            child: DropdownButton<String>(
                                              hint: Text("後台選擇"),
                                              items: <String>['巧冠幼稚園', 'xx輪胎', "高雄科技大學"].map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text("$value"),
                                                );
                                              }).toList(),
                                              onChanged: (_) {},
                                            ),
                                          ),
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
                          },
                        ),
                      ],
                    );
                    /*if (receivedResult.scanStatus) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              '藍芽裝置',
                            ),
                            subtitle: Text(
                              "${receivedResult.deviceID}",
                            ),
                            trailing: Text(
                              '${receivedResult.rssi}',
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          IconSlideAction(
                            caption: '設置',
                            color: Colors.blue,
                            icon: Icons.archive,
                            onTap: () {

                            },
                          ),
                          IconSlideAction(
                            caption: '登錄',
                            color: Colors.black38,
                            icon: Icons.add_sharp,
                            onTap: () async {
                              await showDialog(
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
                                            Text('${receivedResult.deviceID}'),
                                            Container(
                                              *//*width: 100,*//*
                                              child: DropdownButton<String>(
                                                hint: Text("後台選擇"),
                                                items: <String>['巧冠幼稚園', 'xx輪胎', "高雄科技大學"].map((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text("$value"),
                                                  );
                                                }).toList(),
                                                onChanged: (_) {},
                                              ),
                                            ),
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
                                  }
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        alignment: Alignment.center,
                        child: Text(
                          "搜尋中...",
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }*/
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