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
        title: Text(
          _widgetTittle[_selectedIndex],
          style: TextStyle(color: kAccentColor),
        ),
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
            icon: Icon(Icons.assessment),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
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
  final _widgetTittle = ["Home", "All Orders", "Account"];

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
