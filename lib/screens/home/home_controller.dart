import 'dart:convert';

import 'package:fitness_app/screens/home/home_category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<HomeCategoryModel> categories = RxList<HomeCategoryModel>();

  Future<void> fetchCategories() async {
    final data = await rootBundle.loadString("json/info.json");
    final List jsonList = await jsonDecode(data);
    final List<HomeCategoryModel> result = [];
    for (final map in jsonList) {
      final model = HomeCategoryModel(image: map['img'], title: map['title']);
      result.add(model);
    }
    categories.value = result;
    //print(categories);
  }
}

