import 'package:flutter_animation/models/review_model.dart';

import 'image.dart';

class ProductVariantsModel {
  int id;
  int productId;
  String title;
  String sku;
  double originalPrice;
  double discount;
  String thumb;
  String defaultImage;
  int cartCount = 0;
  double rating;
  List<Images> images;
  String createdDate;
  String modifiedDate;
  String measurements;
  double measurementValue;
  double salePrice;
  int maxAllocation;
  ReviewModel userReview;
  int measurementUnit;

  ProductVariantsModel(
      {this.id,
      this.title,
      this.sku,
      this.productId,
      this.rating,
      this.originalPrice,
      this.discount,
      this.images,
      this.createdDate,
      this.modifiedDate});

  ProductVariantsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    productId = json['product'];
    maxAllocation = json['max_allocation'];
    sku = json['sku'];

    originalPrice = json['original_price'] != null
        ? double.parse(json['original_price'])
        : 0.0;
    salePrice =
        json['sale_price'] != null ? double.parse(json['sale_price']) : 0.0;

    if (json["review"] != null) {
      userReview = ReviewModel.fromJson(json["review"]);
    }
    measurements = json["measurement"];
    measurementValue = json["measurement_value"]?.toDouble() ?? 0.0;
    measurementUnit = json["measurement_unit"];

    discount = json['discount'] != null ? json['discount'] : 0.0;
    //rating = json['rating'];
    if (json['images'] != null) {
      images = List<Images>();
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
      if (images != null && images.length > 0) {
        defaultImage = images[0].image;
        thumb = images[0].thumbnail;
      }
    }

    createdDate = json['created_date'];
    modifiedDate = json['modified_date'];
  }
  double checkDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sku'] = this.sku;
    data['original_price'] = this.originalPrice;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['product'] = this.productId;
    data['max_allocation'] = maxAllocation;
    data["measurement"] = measurements;
    data['sale_price'] = salePrice;
    data["measurement_value"] = measurementValue;
    data["measurement_unit"] = measurementUnit;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (userReview != null) {
      data["review"] = userReview.toJson();
    }
    data['created_date'] = this.createdDate;
    data['modified_date'] = this.modifiedDate;
    return data;
  }
}
