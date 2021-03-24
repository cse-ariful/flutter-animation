class CategoryModel {
  int id;
  int parent;
  bool isLeaf;
  String title;
  String slug;
  String description;
  int itemCount;
  String image;
  String alt;
  double tax;
  bool active = false;
  String createdDate;
  String modifiedDate;
  List<CategoryModel> children = [];

  CategoryModel(
      {this.id,
      this.parent,
      this.isLeaf,
      this.title,
      this.slug,
      this.description,
      this.itemCount,
      this.image,
      this.alt,
      this.active: false,
      this.children,
      this.tax,
      this.createdDate,
      this.modifiedDate});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isLeaf = json['is_leaf'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    itemCount = json['item_count'];
    if (json['children'] != null) {
      children = new List<CategoryModel>();
      json['children'].forEach((v) {
        children.add(new CategoryModel.fromJson(v));
      });
    }

    image = json['image'];
    alt = json['alt'];
    tax = json['tax'];
    createdDate = json['created_date'];
    modifiedDate = json['modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['is_leaf'] = this.isLeaf;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['item_count'] = this.itemCount;
    data['image'] = this.image;
    data['alt'] = this.alt;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    data['tax'] = this.tax;
    data['created_date'] = this.createdDate;
    data['modified_date'] = this.modifiedDate;
    return data;
  }
}
