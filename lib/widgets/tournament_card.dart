import 'package:flutter/material.dart';

import '../theme.dart';
import 'app_chrome.dart';

class TournamentCard extends StatelessWidget {
  const TournamentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(
          icon: Icons.emoji_events,
          title: '锦标赛',
          trailing: RoundArrowButtons(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                _Podium(),
                SizedBox(height: 8),
                _PrizeAndCountdown(),
                SizedBox(height: 12),
                _DetailButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 158,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _PodiumColumn(
              rank: 2,
              emoji: '🦄',
              ring: Color(0xFF7A8FA8),
              score: '19.00',
              amount: 'R\$ 20.00',
              height: 54,
            ),
          ),
          Expanded(
            child: _PodiumColumn(
              rank: 1,
              emoji: '🤴',
              ring: AppColors.gold,
              score: '20.00',
              amount: 'R\$ 21.00',
              height: 68,
              crowned: true,
            ),
          ),
          Expanded(
            child: _PodiumColumn(
              rank: 3,
              emoji: '🐘',
              ring: Color(0xFFC48A5A),
              score: '18.00',
              amount: 'R\$ 19.00',
              height: 54,
            ),
          ),
        ],
      ),
    );
  }
}

class _PodiumColumn extends StatelessWidget {
  const _PodiumColumn({
    required this.rank,
    required this.emoji,
    required this.ring,
    required this.score,
    required this.amount,
    required this.height,
    this.crowned = false,
  });

  final int rank;
  final String emoji;
  final Color ring;
  final String score;
  final String amount;
  final double height;
  final bool crowned;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: crowned ? 54 : 46,
              height: crowned ? 54 : 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2A1A28),
                border: Border.all(color: ring, width: crowned ? 3 : 2),
                boxShadow: crowned
                    ? [
                        BoxShadow(
                          color: AppColors.gold.withValues(alpha: 0.35),
                          blurRadius: 12,
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(emoji, style: TextStyle(fontSize: crowned ? 26 : 22)),
            ),
            if (crowned)
              const Positioned(
                top: -16,
                child: Text('👑', style: TextStyle(fontSize: 18)),
              ),
            Positioned(
              bottom: -4,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: rank == 1 ? AppColors.gold : const Color(0xFF3A4A5A),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.card, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$rank',
                  style: TextStyle(
                    color: rank == 1 ? const Color(0xFF4A3008) : Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          constraints: BoxConstraints(minHeight: height),
          decoration: BoxDecoration(
            color: rank == 1 ? const Color(0xFF0C1822) : const Color(0xFF152838),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.monetization_on,
                    size: 12,
                    color: AppColors.gold,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    score,
                    style: const TextStyle(
                      color: AppColors.goldSoft,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrizeAndCountdown extends StatelessWidget {
  const _PrizeAndCountdown();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '锦标赛盈利月',
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                'R\$ 200.00',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '结束倒计时',
                style: TextStyle(color: AppColors.muted, fontSize: 13),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _TimeBox(label: 'D', value: '20'),
                  SizedBox(width: 8),
                  _TimeBox(label: 'H', value: '04'),
                  SizedBox(width: 8),
                  _TimeBox(label: 'M', value: '02'),
                ],
              ),
            ],
          ),
        ),
        _Mascot(),
      ],
    );
  }
}

class _TimeBox extends StatelessWidget {
  const _TimeBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.mutedDark,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF0A1620),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _Mascot extends StatelessWidget {
  const _Mascot();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFFFFE08A), Color(0xFFC47A18)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.28),
                  blurRadius: 18,
                ),
              ],
            ),
          ),
          const Text('🦁', style: TextStyle(fontSize: 44)),
          const Positioned(
            top: 0,
            left: 0,
            child: Text('🤡', style: TextStyle(fontSize: 24)),
          ),
          const Positioned(
            top: 4,
            right: 0,
            child: Text('🐰', style: TextStyle(fontSize: 24)),
          ),
        ],
      ),
    );
  }
}

class _DetailButton extends StatelessWidget {
  const _DetailButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '详细',
        style: TextStyle(
          color: Color(0xFF07301A),
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
