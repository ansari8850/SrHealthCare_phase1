import 'dart:convert';

class PostDetailModel {
  bool? success;
  String? message;
  Result? result;

  PostDetailModel({
    this.success,
    this.message,
    this.result,
  });

  factory PostDetailModel.fromRawJson(String str) =>
      PostDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      PostDetailModel(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": result?.toJson(),
      };
}

class Result {
  int? id;
  String? userId;
  String? userName;
  String? fieldId;
  PostType? postType;
  String? fieldName;
  String? title;
  String? location;
  DateTime? date;
  String? description;
  String? thumbnail;
  dynamic autoDeleteDate;
  String? status;
  int? isDisabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? postTypeId;
  User? user;

  Result({
    this.id,
    this.userId,
    this.userName,
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
    this.postTypeId,
    this.user,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        fieldId: json["field_id"],
        postType: json["post_type"] == null
            ? null
            : PostType.fromJson(json["post_type"]),
        fieldName: json["field_name"],
        title: json["title"],
        location: json["location"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"],
        thumbnail: json["thumbnail"],
        autoDeleteDate: json["auto_delete_date"],
        status: json["status"],
        isDisabled: json["is_disabled"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        postTypeId: json["post_type_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "field_id": fieldId,
        "post_type": postType?.toJson(),
        "field_name": fieldName,
        "title": title,
        "location": location,
        "date": date?.toIso8601String(),
        "description": description,
        "thumbnail": thumbnail,
        "auto_delete_date": autoDeleteDate,
        "status": status,
        "is_disabled": isDisabled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "post_type_id": postTypeId,
        "user": user?.toJson(),
      };
}

class PostType {
  int? id;
  String? type;
  String? name;
  dynamic parentId;
  dynamic extraData;
  String? fieldId;
  String? location;
  dynamic subType;
  String? fieldName;
  int? isDisabled;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostType({
    this.id,
    this.type,
    this.name,
    this.parentId,
    this.extraData,
    this.fieldId,
    this.location,
    this.subType,
    this.fieldName,
    this.isDisabled,
    this.createdAt,
    this.updatedAt,
  });

  factory PostType.fromRawJson(String str) =>
      PostType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostType.fromJson(Map<String, dynamic> json) => PostType(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        parentId: json["parent_id"],
        extraData: json["extra_data"],
        fieldId: json["field_id"],
        location: json["location"],
        subType: json["sub_type"],
        fieldName: json["field_name"],
        isDisabled: json["is_disabled"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "parent_id": parentId,
        "extra_data": extraData,
        "field_id": fieldId,
        "location": location,
        "sub_type": subType,
        "field_name": fieldName,
        "is_disabled": isDisabled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  int? id;
  String? name;
  String? lastName;
  String? mobileNo;
  String? loginType;
  String? department;
  String? email;
  dynamic contactPersonName;
  String? userTypeId;
  dynamic workPhone;
  String? field;
  String? displayName;
  dynamic businessLeagalName;
  dynamic taxPreference;
  dynamic gstNo;
  dynamic panNo;
  dynamic website;
  dynamic registrationType;
  String? bio;
  dynamic subField;
  String? emrMobileNo;
  String? photo;
  dynamic education;
  dynamic address;
  dynamic remark;
  String? attachments;
  int? isDisabled;
  dynamic password;
  String? cPassword;
  String? userType;
  String? countryId;
  dynamic date;
  String? stateId;
  String? cityId;
  String? street1;
  dynamic street2;
  String? zipCode;
  dynamic companyName;
  dynamic contactPerson;
  String? status;
  dynamic workEmail;
  String? fieldName;
  int? otp;
  String? otpVerify;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.lastName,
    this.mobileNo,
    this.loginType,
    this.department,
    this.email,
    this.contactPersonName,
    this.userTypeId,
    this.workPhone,
    this.field,
    this.displayName,
    this.businessLeagalName,
    this.taxPreference,
    this.gstNo,
    this.panNo,
    this.website,
    this.registrationType,
    this.bio,
    this.subField,
    this.emrMobileNo,
    this.photo,
    this.education,
    this.address,
    this.remark,
    this.attachments,
    this.isDisabled,
    this.password,
    this.cPassword,
    this.userType,
    this.countryId,
    this.date,
    this.stateId,
    this.cityId,
    this.street1,
    this.street2,
    this.zipCode,
    this.companyName,
    this.contactPerson,
    this.status,
    this.workEmail,
    this.fieldName,
    this.otp,
    this.otpVerify,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        mobileNo: json["mobile_no"],
        loginType: json["login_type"],
        department: json["department"],
        email: json["email"],
        contactPersonName: json["contact_person_name"],
        userTypeId: json["user_type_id"],
        workPhone: json["work_phone"],
        field: json["field"],
        displayName: json["display_name"],
        businessLeagalName: json["business_leagal_name"],
        taxPreference: json["tax_preference"],
        gstNo: json["gst_no"],
        panNo: json["pan_no"],
        website: json["website"],
        registrationType: json["registration_type"],
        bio: json["bio"],
        subField: json["sub_field"],
        emrMobileNo: json["emr_mobile_no"],
        photo: json["photo"],
        education: json["education"],
        address: json["address"],
        remark: json["remark"],
        attachments: json["attachments"],
        isDisabled: json["is_disabled"],
        password: json["password"],
        cPassword: json["c_password"],
        userType: json["user_type"],
        countryId: json["country_id"],
        date: json["date"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        street1: json["street_1"],
        street2: json["street_2"],
        zipCode: json["zip_code"],
        companyName: json["company_name"],
        contactPerson: json["contact_person"],
        status: json["status"],
        workEmail: json["work_email"],
        fieldName: json["field_name"],
        otp: json["otp"],
        otpVerify: json["otp_verify"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "mobile_no": mobileNo,
        "login_type": loginType,
        "department": department,
        "email": email,
        "contact_person_name": contactPersonName,
        "user_type_id": userTypeId,
        "work_phone": workPhone,
        "field": field,
        "display_name": displayName,
        "business_leagal_name": businessLeagalName,
        "tax_preference": taxPreference,
        "gst_no": gstNo,
        "pan_no": panNo,
        "website": website,
        "registration_type": registrationType,
        "bio": bio,
        "sub_field": subField,
        "emr_mobile_no": emrMobileNo,
        "photo": photo,
        "education": education,
        "address": address,
        "remark": remark,
        "attachments": attachments,
        "is_disabled": isDisabled,
        "password": password,
        "c_password": cPassword,
        "user_type": userType,
        "country_id": countryId,
        "date": date,
        "state_id": stateId,
        "city_id": cityId,
        "street_1": street1,
        "street_2": street2,
        "zip_code": zipCode,
        "company_name": companyName,
        "contact_person": contactPerson,
        "status": status,
        "work_email": workEmail,
        "field_name": fieldName,
        "otp": otp,
        "otp_verify": otpVerify,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
