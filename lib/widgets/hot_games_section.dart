import 'package:flutter/material.dart';

import '../theme.dart';
import 'home_widgets.dart';

class HotGamesSection extends StatelessWidget {
  const HotGamesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(
          icon: Icons.local_fire_department,
          title: '热门游戏',
          trailing: _AllCount(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Row(
            children: [
              Expanded(child: _MahjongHuCard()),
              SizedBox(width: 10),
              Expanded(child: _MahjongPyramidCard()),
            ],
          ),
        ),
      ],
    );
  }
}

class _AllCount extends StatelessWidget {
  const _AllCount();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text('全部', style: TextStyle(color: AppColors.muted, fontSize: 13)),
        SizedBox(width: 6),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.chip,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              '30',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        RoundArrowButtons(),
      ],
    );
  }
}

class _MahjongHuCard extends StatelessWidget {
  const _MahjongHuCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            const Positioned.fill(child: CustomPaint(painter: _HuCoverPainter())),
            const Positioned(
              left: 8,
              top: 8,
              child: _PgBadge(),
            ),
            Center(
              child: Text(
                '胡',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFE31C1C),
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                    const Shadow(color: Color(0xFFFFE08A), blurRadius: 8),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 10,
              right: 10,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Tile(text: '中', color: Color(0xFFD23A32)),
                  _Tile(text: '發', color: Color(0xFF1F9A46)),
                  _Tile(text: '八', color: Color(0xFF1D4E9A)),
                  _Tile(text: '萬', color: Color(0xFF1D4E9A)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MahjongPyramidCard extends StatelessWidget {
  const _MahjongPyramidCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            const Positioned.fill(
              child: CustomPaint(painter: _PyramidCoverPainter()),
            ),
            const Positioned(left: 8, top: 8, child: _PgBadge()),
            Align(
              alignment: const Alignment(0, -0.15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _Tile(text: '中', color: Color(0xFFD23A32), large: true),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _Tile(text: '八', color: Color(0xFF1D4E9A)),
                      SizedBox(width: 4),
                      _Tile(text: '發', color: Color(0xFF1F9A46)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B1A16),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFFFD27A)),
                    ),
                    child: const Text(
                      '百搭',
                      style: TextStyle(
                        color: Color(0xFFFFE08A),
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PgBadge extends StatelessWidget {
  const _PgBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xCC0A1A12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'P',
              style: TextStyle(
                color: Color(0xFF3DDC84),
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
            TextSpan(
              text: 'G',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.text,
    required this.color,
    this.large = false,
  });

  final String text;
  final Color color;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final size = large ? 34.0 : 28.0;
    return Container(
      width: size,
      height: size * 1.25,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E6),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE0C48A)),
        boxShadow: const [
          BoxShadow(color: Color(0x66000000), blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: large ? 18 : 14,
        ),
      ),
    );
  }
}

class _HuCoverPainter extends CustomPainter {
  const _HuCoverPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(0, -0.1),
          radius: 0.9,
          colors: [
            Color(0xFFFFF1A8),
            Color(0xFFFFB347),
            Color(0xFFE85A1A),
            Color(0xFFB43A18),
          ],
        ).createShader(rect),
    );

    final table = Paint()..color = const Color(0xFF1F7A46);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.78),
        width: size.width * 0.86,
        height: size.height * 0.34,
      ),
      table,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * 0.76),
        width: size.width * 0.72,
        height: size.height * 0.22,
      ),
      Paint()..color = const Color(0xFF166338),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PyramidCoverPainter extends CustomPainter {
  const _PyramidCoverPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A3A28), Color(0xFF0B1C14), Color(0xFF14220E)],
        ).createShader(rect),
    );

    final pyramid = Path()
      ..moveTo(size.width / 2, size.height * 0.08)
      ..lineTo(size.width * 0.92, size.height * 0.92)
      ..lineTo(size.width * 0.08, size.height * 0.92)
      ..close();
    canvas.drawPath(
      pyramid,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Color(0xFFFFE08A), Color(0xFFC47A18), Color(0xFF8A4A10)],
        ).createShader(rect),
    );

    final tilePaint = Paint()..color = const Color(0xDDFFF3D0);
    final border = Paint()
      ..color = const Color(0x88C49A48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var row = 0; row < 6; row++) {
      final count = row + 1;
      for (var i = 0; i < count; i++) {
        final cx =
            size.width / 2 - (count - 1) * 9.0 + i * 18.0;
        final cy = size.height * 0.22 + row * 16.0;
        final r = Rect.fromCenter(center: Offset(cx, cy), width: 16, height: 20);
        canvas.save();
        canvas.translate(cx, cy);
        canvas.rotate(-0.08 + (i - count / 2) * 0.04);
        canvas.translate(-cx, -cy);
        canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(2)),
          tilePaint,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(r, const Radius.circular(2)),
          border,
        );
        canvas.restore();
      }
    }

    // Sparkles.
    final spark = Paint()..color = const Color(0xAAFFF7C8);
    for (final p in [
      Offset(size.width * 0.18, size.height * 0.2),
      Offset(size.width * 0.82, size.height * 0.28),
      Offset(size.width * 0.7, size.height * 0.12),
    ]) {
      canvas.drawCircle(p, 2.2, spark);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}