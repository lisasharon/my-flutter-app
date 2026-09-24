import 'package:flutter/material.dart';

import '../../theme.dart';

class AffiliatePage extends StatelessWidget {
  const AffiliatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.hub_outlined, size: 42, color: AppColors.muted),
          SizedBox(height: 10),
          Text(
            '联盟计划',
            style: TextStyle(
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
