// Model Classes
class PostListResponse {
  final List<Post> postList;
  final int count;
  final String message;

  PostListResponse({
    required this.postList,
    required this.count,
    required this.message,
  });

  factory PostListResponse.fromJson(Map<String, dynamic> json) {
    return PostListResponse(
      postList:
          (json['postList'] as List?)?.map((e) => Post.fromJson(e)).toList() ??
              [],
      count: json['count'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}

class Post {
  final int id;
  final String userId;
  final String userName;
  final String? fieldId;
  final String? postType;
  final String? fieldName;
  final String? title;
  final String? location;
  final String? date;
  final String? description;
  final String? thumbnail;
  final String? autoDeleteDate;
  final String? status;
  final int? isDisabled;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    this.fieldId,
    this.postType,
    this.fieldName,
    this.title,
    this.location,
    this.date,
    this.description,
    this.thumbnail,
    this.autoDeleteDate,
    this.status,
    this.isDisabled,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? '',
      fieldId: json['field_id'],
      postType: json['post_type'],
      fieldName: json['field_name'],
      title: json['title'],
      location: json['location'],
      date: json['date'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      autoDeleteDate: json['auto_delete_date'],
      status: json['status'],
      isDisabled: json['is_disabled'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}

class User {
  final int id;
  final String name;
  final String? lastName;
  final String? email;
  final String? field;
  final String? subField;
  final String? photo;

  User({
    required this.id,
    required this.name,
    this.lastName,
    this.email,
    this.field,
    this.subField,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      lastName: json['last_name'],
      email: json['email'],
      field: json['field'],
      subField: json['sub_field'],
      photo: json['photo'],
    );
  }
}
