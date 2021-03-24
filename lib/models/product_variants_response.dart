import 'package:flutter_animation/models/product_variant_model.dart';

import 'link.dart';

class ProductVariantResponse {
  Link links;
  int count;
  List<ProductVariantsModel> results;

  ProductVariantResponse({this.links, this.count, this.results});

  ProductVariantResponse.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? Link.fromJson(json['links']) : null;
    count = json['count'];
    results = List<ProductVariantsModel>();
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(ProductVariantsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
