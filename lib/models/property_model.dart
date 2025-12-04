import 'dart:convert';

class PropertyModel {
  final int id;
  final String name;
  final String price;
  final String location;
  final String status;
  final String propertyType;
  final String buildingType;

  final List<PropertyOption> options;
  final int isPublished;
  final int isMain;
  final int isHot;

  final String description;
  final double lat;
  final double lng;

  final List<String> images;
  final String image;

  PropertyModel({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.status,
    required this.propertyType,
    required this.buildingType,
    required this.options,
    required this.isPublished,
    required this.isMain,
    required this.isHot,
    required this.description,
    required this.lat,
    required this.lng,
    required this.images,
    required this.image,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    // -------------------------
    // OPTIONS
    // -------------------------
    List<PropertyOption> parsedOptions = [];
    try {
      if (json["options"] != null &&
          json["options"] is String &&
          json["options"] != "") {
        parsedOptions = (jsonDecode(json["options"]) as List)
            .map((o) => PropertyOption.fromJson(o))
            .toList();
      }
    } catch (_) {}

    // -------------------------
    // IMAGES
    // -------------------------
    List<String> parsedImages = [];
    try {
      if (json["images"] != null &&
          json["images"] is String &&
          json["images"] != "") {
        parsedImages = List<String>.from(jsonDecode(json["images"]));
      }
    } catch (_) {}

    // -------------------------
    // MAIN IMAGE
    // -------------------------
    String finalImage = "";
    if (json["image"] != null && json["image"] != "") {
      String raw = json["image"].toString();

      if (raw.startsWith("http")) {
        finalImage = raw;
      } else {
        finalImage = "http://42.115.7.129:8080$raw";
      }
    }

    return PropertyModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      price: json["price"] ?? "",
      location: json["location"] ?? "",
      status: json["status"] ?? "",
      propertyType: json["property_type"] ?? "",
      buildingType: json["building_type"] ?? "",
      options: parsedOptions,
      isPublished: json["is_published"] ?? 0,
      isMain: json["is_main"] ?? 0,
      isHot: json["is_hot"] ?? 0,
      description: json["description"] ?? "",
      lat: double.tryParse(json["lat"]?.toString() ?? "") ?? 0,
      lng: double.tryParse(json["lng"]?.toString() ?? "") ?? 0,
      images: parsedImages,
      image: finalImage,
    );
  }
}

class PropertyOption {
  final String name;
  final String value;

  PropertyOption({required this.name, required this.value});

  factory PropertyOption.fromJson(Map<String, dynamic> json) {
    return PropertyOption(name: json["name"] ?? "", value: json["value"] ?? "");
  }
}
