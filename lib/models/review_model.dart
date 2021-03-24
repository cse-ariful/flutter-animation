import 'image.dart';

class ReviewModel {
  int id;
  User user;
  int variant;
  double rating;
  String message;
  List<Images> images;
  String createdDate;
  String modifiedDate;

  ReviewModel(
      {this.id,
      this.user,
      this.variant,
      this.rating,
      this.message,
      this.images,
      this.createdDate,
      this.modifiedDate});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = User.fromJson(json['user']);
    variant = json['variant'];
    rating = json['rating'];
    message = json['message'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    createdDate = json['created_date'];
    modifiedDate = json['modified_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['variant'] = this.variant;
    data['rating'] = this.rating;
    data['message'] = this.message;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['created_date'] = this.createdDate;
    data['modified_date'] = this.modifiedDate;
    return data;
  }
}

class User {
  String firstName;
  String lastName;
  String avatar;

  User({this.firstName, this.lastName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}
