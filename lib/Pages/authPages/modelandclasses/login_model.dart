import 'dart:convert';

import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';

class LoginModelClass {
  bool? error;
  String? message;
  String? accessToken;
  int? status;
  bool? verify;
  UserModel? result;

  LoginModelClass({
    this.error,
    this.message,
    this.accessToken,
    this.status,
    this.verify,
    this.result,
  });

  LoginModelClass copyWith({
    bool? error,
    String? message,
    String? accessToken,
    int? status,
    bool? verify,
    UserModel? result,
  }) =>
      LoginModelClass(
        error: error ?? this.error,
        message: message ?? this.message,
        accessToken: accessToken ?? this.accessToken,
        status: status ?? this.status,
        verify: verify ?? this.verify,
        result: result ?? this.result,
      );

  factory LoginModelClass.fromRawJson(String str) =>
      LoginModelClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginModelClass.fromJson(Map<String, dynamic> json) =>
      LoginModelClass(
        error: json["error"],
        message: json["message"],
        accessToken: json["access_token"],
        status: json["status"],
        verify: json["verify"],
        result:
            json["result"] == null ? null : UserModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "access_token": accessToken,
        "status": status,
        "verify": verify,
        "result": result?.toJson(),
      };
}

class UserModel {
  int? id;
  String? name;
  String? lastName;
  String? mobileNo;
  String? loginType;
  dynamic department;
  String? email;
  dynamic contactPersonName;
  dynamic userTypeId;
  dynamic workPhone;
  dynamic field;
  dynamic displayName;
  dynamic businessLeagalName;
  dynamic taxPreference;
  dynamic gstNo;
  dynamic panNo;
  dynamic website;
  dynamic registrationType;
  dynamic bio;
  dynamic subField;
  String? emrMobileNo;
  PhotoModel? photo;
  dynamic education;
  dynamic address;
  dynamic remark;
  dynamic attachments;
  int? isDisabled;
  String? password;
  dynamic cPassword;
  dynamic userType;
  dynamic countryId;
  dynamic date;
  dynamic stateId;
  dynamic cityId;
  dynamic street1;
  dynamic street2;
  dynamic zipCode;
  dynamic companyName;
  dynamic contactPerson;
  String? status;
  dynamic workEmail;
  dynamic fieldName;
  int? otp;
  String? otpVerify;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
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

  UserModel copyWith({
    int? id,
    String? name,
    String? lastName,
    String? mobileNo,
    String? loginType,
    dynamic department,
    String? email,
    dynamic contactPersonName,
    dynamic userTypeId,
    dynamic workPhone,
    dynamic field,
    dynamic displayName,
    dynamic businessLeagalName,
    dynamic taxPreference,
    dynamic gstNo,
    dynamic panNo,
    dynamic website,
    dynamic registrationType,
    dynamic bio,
    dynamic subField,
    String? emrMobileNo,
    PhotoModel? photo,
    dynamic education,
    dynamic address,
    dynamic remark,
    dynamic attachments,
    int? isDisabled,
    String? password,
    dynamic cPassword,
    dynamic userType,
    dynamic countryId,
    dynamic date,
    dynamic stateId,
    dynamic cityId,
    dynamic street1,
    dynamic street2,
    dynamic zipCode,
    dynamic companyName,
    dynamic contactPerson,
    String? status,
    dynamic workEmail,
    dynamic fieldName,
    int? otp,
    String? otpVerify,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        mobileNo: mobileNo ?? this.mobileNo,
        loginType: loginType ?? this.loginType,
        department: department ?? this.department,
        email: email ?? this.email,
        contactPersonName: contactPersonName ?? this.contactPersonName,
        userTypeId: userTypeId ?? this.userTypeId,
        workPhone: workPhone ?? this.workPhone,
        field: field ?? this.field,
        displayName: displayName ?? this.displayName,
        businessLeagalName: businessLeagalName ?? this.businessLeagalName,
        taxPreference: taxPreference ?? this.taxPreference,
        gstNo: gstNo ?? this.gstNo,
        panNo: panNo ?? this.panNo,
        website: website ?? this.website,
        registrationType: registrationType ?? this.registrationType,
        bio: bio ?? this.bio,
        subField: subField ?? this.subField,
        emrMobileNo: emrMobileNo ?? this.emrMobileNo,
        photo: photo ?? this.photo,
        education: education ?? this.education,
        address: address ?? this.address,
        remark: remark ?? this.remark,
        attachments: attachments ?? this.attachments,
        isDisabled: isDisabled ?? this.isDisabled,
        password: password ?? this.password,
        cPassword: cPassword ?? this.cPassword,
        userType: userType ?? this.userType,
        countryId: countryId ?? this.countryId,
        date: date ?? this.date,
        stateId: stateId ?? this.stateId,
        cityId: cityId ?? this.cityId,
        street1: street1 ?? this.street1,
        street2: street2 ?? this.street2,
        zipCode: zipCode ?? this.zipCode,
        companyName: companyName ?? this.companyName,
        contactPerson: contactPerson ?? this.contactPerson,
        status: status ?? this.status,
        workEmail: workEmail ?? this.workEmail,
        fieldName: fieldName ?? this.fieldName,
        otp: otp ?? this.otp,
        otpVerify: otpVerify ?? this.otpVerify,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
        photo: json["photo"] == null || json["photo"] == ""
            ? null
            : PhotoModel.fromJson(
                json["photo"] is String
                    ? jsonDecode(json["photo"])
                    : json["photo"],
              ),
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
        "photo": photo?.toJson(),
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
