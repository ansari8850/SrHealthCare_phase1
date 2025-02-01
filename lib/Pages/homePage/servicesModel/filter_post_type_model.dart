

class FilterPostTypeModel {
    final List<PostTypeList>? postTypeList;
    final String? message;

    FilterPostTypeModel({
        this.postTypeList,
        this.message,
    });

    FilterPostTypeModel copyWith({
        List<PostTypeList>? postTypeList,
        String? message,
    }) => 
        FilterPostTypeModel(
            postTypeList: postTypeList ?? this.postTypeList,
            message: message ?? this.message,
        );

    factory FilterPostTypeModel.fromJson(Map<String, dynamic> json) => FilterPostTypeModel(
        postTypeList: json["post_type_list"] == null ? [] : List<PostTypeList>.from(json["post_type_list"]!.map((x) => PostTypeList.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "post_type_list": postTypeList == null ? [] : List<dynamic>.from(postTypeList!.map((x) => x.toJson())),
        "message": message,
    };
}

class PostTypeList {
    final String? name;

    PostTypeList({
        this.name,
    });

    PostTypeList copyWith({
        String? name,
    }) => 
        PostTypeList(
            name: name ?? this.name,
        );

    factory PostTypeList.fromJson(Map<String, dynamic> json) => PostTypeList(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
