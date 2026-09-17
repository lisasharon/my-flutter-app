import 'package:flutter/material.dart';

import '../theme.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.index,
    required this.onChanged,
  });

  final int index;
  final ValueChanged<int> onChanged;

  static const items = [
    (Icons.view_list_rounded, '浏览'),
    (Icons.style, '娱乐城'),
    (Icons.sports_soccer, '体育'),
    (Icons.hub_outlined, '联盟计划'),
    (Icons.person_outline, '我的'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Color(0xFF1A2A36))),
      ),
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 6),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(i),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[i].$1,
                        size: 24,
                        color: i == index ? AppColors.green : AppColors.muted,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[i].$2,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: i == index
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: i == index ? AppColors.green : AppColors.muted,
                        ),
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
