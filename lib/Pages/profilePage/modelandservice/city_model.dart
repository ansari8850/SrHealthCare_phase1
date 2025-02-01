class CityModel {
  final int? id;
  final String? name;

  CityModel({
    this.id,
    this.name,
  });

  CityModel copyWith({
    int? id,
    String? name,
  }) =>
      CityModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class CityResponseModel {
  final bool? success;
  final List<CityModel>? cities;

  CityResponseModel({
    this.success,
    this.cities,
  });

  CityResponseModel copyWith({
    bool? success,
    List<CityModel>? cities,
  }) =>
      CityResponseModel(
        success: success ?? this.success,
        cities: cities ?? this.cities,
      );

  factory CityResponseModel.fromJson(Map<String, dynamic> json) =>
      CityResponseModel(
        success: json["success"],
        cities: json["city"] == null
            ? []
            : List<CityModel>.from(
                json["city"]!.map((x) => CityModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "city": cities == null
            ? []
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}
