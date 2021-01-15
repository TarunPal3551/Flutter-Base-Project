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
          id: 1,
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
          id: 2,
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
          color: Colors.indigo,
        ),
        SelectionCategory(
          name: "Addon Items",
          places: "432 Places",
          id: 3,
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
          color: Colors.teal,
        ),
        SelectionCategory(
          name: "Items",
          places: "843 Places",
          id: 4,
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
          color: Colors.orange,
        ),
        SelectionCategory(
          name: "Ingredients",
          places: "124 Places",
          id: 5,
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
          color: Colors.deepOrange,
        ),
        SelectionCategory(
          name: "Cooking",
          places: "732 Places",
          id: 6,
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
          color: Colors.pink,
        ),
        SelectionCategory(
          name: "Sizes",
          places: "984 Places",
          id: 7,
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
          color: Colors.red,
        ),
        SelectionCategory(
          name: "Fee",
          places: "215 Places",
          id: 8,
          image: Icon(
            Icons.category_rounded,
            size: 25,
            color: Colors.white,
          ),
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
  final int id;

  SelectionCategory({
    @required this.name,
    @required this.places,
    @required this.id,
    @required this.image,
    @required this.color,
  });
}
