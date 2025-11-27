class Property {
  final int id;
  final String name;
  final String price;
  final int? locationId;
  final String location;
  final String status;
  final String description;
  final String image;
  final double lat;
  final double lng;

  Property({
    required this.id,
    required this.name,
    required this.price,
    required this.locationId,
    required this.location,
    required this.status,
    required this.description,
    required this.image,
    required this.lat,
    required this.lng,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      locationId: json['location_id'], // nullable
      location: json['location'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      lat: _toDouble(json['lat']),
      lng: _toDouble(json['lng']),
    );
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0;
    return 0;
  }
}
