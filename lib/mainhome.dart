import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmerchant/theme.dart';
import 'package:kmerchant/ui/account.dart';
import 'package:kmerchant/ui/booking.dart';
import 'package:kmerchant/ui/home.dart';
import 'package:kmerchant/ui/order.dart';

class MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: kAppBarColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kAccentColor,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }

  int _selectedIndex = 0;
  final _widgetOptions = [HomePage(), OrderPage(), AccountPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class MainHome extends StatefulWidget {
  MainHome({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainHomeState();
  }
}
