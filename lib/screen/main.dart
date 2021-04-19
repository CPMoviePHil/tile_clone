import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tile_blue/screen/page/export.dart';
import 'package:tile_blue/widget/export.dart';

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

