class BannerModel {
  final int id;
  final String category;
  final String title;
  final String imagePath;
  final String linkUrl;

  BannerModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.linkUrl,
    required this.category,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json["id"] ?? 0,
      category: json["category"] ?? "",
      title: json["title"] ?? "",
      imagePath: json["image_path"] != null
          ? "http://42.115.7.129:8080/${json["image_path"]}"
          : "",
      linkUrl: json["link_url"] ?? "",
    );
  }
}
