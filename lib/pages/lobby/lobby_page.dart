import 'package:flutter/material.dart';

import '../../widgets/home_widgets.dart';
import '../../widgets/hot_games_section.dart';
import '../../widgets/promo_banner.dart';
import '../../widgets/tournament_card.dart';
import '../search_page.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  int _category = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          clipBehavior: Clip.hardEdge,
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 80),
          children: [
            const PromoBanner(),
            GameSearchBar(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SearchPage()),
                );
              },
            ),
            CategoryTabs(
              selected: _category,
              onSelected: (value) => setState(() => _category = value),
            ),
            const TournamentCard(),
            const HotGamesSection(),
          ],
        ),
        const Positioned(left: 16, bottom: 18, child: ChatFab()),
      ],
    );
  }
}
