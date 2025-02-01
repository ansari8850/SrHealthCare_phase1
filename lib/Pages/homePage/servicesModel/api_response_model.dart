// To parse this JSON data, do
//
//     final homePostListModel = homePostListModelFromJson(jsonString);

import 'dart:convert';

import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';

HomePostListModel homePostListModelFromJson(String str) => HomePostListModel.fromJson(json.decode(str));

String homePostListModelToJson(HomePostListModel data) => json.encode(data.toJson());

class HomePostListModel {
    final List<PostModel>? postList;
    final int? count;
    final String? message;

    HomePostListModel({
        this.postList,
        this.count,
        this.message,
    });

    HomePostListModel copyWith({
        List<PostModel>? postList,
        int? count,
        String? message,
    }) => 
        HomePostListModel(
            postList: postList ?? this.postList,
            count: count ?? this.count,
            message: message ?? this.message,
        );

    factory HomePostListModel.fromJson(Map<String, dynamic> json) => HomePostListModel(
        postList: json["postList"] == null ? [] : List<PostModel>.from(json["postList"]!.map((x) => PostModel.fromJson(x))),
        count: json["count"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "postList": postList == null ? [] : List<dynamic>.from(postList!.map((x) => x.toJson())),
        "count": count,
        "message": message,
    };
}

enum FieldName {
    AYURVEDA,
    HOMEOPATHYYY
}

final fieldNameValues = EnumValues({
    "Ayurveda": FieldName.AYURVEDA,
    "Homeopathyyy": FieldName.HOMEOPATHYYY
});

class PostType {
    final int? id;
    final String? type;
    final String? name;
    final dynamic parentId;
    final dynamic extraData;
    final String? fieldId;
    final String? location;
    final dynamic subType;
    final FieldName? fieldName;
    final int? isDisabled;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final Status? status;

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
        this.status,
    });

    PostType copyWith({
        int? id,
        String? type,
        String? name,
        dynamic parentId,
        dynamic extraData,
        String? fieldId,
        String? location,
        dynamic subType,
        FieldName? fieldName,
        int? isDisabled,
        DateTime? createdAt,
        DateTime? updatedAt,
        Status? status,
    }) => 
        PostType(
            id: id ?? this.id,
            type: type ?? this.type,
            name: name ?? this.name,
            parentId: parentId ?? this.parentId,
            extraData: extraData ?? this.extraData,
            fieldId: fieldId ?? this.fieldId,
            location: location ?? this.location,
            subType: subType ?? this.subType,
            fieldName: fieldName ?? this.fieldName,
            isDisabled: isDisabled ?? this.isDisabled,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            status: status ?? this.status,
        );

    factory PostType.fromJson(Map<String, dynamic> json) => PostType(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        parentId: json["parent_id"],
        extraData: json["extra_data"],
        fieldId: json["field_id"],
        location: json["location"],
        subType: json["sub_type"],
        fieldName: fieldNameValues.map[json["field_name"]]!,
        isDisabled: json["is_disabled"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: statusValues.map[json["status"]]!,
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
        "field_name": fieldNameValues.reverse[fieldName],
        "is_disabled": isDisabled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": statusValues.reverse[status],
    };
}

enum Status {
    ACTIVE
}

final statusValues = EnumValues({
    "Active": Status.ACTIVE
});

class User {
    final int? id;
    final Name? name;
    final LastName? lastName;
    final String? mobileNo;
    final LoginType? loginType;
    final Department? department;
    final Email? email;
    final String? contactPersonName;
    final String? userTypeId;
    final String? workPhone;
    final String? field;
    final String? displayName;
    final String? businessLeagalName;
    final String? taxPreference;
    final String? gstNo;
    final String? panNo;
    final String? website;
    final String? registrationType;
    final String? bio;
    final Department? subField;
    final String? emrMobileNo;
    final String? photo;
    final String? education;
    final String? address;
    final String? remark;
    final String? attachments;
    final int? isDisabled;
    final Password? password;
    final String? cPassword;
    final UserType? userType;
    final String? countryId;
    final dynamic date;
    final String? stateId;
    final String? cityId;
    final String? street1;
    final String? street2;
    final String? zipCode;
    final String? companyName;
    final String? contactPerson;
    final Status? status;
    final String? workEmail;
    final FieldName? fieldName;
    final int? otp;
    final String? otpVerify;
    final DateTime? createdAt;
    final DateTime? updatedAt;

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

    User copyWith({
        int? id,
        Name? name,
        LastName? lastName,
        String? mobileNo,
        LoginType? loginType,
        Department? department,
        Email? email,
        String? contactPersonName,
        String? userTypeId,
        String? workPhone,
        String? field,
        String? displayName,
        String? businessLeagalName,
        String? taxPreference,
        String? gstNo,
        String? panNo,
        String? website,
        String? registrationType,
        String? bio,
        Department? subField,
        String? emrMobileNo,
        String? photo,
        String? education,
        String? address,
        String? remark,
        String? attachments,
        int? isDisabled,
        Password? password,
        String? cPassword,
        UserType? userType,
        String? countryId,
        dynamic date,
        String? stateId,
        String? cityId,
        String? street1,
        String? street2,
        String? zipCode,
        String? companyName,
        String? contactPerson,
        Status? status,
        String? workEmail,
        FieldName? fieldName,
        int? otp,
        String? otpVerify,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        User(
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

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        lastName: lastNameValues.map[json["last_name"]]!,
        mobileNo: json["mobile_no"],
        loginType: loginTypeValues.map[json["login_type"]]!,
        department: departmentValues.map[json["department"]]!,
        email: emailValues.map[json["email"]]!,
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
        subField: departmentValues.map[json["sub_field"]]!,
        emrMobileNo: json["emr_mobile_no"],
        photo: json["photo"],
        education: json["education"],
        address: json["address"],
        remark: json["remark"],
        attachments: json["attachments"],
        isDisabled: json["is_disabled"],
        password: passwordValues.map[json["password"]]!,
        cPassword: json["c_password"],
        userType: userTypeValues.map[json["user_type"]]!,
        countryId: json["country_id"],
        date: json["date"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        street1: json["street_1"],
        street2: json["street_2"],
        zipCode: json["zip_code"],
        companyName: json["company_name"],
        contactPerson: json["contact_person"],
        status: statusValues.map[json["status"]]!,
        workEmail: json["work_email"],
        fieldName: fieldNameValues.map[json["field_name"]]!,
        otp: json["otp"],
        otpVerify: json["otp_verify"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "last_name": lastNameValues.reverse[lastName],
        "mobile_no": mobileNo,
        "login_type": loginTypeValues.reverse[loginType],
        "department": departmentValues.reverse[department],
        "email": emailValues.reverse[email],
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
        "sub_field": departmentValues.reverse[subField],
        "emr_mobile_no": emrMobileNo,
        "photo": photo,
        "education": education,
        "address": address,
        "remark": remark,
        "attachments": attachments,
        "is_disabled": isDisabled,
        "password": passwordValues.reverse[password],
        "c_password": cPassword,
        "user_type": userTypeValues.reverse[userType],
        "country_id": countryId,
        "date": date,
        "state_id": stateId,
        "city_id": cityId,
        "street_1": street1,
        "street_2": street2,
        "zip_code": zipCode,
        "company_name": companyName,
        "contact_person": contactPerson,
        "status": statusValues.reverse[status],
        "work_email": workEmail,
        "field_name": fieldNameValues.reverse[fieldName],
        "otp": otp,
        "otp_verify": otpVerify,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

enum Department {
    B_PHARMA,
    CARDIOLOGY,
    NURSING
}

final departmentValues = EnumValues({
    "B.Pharma": Department.B_PHARMA,
    "Cardiology": Department.CARDIOLOGY,
    "Nursing": Department.NURSING
});

enum Email {
    AK_GMAIL_COM,
    ANURAGMAURYA_GMAIL_COM,
    SATYAM_IMG_GMAIL_COM
}

final emailValues = EnumValues({
    "ak@gmail.com": Email.AK_GMAIL_COM,
    "anuragmaurya@gmail.com": Email.ANURAGMAURYA_GMAIL_COM,
    "satyam.img@gmail.com": Email.SATYAM_IMG_GMAIL_COM
});

enum LastName {
    KUSHWAHA,
    MAURYA,
    SINGH
}

final lastNameValues = EnumValues({
    "Kushwaha": LastName.KUSHWAHA,
    "Maurya": LastName.MAURYA,
    "Singh": LastName.SINGH
});

enum LoginType {
    USER
}

final loginTypeValues = EnumValues({
    "User": LoginType.USER
});

enum Name {
    ANURAG,
    ARYAN,
    ATIF
}

final nameValues = EnumValues({
    "Anurag": Name.ANURAG,
    "Aryan": Name.ARYAN,
    "Atif": Name.ATIF
});

enum Password {
    THE_2_Y_103_S8_N_QH_ONVHND5_K8_J_G_LP_C_YUNZ4_R_QZ_I_FK_E5_LG7_UV3_G_UTQR_QAI_LVE3_W2,
    THE_2_Y_10_A_S_YAB_H_NV_S6_CI6_K_TX_WDYS_B_HO_L5_XKA9_C9_ZK4_U_SO_EIXCAS5_SWX_ZRYK,
    THE_2_Y_10_OGZ_WWH_LX4_FNDG_VAO_O_UJ_VFU_AJTL_QKXR_HM50_JBH_GHQ4_Z_ZT_VF_C_GXU9_O
}

final passwordValues = EnumValues({
    "\u00242y\u002410\u00243s8nQHOnvhnd5k8jGLpCYunz4rQzIFkE5Lg7Uv3gUtqrQaiLve3W2": Password.THE_2_Y_103_S8_N_QH_ONVHND5_K8_J_G_LP_C_YUNZ4_R_QZ_I_FK_E5_LG7_UV3_G_UTQR_QAI_LVE3_W2,
    "\u00242y\u002410\u0024aSYabHNvS6Ci6KTxWdysB..HoL5XKA9c9ZK4USoEIXCAS5SwxZRYK": Password.THE_2_Y_10_A_S_YAB_H_NV_S6_CI6_K_TX_WDYS_B_HO_L5_XKA9_C9_ZK4_U_SO_EIXCAS5_SWX_ZRYK,
    "\u00242y\u002410\u0024ogzWWHLx4FNDGVaoOUjVfuAjtlQKXRHm50JbhGHQ4zZtVf.cGxu9O": Password.THE_2_Y_10_OGZ_WWH_LX4_FNDG_VAO_O_UJ_VFU_AJTL_QKXR_HM50_JBH_GHQ4_Z_ZT_VF_C_GXU9_O
});

enum UserType {
    BUSINESS,
    INDIVIDUAL
}

final userTypeValues = EnumValues({
    "Business": UserType.BUSINESS,
    "Individual": UserType.INDIVIDUAL
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
