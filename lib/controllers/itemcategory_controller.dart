import 'dart:io';

import 'package:get/get.dart';
import 'package:kmerchant/api/repository.dart';
import 'package:kmerchant/helper/constants.dart';
import 'package:kmerchant/models/baseresponse.dart';
import 'package:kmerchant/models/itemcategory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemCategoryController extends GetxController {
  Repository repository = Repository();

  Future<Details> getAllItemCategory() async {
    try {
      var value = await repository.getItemCategory();
      if (value != null) {
        return value.details;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> submitCategory(
      Data categoryData, File categoryImage, String tittle, String description) async {
    try {
      var value =
          await repository.editItemCategory(categoryData, categoryImage,tittle,description);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }
}
