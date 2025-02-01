
class PostDetail {
  final bool success;
  final String message;
  final Post result;

  PostDetail({
    required this.success,
    required this.message,
    required this.result,
  });

  factory PostDetail.fromJson(Map<String, dynamic> json) {
    return PostDetail(
      success: json['success'],
      message: json['message'],
      result: Post.fromJson(json['result']),
    );
  }
}

class Post {
  final int id;
  final String userId;
  final String userName;
  final String? fieldName;
  final String? title;
  final String location;
  final String date;
  final String description;
  final String thumbnail;
  final String autoDeleteDate;
  final String status;
  final bool isDisabled;
  final String createdAt;
  final String updatedAt;
  final User user;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.fieldName,
    required this.title,
    required this.location,
    required this.date,
    required this.description,
    required this.thumbnail,
    required this.autoDeleteDate,
    required this.status,
    required this.isDisabled,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      fieldName: json['field_name'],
      title: json['title'],
      location: json['location'],
      date: json['date'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      autoDeleteDate: json['auto_delete_date'],
      status: json['status'],
      isDisabled: json['is_disabled'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String lastName;
  final String mobileNo;
  final String loginType;
  final String email;
  final String field;
  final String subField;
  final String emrMobileNo;
  final String photo;
  final String education;
  final String address;
  final String status;
  final int otp;
  final String otpVerify;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.mobileNo,
    required this.loginType,
    required this.email,
    required this.field,
    required this.subField,
    required this.emrMobileNo,
    required this.photo,
    required this.education,
    required this.address,
    required this.status,
    required this.otp,
    required this.otpVerify,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      mobileNo: json['mobile_no'],
      loginType: json['login_type'],
      email: json['email'],
      field: json['field'],
      subField: json['sub_field'],
      emrMobileNo: json['emr_mobile_no'],
      photo: json['photo'],
      education: json['education'],
      address: json['address'],
      status: json['status'],
      otp: json['otp'],
      otpVerify: json['otp_verify'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
