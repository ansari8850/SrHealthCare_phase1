

import 'dart:convert';

import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';

class SingleUserPostDetail {
    final bool? success;
    final String? message;
     List<FeedPostModel>? result;
    final int? totalPostCount;
    final int? totalfollowersCount;
    final int? totalfollowingCount;

    SingleUserPostDetail({
        this.success,
        this.message,
        this.result,
        this.totalPostCount,
        this.totalfollowersCount,
        this.totalfollowingCount,
    });

    SingleUserPostDetail copyWith({
        bool? success,
        String? message,
        List<FeedPostModel>? result,
        int? totalPostCount,
        int? totalfollowersCount,
        int? totalfollowingCount,
    }) => 
        SingleUserPostDetail(
            success: success ?? this.success,
            message: message ?? this.message,
            result: result ?? this.result,
            totalPostCount: totalPostCount ?? this.totalPostCount,
            totalfollowersCount: totalfollowersCount ?? this.totalfollowersCount,
            totalfollowingCount: totalfollowingCount ?? this.totalfollowingCount,
        );

    factory SingleUserPostDetail.fromJson(Map<String, dynamic> json) => SingleUserPostDetail(
        success: json["success"],
        message: json["message"],
        result: json["result"] == null ? [] : List<FeedPostModel>.from(json["result"]!.map((x) => FeedPostModel.fromJson(x))),
        totalPostCount: json["totalPostCount"],
        totalfollowersCount: json["totalfollowersCount"],
        totalfollowingCount: json["totalfollowingCount"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
        "totalPostCount": totalPostCount,
        "totalfollowersCount": totalfollowersCount,
        "totalfollowingCount": totalfollowingCount,
    };
}

class FeedPostModel {
    final int? id;
    final String? userId;
    final String? userName;
    final String? fieldId;
    final PostType? postType;
    final String? fieldName;
    final String? title;
    final String? location;
    final DateTime? date;
    final String? description;
    final dynamic rejectedReason;
    final String? thumbnail;
    final DateTime? autoDeleteDate;
    final String? status;
    final int? isDisabled;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? postTypeId;
    final User? user;

    FeedPostModel({
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
        this.rejectedReason,
        this.thumbnail,
        this.autoDeleteDate,
        this.status,
        this.isDisabled,
        this.createdAt,
        this.updatedAt,
        this.postTypeId,
        this.user,
    });

    FeedPostModel copyWith({
        int? id,
        String? userId,
        String? userName,
        String? fieldId,
        PostType? postType,
        String? fieldName,
        String? title,
        String? location,
        DateTime? date,
        String? description,
        dynamic rejectedReason,
        String? thumbnail,
        DateTime? autoDeleteDate,
        String? status,
        int? isDisabled,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? postTypeId,
        User? user,
    }) => 
        FeedPostModel(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            userName: userName ?? this.userName,
            fieldId: fieldId ?? this.fieldId,
            postType: postType ?? this.postType,
            fieldName: fieldName ?? this.fieldName,
            title: title ?? this.title,
            location: location ?? this.location,
            date: date ?? this.date,
            description: description ?? this.description,
            rejectedReason: rejectedReason ?? this.rejectedReason,
            thumbnail: thumbnail ?? this.thumbnail,
            autoDeleteDate: autoDeleteDate ?? this.autoDeleteDate,
            status: status ?? this.status,
            isDisabled: isDisabled ?? this.isDisabled,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            postTypeId: postTypeId ?? this.postTypeId,
            user: user ?? this.user,
        );

    factory FeedPostModel.fromJson(Map<String, dynamic> json) => FeedPostModel(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        fieldId: json["field_id"],
        postType: json["post_type"] == null ? null : PostType.fromJson(json["post_type"]),
        fieldName: json["field_name"],
        title: json["title"],
        location: json["location"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"],
        rejectedReason: json["rejected_reason"],
        thumbnail: json["thumbnail"],
        autoDeleteDate: json["auto_delete_date"] == null ? null : DateTime.parse(json["auto_delete_date"]),
        status: json["status"],
        isDisabled: json["is_disabled"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        "rejected_reason": rejectedReason,
        "thumbnail": thumbnail,
        "auto_delete_date": autoDeleteDate?.toIso8601String(),
        "status": status,
        "is_disabled": isDisabled,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "post_type_id": postTypeId,
        "user": user?.toJson(),
    };
}

class PostType {
    final int? id;
    final String? type;
    final String? name;
    final dynamic parentId;
    final dynamic extraData;
    final String? fieldId;
    final String? location;
    final dynamic subType;
    final String? fieldName;
    final int? isDisabled;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? status;

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
        String? fieldName,
        int? isDisabled,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? status,
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
        fieldName: json["field_name"],
        isDisabled: json["is_disabled"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: json["status"],
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
        "status": status,
    };
}

class User {
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
    final bool? isFollowing;

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
        this.isFollowing,
    });

    User copyWith({
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
        bool? isFollowing,
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
            isFollowing: isFollowing ?? this.isFollowing,
        );

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
        isFollowing: json["is_following"],
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
        "is_following": isFollowing,
    };
}
