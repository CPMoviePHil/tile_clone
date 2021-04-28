import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tile_blue/screen/page/export.dart';
import 'package:tile_blue/widget/export.dart';
import 'package:tile_blue/screen/page/subpage/export.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPage createState() => _MainPage();

}

class _MainPage extends State<MainPage> {

  int currentIndex = 0;

  final List<Widget> pages = [
    Home(),
    Location(),
  ];

  final List<BarItem> items = [
    BarItem(
      icon: Icons.home_filled,
      itemText: "Home",
    ),
    BarItem(
      icon: Icons.add_location,
      itemText: "Location",
    ),
  ];

  BottomNavigationBarItem barItem({
    IconData icon,
    String itemText,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: itemText,
    );
  }

  Widget bottomSheetItem ({
    String hintText,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(hintText);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$hintText",
              style: TextStyle(
                color: Color.fromRGBO(
                  123, 123, 123, 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 5,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bluetooth',
              ),
              GestureDetector(
                onTap: () async {
                  final String option1 = '藍芽搜尋設定';
                  final String option2 = '其他設定';
                  String result = await showModalBottomSheet<String>(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: ( BuildContext context ) {
                      return Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            bottomSheetItem(hintText: "$option1",),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(
                                      123, 123, 123, 1,
                                    ),
                                    width: 0.2,
                                  ),
                                ),
                              ),
                            ),
                            bottomSheetItem(hintText: "$option2",),
                          ],
                        ),
                      );
                    },
                  );
                  if (result == option1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scan(),
                      ),
                    ).then((value) {
                      setState((){});
                    });
                  }
                  if (result == option2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Other(),
                      ),
                    ).then((value) {
                      setState((){});
                    });
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (currentPageIndex) {
          setState(() {
            currentIndex = currentPageIndex;
          });
        },
        items: items
            .map(
              (e) => barItem(
            icon: e.icon,
            itemText: e.itemText,
          ),
        ).toList(),
      ),
    );
  }
}

