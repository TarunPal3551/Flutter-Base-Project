import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';

import '../../theme.dart';

class CategoryForm extends StatefulWidget {
  static const id = 'category_screen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryFormState();
  }
}

class CategoryFormState extends State<CategoryForm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: kAppBarColor,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Add/Edit Category",
            style: TextStyle(color: Colors.black),
          )),
      body: CustomContainer(

        
      ),
    );
  }
}
