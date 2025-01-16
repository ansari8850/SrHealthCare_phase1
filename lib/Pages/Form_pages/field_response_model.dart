

class FiledResponseModel {
    final List<FieldTypeModel>? masterList;
    final int? count;
    final String? message;

    FiledResponseModel({
        this.masterList,
        this.count,
        this.message,
    });

    FiledResponseModel copyWith({
        List<FieldTypeModel>? masterList,
        int? count,
        String? message,
    }) => 
        FiledResponseModel(
            masterList: masterList ?? this.masterList,
            count: count ?? this.count,
            message: message ?? this.message,
        );

    factory FiledResponseModel.fromJson(Map<String, dynamic> json) => FiledResponseModel(
        masterList: json["masterList"] == null ? [] : List<FieldTypeModel>.from(json["masterList"]!.map((x) => FieldTypeModel.fromJson(x))),
        count: json["count"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "masterList": masterList == null ? [] : List<dynamic>.from(masterList!.map((x) => x.toJson())),
        "count": count,
        "message": message,
    };
}

class FieldTypeModel {
    final int? id;
    final String? type;
    final String? name;
    final dynamic parentId;
    final dynamic extraData;
    final dynamic fieldId;
    final dynamic location;
    final dynamic subType;
    final dynamic fieldName;
    final int? isDisabled;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? status;

    FieldTypeModel({
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

    FieldTypeModel copyWith({
        int? id,
        String? type,
        String? name,
        dynamic parentId,
        dynamic extraData,
        dynamic fieldId,
        dynamic location,
        dynamic subType,
        dynamic fieldName,
        int? isDisabled,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? status,
    }) => 
        FieldTypeModel(
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

    factory FieldTypeModel.fromJson(Map<String, dynamic> json) => FieldTypeModel(
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
