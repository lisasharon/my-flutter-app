import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/header_bar.dart';
import 'affiliate/affiliate_page.dart';
import 'browse/browse_page.dart';
import 'lobby/lobby_page.dart';
import 'profile/profile_page.dart';
import 'sports/sports_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 1;

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
              children: const [
                BrowsePage(),
                LobbyPage(),
                SportsPage(),
                AffiliatePage(),
                ProfilePage(),
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
