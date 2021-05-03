import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tile_blue/bloc/dropdown_domains/domain_dropdown_bloc.dart';
import 'package:tile_blue/setting/blue_scan_setting.dart';
import 'package:tile_blue/setting/prefs.dart';
import 'package:tile_blue/util/dialogs.dart';

class Other extends StatefulWidget {

  @override
  _Other createState() => _Other();

}

class _Other extends State<Other> {

  FocusNode backEndFocusNode = FocusNode();
  TextEditingController backEndController = TextEditingController();
  String? chooseDomain;

  DropdownButton chooseMenu ({
    required DomainDropdownBloc bloc,
    required String hintText,
    required List<String> options,
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
        chooseDomain = item;
        bloc.add(
          DomainDropdownChose(
            domain: item,
          ),
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
    final domainDropDownBloc = BlocProvider.of<DomainDropdownBloc>(context);
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
                  if (chooseDomain != null) {
                    Prefs prefs = Prefs(preferences: await SharedPreferences.getInstance(),);
                    bool result = await prefs.saveChosenDomain(domain: chooseDomain!,);
                    Dialogs.showMessageDialog(
                      success: result,
                      context: context,
                      msg: result
                          ? "設置成功"
                          : "設置失敗",
                    );
                    Future.delayed(Duration(seconds: 2,), () => Navigator.of(context).pop(),);
                    if (result) {
                      BlueScanSetting.serverDomain = prefs.getDomain();
                    }
                  }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                '1. 假如伺服器設置是空白的，請先用欄位新增後台伺服器網址',
              ),
              Text(
                '2. 選擇伺服器後按確認完成設置',
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                        domainDropDownBloc.add(DomainDropdownInit());
                      }
                    },
                    child: Text(
                      '新增',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20,),
                    child: Text(
                      '後台伺服器網址',
                    ),
                  ),
                  BlocBuilder<DomainDropdownBloc, DomainDropdownState>(
                    builder: (BuildContext context, DomainDropdownState state) {
                      List<String> listOfItem = [];
                      String hintText = '伺服器選擇';
                      if (state is DomainDropdownInitial) {
                        domainDropDownBloc.add(DomainDropdownInit());
                        return CircularProgressIndicator();
                      }
                      if (state is DomainDropdownItem) {
                        listOfItem = state.domains;
                      }
                      if (state is DomainDropdownChosen) {
                        hintText = state.domain;
                        listOfItem = state.domains;
                      }
                      return chooseMenu(
                        bloc: domainDropDownBloc,
                        hintText: hintText,
                        options: listOfItem,
                      );
                    },
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