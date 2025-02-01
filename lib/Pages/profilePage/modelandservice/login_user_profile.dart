// Define the model class for the API response

import 'dart:convert';

import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';

class LoginUserProfile {
  final int? id;
  final String? name;
  final String? lastName;
  final String? mobileNo;
  final String? loginType;
  final String? department;
  final String? email;
  final String? contactPersonName;
  final String? userTypeId;
  final String? workPhone;
  final String? field;
  final String? displayName;
  final String? businessLegalName;
  final String? taxPreference;
  final String? gstNo;
  final String? panNo;
  final String? website;
  final String? registrationType;
  final String? bio;
  final String? subField;
  final String? emrMobileNo;
  final PhotoModel? photo;
  final String? education;
  final String? address;
  final String? remark;
  final String? attachments;
  final int? isDisabled;
  final String? password;
  final String? cPassword;
  final String? userType;
  final String? countryId;
  final String? date;
  final String? stateId;
  final String? cityId;
  final String? street1;
  final String? street2;
  final String? zipCode;
  final String? companyName;
  final String? contactPerson;
  final String? status;
  final String? workEmail;
  final String? fieldName;
  final int? otp;
  final String? otpVerify;
  final String? createdAt;
  final String? updatedAt;

  LoginUserProfile({
    required this.id,
    required this.name,
    required this.lastName,
    required this.mobileNo,
    required this.loginType,
    required this.department,
    required this.email,
    required this.contactPersonName,
    required this.userTypeId,
    required this.workPhone,
    required this.field,
    required this.displayName,
    this.businessLegalName,
    this.taxPreference,
    this.gstNo,
    this.panNo,
    this.website,
    required this.registrationType,
    this.bio,
    required this.subField,
    required this.emrMobileNo,
    required this.photo,
    required this.education,
    required this.address,
    this.remark,
    required this.attachments,
    required this.isDisabled,
    required this.password,
    this.cPassword,
    required this.userType,
    this.countryId,
    this.date,
    this.stateId,
    this.cityId,
    this.street1,
    this.street2,
    this.zipCode,
    required this.companyName,
    this.contactPerson,
    required this.status,
    required this.workEmail,
    required this.fieldName,
    required this.otp,
    required this.otpVerify,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoginUserProfile.fromJson(Map<String, dynamic> json) {
    return LoginUserProfile(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      mobileNo: json['mobile_no'],
      loginType: json['login_type'],
      department: json['department'],
      email: json['email'],
      contactPersonName: json['contact_person_name'],
      userTypeId: json['user_type_id'],
      workPhone: json['work_phone'],
      field: json['field'],
      displayName: json['display_name'],
      businessLegalName: json['business_leagal_name'],
      taxPreference: json['tax_preference'],
      gstNo: json['gst_no'],
      panNo: json['pan_no'],
      website: json['website'],
      registrationType: json['registration_type'],
      bio: json['bio'],
      subField: json['sub_field'],
      emrMobileNo: json['emr_mobile_no'],
      photo: json["photo"] == null || json["photo"] == ""
    ? null
    : PhotoModel.fromJson(
        json["photo"] is String ? jsonDecode(json["photo"]) : json["photo"],
      ),

      education: json['education'],
      address: json['address'],
      remark: json['remark'],
      attachments: (json['attachments']),
      isDisabled: json['is_disabled'],
      password: json['password'],
      cPassword: json['c_password'],
      userType: json['user_type'],
      countryId: json['country_id'],
      date: json['date'],
      stateId: json['state_id'],
      cityId: json['city_id'],
      street1: json['street_1'],
      street2: json['street_2'],
      zipCode: json['zip_code'],
      companyName: json['company_name'],
      contactPerson: json['contact_person'],
      status: json['status'],
      workEmail: json['work_email'],
      fieldName: json['field_name'],
      otp: json['otp'],
      otpVerify: json['otp_verify'],
      createdAt: (json['created_at']),
      updatedAt: (json['updated_at']),
    );
  }
}
