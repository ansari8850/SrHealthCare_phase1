

import 'dart:convert';

import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';

class UserFollowing {
    final bool? success;
    final int? totalCount;
    final List<Following>? followings;
    final List<Follower>? followers;

    UserFollowing({
        this.success,
        this.totalCount,
        this.followings,
        this.followers,
    });

    UserFollowing copyWith({
        bool? success,
        int? totalCount,
        List<Following>? followings,
        List<Follower>? followers,
    }) => 
        UserFollowing(
            success: success ?? this.success,
            totalCount: totalCount ?? this.totalCount,
            followings: followings ?? this.followings,
             followers: followers ?? this.followers,
        );

    factory UserFollowing.fromJson(Map<String, dynamic> json) => UserFollowing(
        success: json["success"],
        totalCount: json["total_count"],
        followings: json["followings"] == null ? [] : List<Following>.from(json["followings"]!.map((x) => Following.fromJson(x))),
        followers: json["followers"] == null ? [] : List<Follower>.from(json["followers"]!.map((x) => Follower.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "total_count": totalCount,
        "followings": followings == null ? [] : List<dynamic>.from(followings!.map((x) => x.toJson())),
         "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x.toJson())),
    };
}

class Following {
    final int? id;
    final String? name;
    final dynamic lastName;
    final String? mobileNo;
    final String? loginType;
    final String? department;
    final String? email;
    final dynamic contactPersonName;
    final dynamic userTypeId;
    final dynamic workPhone;
    final String? field;
    final String? displayName;
    final dynamic businessLeagalName;
    final dynamic taxPreference;
    final dynamic gstNo;
    final dynamic panNo;
    final dynamic website;
    final dynamic registrationType;
    final String? bio;
    final dynamic subField;
    final String? emrMobileNo;
    final PhotoModel? photo;
    final String? education;
    final dynamic address;
    final dynamic remark;
    final String? attachments;
    final int? isDisabled;
    final String? password;
    final String? cPassword;
    final String? userType;
    final String? countryId;
    final dynamic date;
    final String? stateId;
    final String? cityId;
    final String? street1;
    final String? street2;
    final String? zipCode;
    final dynamic companyName;
    final dynamic contactPerson;
    final String? status;
    final dynamic workEmail;
    final String? fieldName;
    final int? otp;
    final String? otpVerify;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? fieldId;

    Following({
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
        this.fieldId,
    });

    Following copyWith({
        int? id,
        String? name,
        dynamic lastName,
        String? mobileNo,
        String? loginType,
        String? department,
        String? email,
        dynamic contactPersonName,
        dynamic userTypeId,
        dynamic workPhone,
        String? field,
        String? displayName,
        dynamic businessLeagalName,
        dynamic taxPreference,
        dynamic gstNo,
        dynamic panNo,
        dynamic website,
        dynamic registrationType,
        String? bio,
        dynamic subField,
        String? emrMobileNo,
        PhotoModel? photo,
        String? education,
        dynamic address,
        dynamic remark,
        String? attachments,
        int? isDisabled,
        String? password,
        String? cPassword,
        String? userType,
        String? countryId,
        dynamic date,
        String? stateId,
        String? cityId,
        String? street1,
        String? street2,
        String? zipCode,
        dynamic companyName,
        dynamic contactPerson,
        String? status,
        dynamic workEmail,
        String? fieldName,
        int? otp,
        String? otpVerify,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? fieldId,
    }) => 
        Following(
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
            fieldId: fieldId ?? this.fieldId,
        );

    factory Following.fromJson(Map<String, dynamic> json) => Following(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fieldId: json["field_id"],
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
        "field_id": fieldId,
    };
}


class Follower {
    final int? id;
    final String? name;
    final dynamic lastName;
    final String? mobileNo;
    final String? loginType;
    final String? department;
    final String? email;
    final dynamic contactPersonName;
    final String? userTypeId;
    final dynamic workPhone;
    final String? field;
    final String? displayName;
    final dynamic businessLeagalName;
    final dynamic taxPreference;
    final dynamic gstNo;
    final dynamic panNo;
    final dynamic website;
    final dynamic registrationType;
    final String? bio;
    final dynamic subField;
    final String? emrMobileNo;
    final PhotoModel? photo;
    final String? education;
    final dynamic address;
    final dynamic remark;
    final String? attachments;
    final int? isDisabled;
    final String? password;
    final String? cPassword;
    final String? userType;
    final String? countryId;
    final dynamic date;
    final String? stateId;
    final String? cityId;
    final String? street1;
    final String? street2;
    final String? zipCode;
    final dynamic companyName;
    final dynamic contactPerson;
    final String? status;
    final dynamic workEmail;
    final String? fieldName;
    final int? otp;
    final String? otpVerify;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? fieldId;
    final int? userId;

    Follower({
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
        this.fieldId,
        this.userId,
    });

    Follower copyWith({
        int? id,
        String? name,
        dynamic lastName,
        String? mobileNo,
        String? loginType,
        String? department,
        String? email,
        dynamic contactPersonName,
        String? userTypeId,
        dynamic workPhone,
        String? field,
        String? displayName,
        dynamic businessLeagalName,
        dynamic taxPreference,
        dynamic gstNo,
        dynamic panNo,
        dynamic website,
        dynamic registrationType,
        String? bio,
        dynamic subField,
        String? emrMobileNo,
        PhotoModel? photo,
        String? education,
        dynamic address,
        dynamic remark,
        String? attachments,
        int? isDisabled,
        String? password,
        String? cPassword,
        String? userType,
        String? countryId,
        dynamic date,
        String? stateId,
        String? cityId,
        String? street1,
        String? street2,
        String? zipCode,
        dynamic companyName,
        dynamic contactPerson,
        String? status,
        dynamic workEmail,
        String? fieldName,
        int? otp,
        String? otpVerify,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? fieldId,
        int? userId,
    }) => 
        Follower(
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
            fieldId: fieldId ?? this.fieldId,
            userId: userId ?? this.userId,
        );

    factory Follower.fromJson(Map<String, dynamic> json) => Follower(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fieldId: json["field_id"],
        userId: json["user_id"],
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
        "field_id": fieldId,
        "user_id": userId,
    };
}

