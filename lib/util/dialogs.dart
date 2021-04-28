import 'dart:async';

import 'package:flutter/material.dart';

class Dialogs {

  static Timer timer;

  static Future<void> showLoadingDialog({
    BuildContext context,
    GlobalKey key,
    String loadingMsg = '請稍後...',
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            key: key,
            elevation: 0,
            backgroundColor: Colors.white,
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation(
                        Color.fromRGBO(216, 236, 234, 1),
                      ),
                      key: ValueKey(0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$loadingMsg",
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showMessageDialog({
    @required bool success,
    @required BuildContext context,
    @required String msg,
  }) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Row(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 700,),
                  child: (success)
                      ? Icon(Icons.check_circle_outline,)
                      : Icon(Icons.close,),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(right: 5,),
                    child: Text(
                      '$msg',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  static final Dialogs _instance = Dialogs._internal();

  factory Dialogs() => _instance;

  Dialogs._internal();
}
