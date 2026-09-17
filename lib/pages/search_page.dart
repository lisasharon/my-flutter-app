import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/header_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const hotKeywords = [
    '哼哼哼',
    '埃及绿宝石',
    '犀牛闪电',
    '更好的百搭',
    '风火轮',
    '金钱树',
    '大力神',
    '发发发',
    '飞天财神',
    '疯狂酒馆',
    '超炫小丑',
    '黄金闪电 终极版',
    '巨型烈焰：大马戏！',
    '熊软糖能量弹',
    '6小丑',
    '巨型烈焰：月亮神孔斯',
  ];

  final _query = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<String> get _filtered {
    final q = _query.text.trim();
    if (q.isEmpty) return hotKeywords;
    return hotKeywords.where((name) => name.contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _SearchField(
                    controller: _query,
                    focusNode: _focus,
                    onClose: () => Navigator.of(context).pop(),
                    onMic: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('语音搜索暂未开放')),
                      );
                    },
                  ),
                  const Positioned(
                    right: 8,
                    top: -18,
                    child: _GiftBadge(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: Text(
                '热门搜索',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: results.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '未找到相关游戏',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final name in results)
                            _HotChip(
                              label: name,
                              onTap: () {
                                _query.text = name;
                                _query.selection = TextSelection.collapsed(
                                  offset: name.length,
                                );
                                _focus.requestFocus();
                              },
                            ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GiftBadge extends StatelessWidget {
  const _GiftBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.orangeDeep, AppColors.orange],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.card_giftcard, color: Colors.white, size: 14),
          SizedBox(width: 4),
          Text(
            '首存赠送 ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '\$ 20.00',
            style: TextStyle(
              color: Color(0xFFFFE08A),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.focusNode,
    required this.onClose,
    required this.onMic,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onClose;
  final VoidCallback onMic;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.only(left: 14, right: 6),
      decoration: BoxDecoration(
        color: AppColors.search,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF243444)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.muted, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              cursorColor: AppColors.green,
              decoration: const InputDecoration(
                isDense: true,
                hintText: '搜索游戏',
                hintStyle: TextStyle(color: AppColors.muted, fontSize: 15),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: onMic,
            tooltip: '语音搜索',
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.mic_none, color: AppColors.muted, size: 20),
          ),
          IconButton(
            onPressed: onClose,
            tooltip: '关闭搜索',
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.close, color: AppColors.muted, size: 20),
          ),
        ],
      ),
    );
  }
}

class _HotChip extends StatelessWidget {
  const _HotChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2833),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFFD5DEE6),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
