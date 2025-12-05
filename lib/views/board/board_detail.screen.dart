import 'package:app_clone/models/board_model.dart';
import 'package:flutter/material.dart';

class BoardDetailScreen extends StatelessWidget {
  final BoardModel board;

  const BoardDetailScreen({super.key, required this.board});

  // Base URL cho các đường dẫn tương đối
  String _resolveUrl(String url) {
    if (url.isEmpty) return "";
    if (url.startsWith("http")) return url;
    return "https://api.sdfsdf.co.kr$url";
  }

  // Lấy src của ảnh đầu tiên trong content (nếu có)
  String? _extractFirstImage(String html) {
    final regex = RegExp(r'src="([^"]+)"');
    final match = regex.firstMatch(html);
    if (match != null && match.groupCount >= 1) {
      return _resolveUrl(match.group(1)!);
    }
    return null;
  }

  // Bỏ tag html để hiện text đơn giản
  String _stripHtml(String html) {
    // bỏ tag
    String text = html.replaceAll(RegExp(r'<[^>]*>'), ' ');
    // bỏ &nbsp; và khoảng trắng thừa
    text = text.replaceAll('&nbsp;', ' ');
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return text;
  }

  @override
  Widget build(BuildContext context) {
    // Ảnh trên cùng ưu tiên: imageUrl, nếu rỗng thì lấy ảnh trong content
    String? topImage = board.imageUrl.isNotEmpty
        ? _resolveUrl(board.imageUrl)
        : _extractFirstImage(board.content);

    final contentText = _stripHtml(board.content);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(board.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.3,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (topImage != null && topImage.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    topImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: Colors.grey.shade200,
                      child: const Center(child: Text("Không tải được ảnh")),
                    ),
                    loadingBuilder: (context, child, loading) {
                      if (loading == null) return child;
                      return Container(
                        height: 180,
                        color: Colors.grey.shade100,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 20),

              // Nội dung text (đã strip html)
              if (contentText.isNotEmpty)
                Text(
                  contentText,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
