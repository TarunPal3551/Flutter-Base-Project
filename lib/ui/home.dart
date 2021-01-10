import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmerchant/models/selection_model.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';

import 'components/selection_card.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildCategoriesListView(context)],
      ),
    );
  }

  Column _buildCategoriesListView(BuildContext context) {
    var selectionCategory = SelectionCategory.generate();
    return Column(
      children: [
        SizedBox(
          height: 500,
          child: GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 4,
            scrollDirection: Axis.vertical,
            children: List.generate(selectionCategory.length, (index) {
              return CategoryCard(selectionCategory[index]);
            }),
          ),
        )
      ],
    );
  }
}
