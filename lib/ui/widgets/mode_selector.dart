import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../screens/add_item_types.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key, required this.mode, required this.onChanged});

  final AddMode mode;
  final ValueChanged<AddMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ModeChip(
          label: '手动录入',
          selected: mode == AddMode.manual,
          onTap: () => onChanged(AddMode.manual),
        ),
        const SizedBox(width: 8),
        _ModeChip(
          label: 'AI识别',
          selected: mode == AddMode.ai,
          onTap: () => onChanged(AddMode.ai),
        ),
      ],
    );
  }
}

class _ModeChip extends StatelessWidget {
  const _ModeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.35) : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColors.primary.withOpacity(0.7)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
