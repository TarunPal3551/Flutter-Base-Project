import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmerchant/controllers/itemcategory_controller.dart';
import 'package:kmerchant/models/itemcategory.dart';
import 'package:kmerchant/ui/components/cached_network_image.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';
import 'package:kmerchant/ui/components/loading_dialog.dart';
import 'package:kmerchant/ui/components/my_textfields.dart';

import '../../theme.dart';
import 'package:image_picker/image_picker.dart';

class CategoryForm extends StatefulWidget {
  static const id = 'category_form';
  final Data categoryDetails;

  ///Named Parameters

  CategoryForm(this.categoryDetails);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryFormState();
  }
}

class CategoryFormState extends State<CategoryForm> {
  var _tittleController = TextEditingController(text: "");
  final _descController = TextEditingController(text: "");
  // bool isSwitched = false;
  bool isChecked = false;
  File _categoryImage;
  bool _categorySelected = false;
  ImagePicker picker = ImagePicker();
  ItemCategoryController categoryController = ItemCategoryController();

  String tittle;

  String description;

  @override
  void dispose() {
    _tittleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final selected = await picker.getImage(source: ImageSource.gallery);
    if (selected == null) return;
    _categoryImage = File(selected.path);
    _categorySelected = true;
    setState(() {});
  }

  void uploadImage(File _categoryImage, Data categoryDetails, String tittle,
      String description, bool isChecked) async {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    var value = await categoryController.uploadImage(_categoryImage);
    if (value != null) {
      if (value.code == "1") {
        submitData(widget.categoryDetails, value.filename, value.fileUrl,
            tittle, description, isChecked);
      } else {
        if (Get.isDialogOpen) Get.back();
        Get.snackbar("Failed", "Something went wrong",
            backgroundColor: Colors.red[700],
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
      }
    } else {
      if (Get.isDialogOpen) Get.back();
      Get.snackbar("Failed", "Something went wrong",
          backgroundColor: Colors.red[700],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
    }
  }

  void submitData(Data categoryDetails, String imageName, String thumbnailsUrl,
      String tittle, String description, bool isChecked) {
    categoryController
        .submitCategory(widget.categoryDetails, imageName, thumbnailsUrl,
            tittle, description, isChecked)
        .then((value) {
      if (Get.isDialogOpen) Get.back();
      if (value != null) {
        Get.snackbar(value.msg, "Request Success",
            backgroundColor: Colors.green[700],
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
      } else {
        Get.snackbar("Failed", "Something went wrong",
            backgroundColor: Colors.red[700],
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.categoryDetails != null) {
      description = widget.categoryDetails.description;
      tittle = widget.categoryDetails.name;
      _tittleController.text = tittle;
      _descController.text = description;
      if (widget.categoryDetails.status == "publish") {
        isChecked = true;
      } else {
        isChecked = false;
      }
    } else {
      description = "";
      tittle = "";
      _tittleController.text = tittle;
      _descController.text = description;
      isChecked = true;
    }
  }

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
      body: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    widget.categoryDetails.thumbnail != null &&
                            widget.categoryDetails.thumbnail != ""
                        ? _categoryImage == null
                            ? MyCachedNetworkImage(
                                borderRadius: 5,
                                width: 100,
                                height: 100,
                                url: widget.categoryDetails.thumbnail)
                            : CustomContainer(
                                width: 100,
                                height: 100,
                                child: Image.file(_categoryImage),
                              )
                        : _categoryImage != null
                            ? CustomContainer(
                                width: 100,
                                height: 100,
                                child: Image.file(_categoryImage),
                              )
                            : CustomContainer(
                                width: 100,
                                height: 100,
                                child: Icon(Icons.photo),
                              ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: InkWell(
                        onTap: () async {
                          _pickImage();
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kAccentColor,
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                MyTextField(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  controller: _tittleController,
                  keyboardType: TextInputType.name,
                  labelText: "Tittle",
                  onChanged: (value) {
                    tittle = value;
                  },
                ),
                SizedBox(height: 50),
                MyTextField(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  controller: _descController,
                  keyboardType: TextInputType.name,
                  labelText: "Description",
                  onChanged: (value) {
                    description = value;
                  },
                ),
                SizedBox(height: 25),
                Switch(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                Text(
                  isChecked == true ? "Active" : "Disabled",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 25),
                CustomContainer(
                    onTap: () {
                      if (_categoryImage != null) {
                        uploadImage(_categoryImage, widget.categoryDetails,
                            tittle, description, isChecked);
                      } else {
                        submitData(
                            widget.categoryDetails,
                            null,
                            widget.categoryDetails.thumbnail,
                            tittle,
                            description,
                            isChecked);
                      }
                    },
                    height: 50,
                    backgroundColor: kAccentColor,
                    width: 200,
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
