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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scan(),
                    ),
                  ).then((value){
                    setState((){

                    });
                  });
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

