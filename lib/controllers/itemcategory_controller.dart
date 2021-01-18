import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:kmerchant/api/repository.dart';
import 'package:kmerchant/helper/constants.dart';
import 'package:kmerchant/models/addoncategory.dart' as addoncategory;
import 'package:kmerchant/models/addoncategory.dart';
import 'package:kmerchant/models/addonitem.dart';
import 'package:kmerchant/models/baseresponse.dart';
import 'package:kmerchant/models/itemcategory.dart' as itemcategory;
import 'package:kmerchant/models/itemcategory.dart';
import 'package:kmerchant/models/addonitem.dart' as addonlist;
import 'package:kmerchant/models/addonitemdetails.dart' as addoninfo;
import 'package:kmerchant/models/uploadresponse.dart';
import 'package:kmerchant/models/fooditems.dart' as fooditems;
import 'package:shared_preferences/shared_preferences.dart';

class ItemCategoryController extends GetxController {
  Repository repository = Repository();

  Future<itemcategory.Details> getAllItemCategory() async {
    try {
      var value = await repository.getItemCategory();
      if (value != null) {
        return value.details;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<addoninfo.Data> getAddonInfo(String id) async {
    try {
      var value = await repository.getAddonItemInfo(id);
      if (value != null) {
        return value.details.data;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> deleteCategory(String id) async {
    try {
      var value = await repository.deleteCategory(id);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> submitCategory(
      itemcategory.Data categoryData,
      String imageName,
      String thumbnailsUrl,
      String tittle,
      String description,
      bool isChecked) async {
    try {
      String val = "publish";
      if (isChecked) {
        val = "publish";
      } else {
        val = "draft";
      }
      var value = await repository.editItemCategory(
          categoryData, imageName, thumbnailsUrl, tittle, description, val);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<addoncategory.Details> getAllAddonCategory() async {
    try {
      var value = await repository.getAddonItemCategory();
      if (value != null) {
        return value.details;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> deleteAddonCategory(String id) async {
    try {
      var value = await repository.deleteCategory(id);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> submitAddonCategory(addoncategory.Data categoryData,
      String tittle, String description, bool isChecked) async {
    try {
      String val = "publish";
      if (isChecked) {
        val = "publish";
      } else {
        val = "draft";
      }
      var value = await repository.editAddonItemCategory(
          categoryData, tittle, description, val);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<addonlist.Details> getAllAddonItems() async {
    try {
      var value = await repository.getAddonItem();
      if (value != null) {
        return value.details;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> deleteAddonItem(String id) async {
    try {
      var value = await repository.deleteCategory(id);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> submitAddonItem(
      addoninfo.Data categoryData,
      String imageName,
      String thumbnailsUrl,
      String tittle,
      String description,
      String price,
      List<String> selectedCategory,
      bool isChecked) async {
    try {
      String val = "publish";
      if (isChecked) {
        val = "publish";
      } else {
        val = "draft";
      }
      var value = await repository.editAddonItem(categoryData, imageName,
          thumbnailsUrl, tittle, description, price, selectedCategory, val);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<fooditems.Details> getAllFoodItems() async {
    try {
      var value = await repository.getFoodItems();
      if (value != null) {
        return value.details;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> deleteFoodItems(String id) async {
    try {
      var value = await repository.deleteCategory(id);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<BaseResponse> submitFoodItems(
      itemcategory.Data categoryData,
      String imageName,
      String thumbnailsUrl,
      String tittle,
      String description,
      bool isChecked) async {
    try {
      String val = "publish";
      if (isChecked) {
        val = "publish";
      } else {
        val = "draft";
      }
      var value = await repository.editItemCategory(
          categoryData, imageName, thumbnailsUrl, tittle, description, val);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UploadResponse> uploadImage(
    File categoryImage,
  ) async {
    try {
      var value = await repository.uploadFile(categoryImage);
      if (value != null) {
        return value;
      }
    } catch (e) {
      print(e);
    }
  }
}
