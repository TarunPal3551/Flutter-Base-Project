import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmerchant/controllers/itemcategory_controller.dart';
import 'package:kmerchant/models/addonitemdetails.dart';
import 'package:kmerchant/models/addonitemdetails.dart' as info;
import 'package:kmerchant/models/selection_model.dart';
import 'package:kmerchant/ui/components/cached_network_image.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';
import 'package:kmerchant/ui/components/loading_dialog.dart';
import 'package:kmerchant/ui/components/my_textfields.dart';
import 'package:kmerchant/models/addoncategory.dart' as category;
import 'package:kmerchant/ui/screens/category_selection.dart';

import '../../theme.dart';
import 'package:image_picker/image_picker.dart';

class AddOnItemsForm extends StatefulWidget {
  static const id = 'category_form';

  ///Named Parameters
  //
  String itemId;

  AddOnItemsForm({this.itemId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddOnItemsFormState();
  }
}

class AddOnItemsFormState extends State<AddOnItemsForm> {
  var _tittleController = TextEditingController(text: "");
  final _descController = TextEditingController(text: "");
  final _priceController = TextEditingController(text: "");
  // bool isSwitched = false;
  bool isChecked = false;
  File _categoryImage;
  bool _categorySelected = false;

  List<category.Data> selectedCategorydata = List();
  ImagePicker picker = ImagePicker();
  List<String> _selecteCategorys = List();
  List<String> _selectedIDs = List();
  ItemCategoryController categoryController = ItemCategoryController();

  String tittle;
  String price;
  String description;
  info.Data categoryDetails;

  @override
  void dispose() {
    _tittleController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final selected = await picker.getImage(source: ImageSource.gallery);
    if (selected == null) return;
    _categoryImage = File(selected.path);
    _categorySelected = true;
    setState(() {});
  }

  void getItemInfo(String id) async {
    var data = await categoryController.getAddonInfo(id);
    if (data != null) {
      if (Get.isDialogOpen) Get.back();
      categoryDetails = data;
      if (categoryDetails != null) {
        description = categoryDetails.itemDescription;
        tittle = categoryDetails.subItemName;
        price = categoryDetails.price;
        _tittleController.text = tittle;
        _descController.text = description;
        _priceController.text = price;
        if (categoryDetails.status == "publish") {
          isChecked = true;
        } else {
          isChecked = false;
        }
      } else {
        description = "";
        tittle = "";
        _tittleController.text = tittle;
        _descController.text = description;

        _priceController.text = price;
        isChecked = true;
      }
      setState(() {});
    } else {
      categoryDetails = Data();
      if (Get.isDialogOpen) Get.back();
      Get.snackbar("Failed", "Something went wrong",
          backgroundColor: Colors.red[700],
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
    }
  }

  void uploadImage(File _categoryImage, Data categoryDetails, String tittle,
      String description, bool isChecked) async {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    var value = await categoryController.uploadImage(_categoryImage);
    if (value != null) {
      if (value.code == "1") {
        submitData(categoryDetails, value.filename, value.fileUrl, tittle,
            description, price, _selecteCategorys, isChecked);
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

  void submitData(
      Data categoryDetails,
      String imageName,
      String thumbnailsUrl,
      String tittle,
      String description,
      String price,
      List<String> selectedCategory,
      bool isChecked) {
    categoryController
        .submitAddonItem(categoryDetails, imageName, thumbnailsUrl, tittle,
            description, price, selectedCategory, isChecked)
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

    _selecteCategorys = List();
    selectedCategorydata = List();
    if (widget.itemId != null) {
      getItemInfo(widget.itemId);
      getCategoryList();
    } else {
      categoryDetails = Data();
      getCategoryList();
    }
  }

  void getCategoryList() {
    selectedCategorydata.clear();
    categoryController.getAllAddonCategory().then((value) {
      if (value != null) {
        if (Get.isDialogOpen) Get.back();

        if (categoryDetails != null &&
            categoryDetails.category != null &&
            categoryDetails.category.length > 0) {
          for (int i = 0; i < categoryDetails.category.length; i++) {
            for (int j = 0; j < value.data.length; j++) {
              if (categoryDetails.category.elementAt(i) ==
                  value.data.elementAt(j).id) {
                selectedCategorydata.add(value.data.elementAt(j));
              }
            }
          }
        }
        setState(() {});
        //Get.offAndToNamed(MyHomePage.id);

      } else {
        if (Get.isDialogOpen) Get.back();
      }
    });
  }

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(category_id);
      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);
      });
    }
  }

  Widget listItem(category.Data addonCategory) {
    // bool isChecked;
    return CheckboxListTile(
        value: _selecteCategorys.contains(addonCategory.id),
        onChanged: (bool selected) {
          _onCategorySelected(selected, addonCategory.id);
        },
        title: Text(
          addonCategory.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ));
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
                    categoryDetails != null
                        ? categoryDetails.thumbnail != null &&
                                categoryDetails.thumbnail != ""
                            ? _categoryImage == null
                                ? MyCachedNetworkImage(
                                    borderRadius: 5,
                                    width: 100,
                                    height: 100,
                                    url: categoryDetails.thumbnail)
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
                SizedBox(height: 25),
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
                CustomContainer(
                  height: 70,
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    CategorySelection(selectedCategorydata)))
                        .then((val) {
                      selectedCategorydata = val;
                      if (selectedCategorydata != null) {
                        for (int i = 0; i < selectedCategorydata.length; i++) {
                          _selecteCategorys
                              .add(selectedCategorydata.elementAt(i).id);
                        }
                      }

                      setState(() {});
                      //Data returned in val from next screen
                    });

                    // SizedBox.expand(
                    //     child: DraggableScrollableSheet(
                    //   initialChildSize: 0.3,
                    //   minChildSize: 0.2,
                    //   maxChildSize: 1.0,
                    //   builder: (BuildContext context,
                    //       ScrollController scrollController) {
                    //     return GridView.builder(
                    //       primary: true,
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.vertical,
                    //       gridDelegate:
                    //           SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 3),
                    //       physics: const BouncingScrollPhysics(),
                    //       itemBuilder: (context, index) {
                    //         return listItem(selectedCategorydata[index]);
                    //       },
                    //       itemCount: selectedCategorydata.length,
                    //     );
                    //   },
                    // ));

                    // showModalBottomSheet(
                    //   context: context,
                    //   builder: (context) => Container(
                    //     child: GridView.builder(
                    //       primary: true,
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.vertical,
                    //       gridDelegate:
                    //           SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 3),
                    //       physics: const BouncingScrollPhysics(),
                    //       itemBuilder: (context, index) {
                    //         return listItem(selectedCategorydata[index]);
                    //       },
                    //       itemCount: selectedCategorydata.length,
                    //     ),
                    //   ),
                    // );
                  },
                  margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  width: double.infinity,
                  padding: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      selectedCategorydata.length > 0
                          ? Text(
                              "" +
                                  selectedCategorydata.length.toString() +
                                  " Selected",
                              style: TextStyle(
                                  color: kAccentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          : Text(
                              "Select Category",
                              style: TextStyle(
                                  color: kAccentColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        getCategories(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25),
                MyTextField(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  controller: _priceController,
                  keyboardType: TextInputType.name,
                  labelText: "Price",
                  onChanged: (value) {
                    price = value;
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
                        uploadImage(_categoryImage, categoryDetails, tittle,
                            description, isChecked);
                      } else {
                        submitData(
                            categoryDetails,
                            categoryDetails.photo,
                            categoryDetails.thumbnail,
                            tittle,
                            description,
                            price,
                            _selecteCategorys,
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

  String getCategories() {
    var selectedCategory = "";
    for (int i = 0; i < selectedCategorydata.length; i++) {
      selectedCategory += selectedCategorydata.elementAt(i).name + ", ";
    }

    return selectedCategory;
  }
}
