import 'category_model.dart';
import 'link.dart';

class CategoryResponse {
  Link links;
  int count;
  List<CategoryModel> results;

  CategoryResponse({this.links, this.count, this.results});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? new Link.fromJson(json['links']) : null;
    count = json['count'];
    if (json['results'] != null) {
      results = new List<CategoryModel>();
      json['results'].forEach((v) {
        results.add(new CategoryModel.fromJson(v));
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
