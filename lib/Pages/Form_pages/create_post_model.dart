import 'dart:convert';

import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';

class CreatePostModel {
  int? status;
  String? message;
  PostModel? post;

  CreatePostModel({
    this.status,
    this.message,
    this.post,
  });

  CreatePostModel copyWith({
    int? status,
    String? message,
    PostModel? post,
  }) =>
      CreatePostModel(
        status: status ?? this.status,
        message: message ?? this.message,
        post: post ?? this.post,
      );

  factory CreatePostModel.fromRawJson(String str) =>
      CreatePostModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatePostModel.fromJson(Map<String, dynamic> json) =>
      CreatePostModel(
        status: json["status"],
        message: json["message"],
        post: json["post"] == null ? null : PostModel.fromJson(json["post"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "post": post?.toJson(),
      };
}
