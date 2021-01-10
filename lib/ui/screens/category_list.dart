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
                child: ListView(
                  children: [_buildCategoryList()],
                ),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryForm()),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyCachedNetworkImage(
                borderRadius: 5,
                width: 50,
                height: 50,
                padding: EdgeInsets.all(10),
                url:
                    "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-homemade-pizza-horizontal-1542312378.png",
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pizza & Sandwich",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "This description is test description",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Material(
                        color: kAccentColor, // button color
                        child: InkWell(
                          // inkwell color
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              )),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ClipOval(
                        child: Material(
                          color: kAccentColor, // button color
                          child: InkWell(
                            // inkwell color
                            child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.white,
                                )),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 15, 10),
                child: Icon(Icons.edit, color: Colors.white))
          ])
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard();
      },
      itemCount: 30,
    );
  }
}
