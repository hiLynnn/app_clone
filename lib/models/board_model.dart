class BoardModel {
  final int id;
  final String category;
  final String title;
  final String content;
  final String imageUrl;

  BoardModel({
    required this.id,
    required this.category,
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory BoardModel.fromJson(Map<String, dynamic> json) {
    String img = json["image_url"] ?? "";

    if (img.isNotEmpty && !img.startsWith("http")) {
      img = "https://api.sdfsdf.co.kr$img";
    }

    return BoardModel(
      id: json["id"] ?? 0,
      category: json["category"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      imageUrl: img,
    );
  }
}
