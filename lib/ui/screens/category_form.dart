import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmerchant/ui/components/cached_network_image.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';
import 'package:kmerchant/ui/components/my_textfields.dart';

import '../../theme.dart';
import 'package:image_picker/image_picker.dart';

class CategoryForm extends StatefulWidget {
  static const id = 'category_form';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryFormState();
  }
}

class CategoryFormState extends State<CategoryForm> {
  var _tittleController = TextEditingController(text: "");
  final _descController = TextEditingController(text: "");
  bool isSwitched = false;
  File _categoryImage;
  bool _categorySelected = false;
  ImagePicker picker = ImagePicker();

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
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _categoryImage == null
                        ? MyCachedNetworkImage(
                            borderRadius: 5,
                            width: 100,
                            height: 100,
                            url:
                                "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-homemade-pizza-horizontal-1542312378.png",
                          )
                        : CustomContainer(
                            width: 100,
                            height: 100,
                            child: Image.file(_categoryImage),
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
                ),
                SizedBox(height: 25),
                MyTextField(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  controller: _descController,
                  keyboardType: TextInputType.name,
                  labelText: "Description",
                ),
                SizedBox(height: 25),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                ),
                Text(
                  isSwitched == true ? "Active" : "Disabled",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 25),
                CustomContainer(
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
