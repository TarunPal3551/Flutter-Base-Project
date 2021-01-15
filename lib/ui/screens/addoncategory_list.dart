import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmerchant/controllers/itemcategory_controller.dart';
import 'package:kmerchant/models/itemcategory.dart';
import 'package:kmerchant/ui/components/cached_network_image.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';
import 'package:kmerchant/ui/components/loading_dialog.dart';
import 'package:kmerchant/ui/screens/addoncategory_form.dart';
import 'package:kmerchant/ui/screens/category_form.dart';

import '../../theme.dart';

class AddOnCategoryList extends StatefulWidget {
  static const id = 'category_screen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddOnCategoryListState();
  }
}

class AddOnCategoryListState extends State<AddOnCategoryList> {
  List<Data> categoryList;
  ItemCategoryController categoryController = ItemCategoryController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: kAppBarColor,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("All Addon Category",
                style: TextStyle(color: Colors.black))),
        body: Scaffold(
          body: Column(
            children: [
              Expanded(
                // child: ListView(
                //   children: [
                //     _buildCategoryList()
                //     ],
                child: _buildCategoryList(),
              ),
            ],
          ),
        ));
  }

  void getCategoryList() {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    categoryController.getAllItemCategory().then((value) {
      if (value != null) {
        if (Get.isDialogOpen) Get.back();
        categoryList = value.data;
        //Get.offAndToNamed(MyHomePage.id);
        setState(() {});
      } else {
        if (Get.isDialogOpen) Get.back();
        Get.snackbar("Loading Failed", "No Data Found",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
      }
    });
  }

  Widget CategoryCard(Data elementAt) {
    return CustomContainer(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      onTap: () {
        var numberDialog = Align(
          alignment: Alignment(0, 0),
          child: CustomContainer(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            borderRadius: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddOnCategoryForm()),
                        );
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return numberDialog;
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyCachedNetworkImage(
                  borderRadius: 5,
                  width: 80,
                  height: 80,
                  padding: EdgeInsets.all(10),
                  url: elementAt.thumbnail),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    elementAt.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Center(
                        child: Text(
                          elementAt.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      )),
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Center(
                  child: Text(elementAt.status,
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold))),
              Center(
                  child: Text(elementAt.dateCreated,
                      style: TextStyle(color: Colors.grey)))
            ],
          )
        ],
      ),
    );
  }

  Widget dialogBox() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: ListView(
        children: [Text("Edit"), Text("Delete")],
      ),
    );
  }

  Widget _buildCategoryList() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard(categoryList.elementAt(index));
      },
      itemCount: categoryList.length,
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(height: 200, width: 200));
  }
}
