class QuickMenuModel {
  final int id;
  final String title;
  final String imageUrl;
  final String linkUrl;
  final int sortOrder;
  final int isActive;

  QuickMenuModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.linkUrl,
    required this.sortOrder,
    required this.isActive,
  });

  factory QuickMenuModel.fromJson(Map<String, dynamic> json) {
    return QuickMenuModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      imageUrl: "http://42.115.7.129:8080/${json["image_path"] ?? ""}",
      linkUrl: json["link_url"] ?? "",
      sortOrder: json["sort_order"] ?? 0,
      isActive: json["is_active"] ?? 0,
    );
  }
}
