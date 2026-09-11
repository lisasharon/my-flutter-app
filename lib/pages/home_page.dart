import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/app_chrome.dart';
import '../widgets/hot_games_section.dart';
import '../widgets/promo_banner.dart';
import '../widgets/tournament_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 1;
  int _category = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SafeArea(bottom: false, child: HeaderBar()),
          Expanded(
            child: IndexedStack(
              index: _navIndex,
              children: [
                const _SimpleTab(
                  icon: Icons.view_list_rounded,
                  title: '浏览',
                ),
                _LobbyTab(
                  category: _category,
                  onCategory: (value) => setState(() => _category = value),
                ),
                const _SimpleTab(icon: Icons.sports_soccer, title: '体育'),
                const _SimpleTab(icon: Icons.hub_outlined, title: '联盟计划'),
                const _SimpleTab(icon: Icons.person_outline, title: '我的'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        index: _navIndex,
        onChanged: (value) => setState(() => _navIndex = value),
      ),
    );
  }
}

class _LobbyTab extends StatelessWidget {
  const _LobbyTab({required this.category, required this.onCategory});

  final int category;
  final ValueChanged<int> onCategory;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: [
            const PromoBanner(),
            const GameSearchBar(),
            CategoryTabs(selected: category, onSelected: onCategory),
            const TournamentCard(),
            const HotGamesSection(),
          ],
        ),
        const Positioned(left: 16, bottom: 18, child: ChatFab()),
      ],
    );
  }
}

class _SimpleTab extends StatelessWidget {
  const _SimpleTab({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 42, color: AppColors.muted),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
