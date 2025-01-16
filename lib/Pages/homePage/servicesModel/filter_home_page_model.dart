// To parse this JSON data, do
//
//     final filterHomePageModel = filterHomePageModelFromJson(jsonString);

import 'dart:convert';

FilterHomePageModel filterHomePageModelFromJson(String str) => FilterHomePageModel.fromJson(json.decode(str));

String filterHomePageModelToJson(FilterHomePageModel data) => json.encode(data.toJson());

class FilterHomePageModel {
    final bool? success;
    final String? message;
    final List<PostsByField>? postsByField;
    final List<PostsByType>? postsByType;
    final PostsByDate? postsByDate;
    final List<PostsByCreator>? postsByCreator;

    FilterHomePageModel({
        this.success,
        this.message,
        this.postsByField,
        this.postsByType,
        this.postsByDate,
        this.postsByCreator,
    });

    FilterHomePageModel copyWith({
        bool? success,
        String? message,
        List<PostsByField>? postsByField,
        List<PostsByType>? postsByType,
        PostsByDate? postsByDate,
        List<PostsByCreator>? postsByCreator,
    }) => 
        FilterHomePageModel(
            success: success ?? this.success,
            message: message ?? this.message,
            postsByField: postsByField ?? this.postsByField,
            postsByType: postsByType ?? this.postsByType,
            postsByDate: postsByDate ?? this.postsByDate,
            postsByCreator: postsByCreator ?? this.postsByCreator,
        );

    factory FilterHomePageModel.fromJson(Map<String, dynamic> json) => FilterHomePageModel(
        success: json["success"],
        message: json["message"],
        postsByField: json["posts_by_field"] == null ? [] : List<PostsByField>.from(json["posts_by_field"]!.map((x) => PostsByField.fromJson(x))),
        postsByType: json["posts_by_type"] == null ? [] : List<PostsByType>.from(json["posts_by_type"]!.map((x) => PostsByType.fromJson(x))),
        postsByDate: json["posts_by_date"] == null ? null : PostsByDate.fromJson(json["posts_by_date"]),
        postsByCreator: json["posts_by_creator"] == null ? [] : List<PostsByCreator>.from(json["posts_by_creator"]!.map((x) => PostsByCreator.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "posts_by_field": postsByField == null ? [] : List<dynamic>.from(postsByField!.map((x) => x.toJson())),
        "posts_by_type": postsByType == null ? [] : List<dynamic>.from(postsByType!.map((x) => x.toJson())),
        "posts_by_date": postsByDate?.toJson(),
        "posts_by_creator": postsByCreator == null ? [] : List<dynamic>.from(postsByCreator!.map((x) => x.toJson())),
    };
}

class PostsByCreator {
    final String? userType;
    final int? totalPosts;

    PostsByCreator({
        this.userType,
        this.totalPosts,
    });

    PostsByCreator copyWith({
        String? userType,
        int? totalPosts,
    }) => 
        PostsByCreator(
            userType: userType ?? this.userType,
            totalPosts: totalPosts ?? this.totalPosts,
        );

    factory PostsByCreator.fromJson(Map<String, dynamic> json) => PostsByCreator(
        userType: json["user_type"],
        totalPosts: json["total_posts"],
    );

    Map<String, dynamic> toJson() => {
        "user_type": userType,
        "total_posts": totalPosts,
    };
}

class PostsByDate {
    final int? today;
    final int? tomorrow;
    final int? thisWeek;
    final int? lastWeek;
    final int? thisMonth;
    final List<dynamic>? customRange;

    PostsByDate({
        this.today,
        this.tomorrow,
        this.thisWeek,
        this.lastWeek,
        this.thisMonth,
        this.customRange,
    });

    PostsByDate copyWith({
        int? today,
        int? tomorrow,
        int? thisWeek,
        int? lastWeek,
        int? thisMonth,
        List<dynamic>? customRange,
    }) => 
        PostsByDate(
            today: today ?? this.today,
            tomorrow: tomorrow ?? this.tomorrow,
            thisWeek: thisWeek ?? this.thisWeek,
            lastWeek: lastWeek ?? this.lastWeek,
            thisMonth: thisMonth ?? this.thisMonth,
            customRange: customRange ?? this.customRange,
        );

    factory PostsByDate.fromJson(Map<String, dynamic> json) => PostsByDate(
        today: json["today"],
        tomorrow: json["tomorrow"],
        thisWeek: json["this_week"],
        lastWeek: json["last_week"],
        thisMonth: json["this_month"],
        customRange: json["custom_range"] == null ? [] : List<dynamic>.from(json["custom_range"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "today": today,
        "tomorrow": tomorrow,
        "this_week": thisWeek,
        "last_week": lastWeek,
        "this_month": thisMonth,
        "custom_range": customRange == null ? [] : List<dynamic>.from(customRange!.map((x) => x)),
    };
}

class PostsByField {
    final String? fieldName;
    final int? postId;
    final int? total;

    PostsByField({
        this.fieldName,
        this.postId,
        this.total,
    });

    PostsByField copyWith({
        String? fieldName,
        int? postId,
        int? total,
    }) => 
        PostsByField(
            fieldName: fieldName ?? this.fieldName,
            postId: postId ?? this.postId,
            total: total ?? this.total,
        );

    factory PostsByField.fromJson(Map<String, dynamic> json) => PostsByField(
        fieldName: json["field_name"],
        postId: json["post_id"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "field_name": fieldName,
        "post_id": postId,
        "total": total,
    };
}

class PostsByType {
    final String? postType;
    final int? postId;
    final int? total;

    PostsByType({
        this.postType,
        this.postId,
        this.total,
    });

    PostsByType copyWith({
        String? postType,
        int? postId,
        int? total,
    }) => 
        PostsByType(
            postType: postType ?? this.postType,
            postId: postId ?? this.postId,
            total: total ?? this.total,
        );

    factory PostsByType.fromJson(Map<String, dynamic> json) => PostsByType(
        postType: json["post_type"],
        postId: json["post_id"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "post_type": postType,
        "post_id": postId,
        "total": total,
    };
}
