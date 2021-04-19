import 'package:flutter/cupertino.dart';
import 'package:tile_blue/util/bluetooth.dart';

class Home extends StatefulWidget {

  @override
  _Home createState() => _Home();

}

class _Home extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlueTooth.startScan();
    BlueTooth.myStream.listen((event) => print("event:$event"));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BlueTooth.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container();
  }
}