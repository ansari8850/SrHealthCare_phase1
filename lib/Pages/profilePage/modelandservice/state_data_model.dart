class BasedOnCountryModel {
    final bool? success;
    final List<StateModel>? country;

    BasedOnCountryModel({
        this.success,
        this.country,
    });

    BasedOnCountryModel copyWith({
        bool? success,
        List<StateModel>? country,
    }) => 
        BasedOnCountryModel(
            success: success ?? this.success,
            country: country ?? this.country,
        );

    factory BasedOnCountryModel.fromJson(Map<String, dynamic> json) => BasedOnCountryModel(
        success: json["success"],
        country: json["country"] == null ? [] : List<StateModel>.from(json["country"]!.map((x) => StateModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x.toJson())),
    };
}

class StateModel {
    final int? id;
    final String? name;

    StateModel({
        this.id,
        this.name,
    });

    StateModel copyWith({
        int? id,
        String? name,
    }) => 
        StateModel(
            id: id ?? this.id,
            name: name ?? this.name,
        );

    factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
