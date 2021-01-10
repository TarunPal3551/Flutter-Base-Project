import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmerchant/ui/components/cached_network_image.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';
import 'package:kmerchant/ui/screens/category_form.dart';

import '../../theme.dart';

class CategoryList extends StatefulWidget {
  static const id = 'category_screen';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryListState();
  }
}

class CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: kAppBarColor,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("All Category", style: TextStyle(color: Colors.black))),
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

  Widget CategoryCard() {
    return CustomContainer(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      width: double.infinity,
      onTap: () {
        var numberDialog = Align(
          alignment: Alignment(0, 0),
          child: CustomContainer(
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
                              builder: (context) => CategoryForm()),
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
                url:
                    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-homemade-pizza-horizontal-1542312378.png",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Pizza & Sandwich",
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
                          "This description is test description , This description is test description",
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
                  child: Text("Active", style: TextStyle(color: Colors.green))),
              Center(
                  child: Text("Updated at 10 Jan 2020",
                      style: TextStyle(color: Colors.grey)))
            ],
          )
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   ClipOval(
          //     child: Material(
          //       color: kAccentColor, // button color
          //       child: InkWell(
          //         // inkwell color
          //         child: SizedBox(
          //             width: 35,
          //             height: 35,
          //             child: Icon(
          //               Icons.edit,
          //               size: 20,
          //               color: Colors.white,
          //             )),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => CategoryForm()),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          //   SizedBox(
          //     width: 10,
          //   ),
          //   ClipOval(
          //     child: Material(
          //       color: kAccentColor, // button color
          //       child: InkWell(
          //         // inkwell color
          //         child: SizedBox(
          //             width: 35,
          //             height: 35,
          //             child: Icon(
          //               Icons.delete,
          //               size: 20,
          //               color: Colors.white,
          //             )),
          //         onTap: () {},
          //       ),
          //     ),
          //   ),
          // ]),
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
        return CategoryCard();
      },
      itemCount: 30,
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
