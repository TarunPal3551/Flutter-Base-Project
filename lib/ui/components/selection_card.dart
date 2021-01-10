import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmerchant/models/selection_model.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';
import 'package:kmerchant/ui/screens/category_form.dart';
import 'package:kmerchant/ui/screens/category_list.dart';

class CategoryCard extends StatelessWidget {
  final SelectionCategory category;

  CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 80,
      height: 50,
      padding: 15,
      backgroundColor: category.color,
      shadowColor: category.color,
      borderRadius: 15,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryList()),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: category.image),
          FittedBox(
            child: Text(
              category.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
