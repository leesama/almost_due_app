import 'package:flutter/material.dart';

import '../../app/theme.dart';

class CuteBackground extends StatelessWidget {
  const CuteBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Container(color: AppColors.background),
          Positioned(
            top: -60,
            right: -40,
            child: _Bubble(color: AppColors.primary.withValues(alpha: 0.18), size: 180),
          ),
          Positioned(
            top: 120,
            left: -50,
            child: _Bubble(color: AppColors.mint.withValues(alpha: 0.18), size: 140),
          ),
          Positioned(
            bottom: -70,
            right: -30,
            child: _Bubble(color: AppColors.secondary.withValues(alpha: 0.2), size: 200),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
