class User {
  final int id;
  final String userName;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String email;
  final String field;
  final String subField;
  final String emrMobileNo;
  final String photo;
  final String education;
  final String address;
  final String status;
  final String createdAt;
  final String updatedAt;
  dynamic companyName;

  User(
      {required this.id,
      required this.userName,
      required this.firstName,
      required this.lastName,
      required this.mobileNo,
      required this.email,
      required this.field,
      required this.subField,
      required this.emrMobileNo,
      required this.photo,
      required this.education,
      required this.address,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.companyName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['name'] ?? '',
      firstName: json['name'] ?? '',
      lastName: json['last_name'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      email: json['email'] ?? '',
      field: json['field'] ?? '',
      subField: json['sub_field'] ?? '',
      emrMobileNo: json['emr_mobile_no'] ?? '',
      photo: json['photo'] ?? '',
      education: json['education'] ?? '',
      address: json['address'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      companyName: json['company_name'] ?? '',
    );
  }
}
