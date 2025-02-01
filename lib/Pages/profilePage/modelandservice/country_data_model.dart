

class CountryDataModel {
    final bool? success;
    final List<Country>? country;

    CountryDataModel({
        this.success,
        this.country,
    });

    CountryDataModel copyWith({
        bool? success,
        List<Country>? country,
    }) => 
        CountryDataModel(
            success: success ?? this.success,
            country: country ?? this.country,
        );

    factory CountryDataModel.fromJson(Map<String, dynamic> json) => CountryDataModel(
        success: json["success"],
        country: json["country"] == null ? [] : List<Country>.from(json["country"]!.map((x) => Country.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x.toJson())),
    };
}

class Country {
    final int? id;
    final String? name;
    final String? iso3;
    final String? numericCode;
    final String? iso2;
    final String? phonecode;
    final String? capital;
    final String? currency;
    final String? currencyName;
    final String? currencySymbol;
    final String? tld;
    final String? native;
    final Region? region;
    final String? subregion;
    final String? nationality;
    final String? timezones;
    final String? translations;
    final String? latitude;
    final String? longitude;
    final String? emoji;
    final String? emojiU;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? flag;
    final String? wikiDataId;

    Country({
        this.id,
        this.name,
        this.iso3,
        this.numericCode,
        this.iso2,
        this.phonecode,
        this.capital,
        this.currency,
        this.currencyName,
        this.currencySymbol,
        this.tld,
        this.native,
        this.region,
        this.subregion,
        this.nationality,
        this.timezones,
        this.translations,
        this.latitude,
        this.longitude,
        this.emoji,
        this.emojiU,
        this.createdAt,
        this.updatedAt,
        this.flag,
        this.wikiDataId,
    });

    Country copyWith({
        int? id,
        String? name,
        String? iso3,
        String? numericCode,
        String? iso2,
        String? phonecode,
        String? capital,
        String? currency,
        String? currencyName,
        String? currencySymbol,
        String? tld,
        String? native,
        Region? region,
        String? subregion,
        String? nationality,
        String? timezones,
        String? translations,
        String? latitude,
        String? longitude,
        String? emoji,
        String? emojiU,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? flag,
        String? wikiDataId,
    }) => 
        Country(
            id: id ?? this.id,
            name: name ?? this.name,
            iso3: iso3 ?? this.iso3,
            numericCode: numericCode ?? this.numericCode,
            iso2: iso2 ?? this.iso2,
            phonecode: phonecode ?? this.phonecode,
            capital: capital ?? this.capital,
            currency: currency ?? this.currency,
            currencyName: currencyName ?? this.currencyName,
            currencySymbol: currencySymbol ?? this.currencySymbol,
            tld: tld ?? this.tld,
            native: native ?? this.native,
            region: region ?? this.region,
            subregion: subregion ?? this.subregion,
            nationality: nationality ?? this.nationality,
            timezones: timezones ?? this.timezones,
            translations: translations ?? this.translations,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            emoji: emoji ?? this.emoji,
            emojiU: emojiU ?? this.emojiU,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            flag: flag ?? this.flag,
            wikiDataId: wikiDataId ?? this.wikiDataId,
        );

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        iso3: json["iso3"],
        numericCode: json["numeric_code"],
        iso2: json["iso2"],
        phonecode: json["phonecode"],
        capital: json["capital"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        currencySymbol: json["currency_symbol"],
        tld: json["tld"],
        native: json["native"],
        region: regionValues.map[json["region"]]!,
        subregion: json["subregion"],
        nationality: json["nationality"],
        timezones: json["timezones"],
        translations: json["translations"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        flag: json["flag"],
        wikiDataId: json["wikiDataId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso3": iso3,
        "numeric_code": numericCode,
        "iso2": iso2,
        "phonecode": phonecode,
        "capital": capital,
        "currency": currency,
        "currency_name": currencyName,
        "currency_symbol": currencySymbol,
        "tld": tld,
        "native": native,
        "region": regionValues.reverse[region],
        "subregion": subregion,
        "nationality": nationality,
        "timezones": timezones,
        "translations": translations,
        "latitude": latitude,
        "longitude": longitude,
        "emoji": emoji,
        "emojiU": emojiU,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "flag": flag,
        "wikiDataId": wikiDataId,
    };
}

enum Region {
    AFRICA,
    AMERICAS,
    ASIA,
    EMPTY,
    EUROPE,
    OCEANIA,
    POLAR
}

final regionValues = EnumValues({
    "Africa": Region.AFRICA,
    "Americas": Region.AMERICAS,
    "Asia": Region.ASIA,
    "": Region.EMPTY,
    "Europe": Region.EUROPE,
    "Oceania": Region.OCEANIA,
    "Polar": Region.POLAR
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


