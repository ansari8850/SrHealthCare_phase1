

class SearchHistoryModel {
    final String? status;
    final String? message;
    final List<SearchModel>? data;

    SearchHistoryModel({
        this.status,
        this.message,
        this.data,
    });

    SearchHistoryModel copyWith({
        String? status,
        String? message,
        List<SearchModel>? data,
    }) => 
        SearchHistoryModel(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory SearchHistoryModel.fromJson(Map<String, dynamic> json) => SearchHistoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<SearchModel>.from(json["data"]!.map((x) => SearchModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SearchModel {
    final int? id;
    final int? userId;
    final String? searchQuery;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    SearchModel({
        this.id,
        this.userId,
        this.searchQuery,
        this.createdAt,
        this.updatedAt,
    });

    SearchModel copyWith({
        int? id,
        int? userId,
        String? searchQuery,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        SearchModel(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            searchQuery: searchQuery ?? this.searchQuery,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json["id"],
        userId: json["user_id"],
        searchQuery: json["search_query"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "search_query": searchQuery,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
