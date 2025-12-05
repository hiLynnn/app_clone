import 'dart:convert';

class PropertyModel {
  final int id;
  final String name;
  final String price;
  final String status;
  final String location;

  final int? locationId;
  final int? agentId;

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

  // AGENCY
  final String agentName;
  final String agentUserId;
  final String agencyName;
  final String agencyPhone;
  final String agencyAddress;
  final String agencyImage;
  final String agencyDescription;
  final double agencyLat;
  final double agencyLng;

  PropertyModel({
    required this.id,
    required this.name,
    required this.price,
    required this.status,
    required this.location,
    required this.locationId,
    required this.agentId,
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
    required this.agentName,
    required this.agentUserId,
    required this.agencyName,
    required this.agencyPhone,
    required this.agencyAddress,
    required this.agencyImage,
    required this.agencyDescription,
    required this.agencyLat,
    required this.agencyLng,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    // ---------------- OPTIONS ----------------
    List<PropertyOption> parsedOptions = [];
    try {
      final raw = json["options"]?.toString() ?? "";
      if (raw.isNotEmpty && raw != "[]") {
        final decoded = jsonDecode(raw);
        parsedOptions = List<Map<String, dynamic>>.from(
          decoded,
        ).map((e) => PropertyOption.fromJson(e)).toList();
      }
    } catch (_) {}

    // ---------------- IMAGES ----------------
    List<String> parsedImages = [];
    try {
      final raw = json["images"]?.toString() ?? "";
      if (raw.isNotEmpty && raw != "[]") {
        final decoded = jsonDecode(raw);

        if (decoded is List) {
          parsedImages = decoded.map((e) => fullUrl(e.toString())).toList();
        }
      }
    } catch (_) {}

    // ---------------- MAIN IMAGE ----------------
    String mainImg = "";
    if (json["image"] != null && json["image"].toString().isNotEmpty) {
      mainImg = fullUrl(json["image"].toString());
    }

    // ---------------- AGENT IMAGE ----------------
    String agencyImg = "";
    if (json["agency_image"] != null &&
        json["agency_image"].toString().isNotEmpty) {
      agencyImg = fullUrl(json["agency_image"]);
    }

    return PropertyModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      price: json["price"] ?? "",
      status: json["status"] ?? "",
      location: json["location"] ?? "",
      locationId: json["location_id"],
      agentId: json["agent_id"],

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
      image: mainImg,

      agentName: json["agent"] ?? "",
      agentUserId: json["agent_userid"] ?? "",
      agencyName: json["agency_name"] ?? "",
      agencyPhone: json["contact"] ?? "",
      agencyAddress: json["agency_address"] ?? "",
      agencyImage: agencyImg,
      agencyDescription: json["agency_description"] ?? "",
      agencyLat: double.tryParse(json["agency_lat"]?.toString() ?? "") ?? 0,
      agencyLng: double.tryParse(json["agency_lng"]?.toString() ?? "") ?? 0,
    );
  }

  static String fullUrl(String path) {
    if (path.isEmpty) return "";

    if (path.startsWith("http")) return path;

    // path như "130/abc.jpg" → thêm /uploads/
    if (!path.startsWith("/uploads/")) {
      return "https://api.sdfsdf.co.kr/uploads/$path";
    }

    return "https://api.sdfsdf.co.kr$path";
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
