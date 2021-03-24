import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animation/models/breadcrumb_model.dart';
import 'package:flutter_animation/models/category_model.dart';
import 'package:http/http.dart';

class CategoryViewModel with ChangeNotifier {
  bool loading = true;
  final List<CategoryModel> currentCategories = [];
  final List<CategoryModel> allCategories = [];
  final List<BreadcrumbItem> breadCrumbs = [];
  int activeCategoryId;
  CategoryViewModel() {
    _getCategoriesFromNetwork();
  }

  void _getCategoriesFromNetwork() async {
    try {
      final res = await get(
          "https://shatkora.co/api/product/v1/categories/?nested=true");
      print("category response status ${res.statusCode}");
      if (res.statusCode == 200) {
        List<dynamic> data = jsonDecode(res.body);
        allCategories.clear();
        data.forEach((element) {
          final item = CategoryModel.fromJson(element);
          allCategories.add(item);
        });
        breadCrumbs.add(BreadcrumbItem("Categories", null));
        activeCategoryId = null;
        updateCategoryActiveList(allCategories);
        print("found items ${allCategories.length}");
      }
    } catch (e) {
      print("error retrieving categories $e");
    }

    loading = false;
    notifyListeners();
  }

  void onCategoryItemClicked(CategoryModel clickedItem) {
    breadCrumbs.add(BreadcrumbItem(clickedItem.title, clickedItem.id));
    currentCategories.clear();
    activeCategoryId = clickedItem.id;
    updateCategoryActiveList(allCategories);
    notifyListeners();
  }

  void updateCategoryActiveList(List<CategoryModel> items) {
    if (activeCategoryId == null) {
      currentCategories.addAll(allCategories);
      return;
    }
    if (items == null || items.isEmpty) return;
    items.forEach((element) {
      if (element.id == activeCategoryId) {
        this.currentCategories.addAll(element.children);
        return;
      }
      updateCategoryActiveList(element.children);
    });
  }

  void onBreadcrumbClicked(BreadcrumbItem item, int position) {
    breadCrumbs.removeRange(position + 1, breadCrumbs.length);
    currentCategories.clear();
    activeCategoryId = item.categoryId;
    updateCategoryActiveList(allCategories);
    notifyListeners();
  }
}
