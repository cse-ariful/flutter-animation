class Images {
  int id;
  String image;
  String thumbnail;
  String alt;

  Images({this.id, this.image, this.thumbnail, this.alt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['alt'] = this.alt;
    return data;
  }
}
