import 'package:my_learn_gadgets_web/models/user_model.dart';

class ReviewModel {
  String id;
  String productId;
  UserModel postedBy;
  String title;
  String description;
  double rating;
  DateTime postedOn;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.postedBy,
    required this.title,
    required this.description,
    required this.rating,
    required this.postedOn,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      productId: json['productId'],
      postedBy: UserModel.fromJson(json['postedBy']),
      title: json['title'],
      description: json['description'],
      rating: double.parse(json['rating'].toString()),
      postedOn: DateTime.parse(json['postedOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'postedBy': postedBy.toJson(),
      'title': title,
      'description': description,
      'rating': rating,
      'postedOn': postedOn.toIso8601String(),
    };
  }
}
