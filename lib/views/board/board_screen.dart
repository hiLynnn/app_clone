import 'package:app_clone/views/board/board_detail.screen.dart';
import 'package:flutter/material.dart';
import 'package:app_clone/models/board_model.dart';
import 'package:app_clone/services/board_service.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  bool loadingNotice = true;
  bool loadingEvent = true;

  List<BoardModel> notices = [];
  List<BoardModel> events = [];

  @override
  void initState() {
    super.initState();
    _loadNotice();
    _loadEvent();
  }

  Future<void> _loadNotice() async {
    try {
      notices = await BoardService.fetchBoards(category: "notice");
    } catch (e) {
      print("NOTICE ERROR: $e");
    }
    setState(() => loadingNotice = false);
  }

  Future<void> _loadEvent() async {
    try {
      events = await BoardService.fetchBoards(category: "event");
    } catch (e) {
      print("EVENT ERROR: $e");
    }
    setState(() => loadingEvent = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("게시판"),
        centerTitle: true,
        elevation: 0.3,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _sectionHeader(icon: Icons.campaign, title: "공지사항"),
            const SizedBox(height: 10),

            loadingNotice
                ? _loadingList()
                : notices.isEmpty
                ? _emptyText()
                : Column(
                    children: notices.map((e) => _item(context, e)).toList(),
                  ),

            const SizedBox(height: 30),

            _sectionHeader(icon: Icons.card_giftcard, title: "이벤트"),
            const SizedBox(height: 10),

            loadingEvent
                ? _loadingList()
                : events.isEmpty
                ? _emptyText()
                : Column(
                    children: events.map((e) => _item(context, e)).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  // HEADER
  Widget _sectionHeader({required IconData icon, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  // ITEM (CLICK TO DETAIL)
  Widget _item(BuildContext context, BoardModel board) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BoardDetailScreen(board: board)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: .3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 8, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                board.title,
                style: const TextStyle(fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // EMPTY
  Widget _emptyText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text("등록된 항목이 없습니다.", style: TextStyle(color: Colors.grey)),
    );
  }

  // LOADING
  Widget _loadingList() {
    return Column(
      children: List.generate(
        3,
        (_) => Container(
          height: 18,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
