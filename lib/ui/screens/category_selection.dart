import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmerchant/controllers/itemcategory_controller.dart';
import 'package:kmerchant/models/addoncategory.dart';
import 'package:kmerchant/theme.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';

class CategorySelection extends StatefulWidget {
  List<Data> selectedCategorydata;
  CategorySelection(List<Data> selectedCategorydata);

  @override
  CategorySelectionState createState() {
    // TODO: implement createState
    return CategorySelectionState();
  }
}

class CategorySelectionState extends State<CategorySelection> {
  List<bool> selected = List();
  List<Data> categoryList = List();
  ItemCategoryController categoryController = ItemCategoryController();
  List<Data> selectedCategories = List();

  void getCategoryList() {
    categoryList.clear();
    categoryController.getAllAddonCategory().then((value) {
      if (value != null) {
        if (Get.isDialogOpen) Get.back();
        categoryList = value.data;
        if (widget.selectedCategorydata != null) {
          for (int i = 0; i < widget.selectedCategorydata.length; i++) {
            for (int j = 0; j < value.data.length; j++) {
              if (widget.selectedCategorydata.elementAt(i).id ==
                  categoryList.elementAt(j).id) {
                selectedCategories.add(categoryList.elementAt(j));
              }
            }
          }
        }

        //Get.offAndToNamed(MyHomePage.id);
        setState(() {});
      } else {
        if (Get.isDialogOpen) Get.back();
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getCategoryList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: CustomContainer(
          onTap: () {
            Navigator.pop(context, selectedCategories);
          },
          height: 55,
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          backgroundColor: kAccentColor,
          child: Center(
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        body: ListView.builder(
          primary: true,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return listItem(categoryList[index]);
          },
          itemCount: categoryList.length,
        ));
  }

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        selectedCategories.add(category_id);
      });
    } else {
      setState(() {
        selectedCategories.remove(category_id);
      });
    }
  }

  Widget listItem(Data addonCategory) {
    // bool isChecked;
    return CheckboxListTile(
        value: selectedCategories.contains(addonCategory),
        onChanged: (bool selected) {
          _onCategorySelected(selected, addonCategory);
        },
        title: Text(
          addonCategory.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ));
  }
}
