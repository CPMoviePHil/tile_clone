import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tile_blue/setting/prefs.dart';
import 'package:tile_blue/util/dialogs.dart';

class Other extends StatefulWidget {

  @override
  _Other createState() => _Other();

}

class _Other extends State<Other> {

  FocusNode backEndFocusNode = FocusNode();
  TextEditingController backEndController = TextEditingController();

  DropdownButton chooseMenu ({
    @required String hintText,
    @required List<String> options,
  }) {
    return DropdownButton(
      hint: Text("$hintText"),
      items: options.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text("$value"),
        );
      },).toList(),
      onChanged: (item) async {

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '其他設定',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(
                    FocusNode(),
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
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6 ,
                    child: TextField(
                      focusNode: backEndFocusNode,
                      controller: backEndController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "伺服器新增",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (backEndController.text != '') {
                        Prefs prefs = Prefs(
                          preferences: await SharedPreferences.getInstance(),
                        );
                        bool result = await prefs.saveBackEndDomain(
                          domain: backEndController.text,
                        );
                        Dialogs.showMessageDialog(
                          success: result,
                          context: context,
                          msg: result
                              ? "新增成功"
                              : "新增失敗",
                        );
                        Future.delayed(Duration(seconds: 2,), () => Navigator.of(context).pop(),);
                      }
                    },
                    child: Text(
                      '新增',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}