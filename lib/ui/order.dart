import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/custom_containers.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderState();
  }
}

class OrderState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
