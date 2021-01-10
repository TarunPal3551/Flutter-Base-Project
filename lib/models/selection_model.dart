import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmerchant/theme.dart';

class SelectionCategory {
  static List<SelectionCategory> mockCategories;

  static List<SelectionCategory> generate() {
    mockCategories = [];
    mockCategories.addAll(
      [
        SelectionCategory(
          name: "Category",
          places: "2215 Places",
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
          color: kAccentColor,
        ),
        SelectionCategory(
          name: "Add On",
          places: "658 Places",
          image: Icon(Icons.category),
          color: Colors.indigo,
        ),
        SelectionCategory(
          name: "Addon Items",
          places: "432 Places",
          image: Icon(Icons.category),
          color: Colors.teal,
        ),
        SelectionCategory(
          name: "Items",
          places: "843 Places",
          image: Icon(Icons.category),
          color: Colors.orange,
        ),
        SelectionCategory(
          name: "Ingredients",
          places: "124 Places",
          image: Icon(Icons.category),
          color: Colors.deepOrange,
        ),
        SelectionCategory(
          name: "Cooking",
          places: "732 Places",
          image: Icon(Icons.category),
          color: Colors.pink,
        ),
        SelectionCategory(
          name: "Sizes",
          places: "984 Places",
          image: Icon(Icons.category),
          color: Colors.red,
        ),
        SelectionCategory(
          name: "Fee",
          places: "215 Places",
          image: Icon(Icons.category),
          color: Colors.teal,
        ),

        //   SelectionCategory(
        //     name: "Tables",
        //     places: "215 Places",
        //     image: Icon(Icons.category),
        //     color: Colors.teal,
        //   ),
        //   SelectionCategory(
        //     name: "Offers",
        //     places: "215 Places",
        //     image: Icon(Icons.category),
        //     color: Colors.teal,
        //   ),
        //   SelectionCategory(
        //     name: "Gallery",
        //     places: "215 Places",
        //     image: Icon(Icons.category),
        //     color: Colors.teal,
        //   ),
        //   SelectionCategory(
        //     name: "Banners",
        //     places: "215 Places",
        //     image: Icon(Icons.category),
        //     color: Colors.teal,
        //   ),
        //   SelectionCategory(
        //     name: "Voucher",
        //     places: "215 Places",
        //     image: Icon(Icons.category),
        //     color: Colors.teal,
        //   )
      ],
    );
    return mockCategories;
  }

  final String name;
  final String places;
  final Widget image;
  final Color color;

  SelectionCategory({
    @required this.name,
    @required this.places,
    @required this.image,
    @required this.color,
  });
}
