import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'section_card.dart';

class AiPanel extends StatelessWidget {
  const AiPanel({
    super.key,
    required this.controller,
    required this.isConfigured,
    required this.isLoading,
    required this.onAnalyze,
  });

  final TextEditingController controller;
  final bool isConfigured;
  final bool isLoading;
  final VoidCallback onAnalyze;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'AI识别录入',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isConfigured ? '已连接AI服务，可以识别包装上的日期。' : '请先在设置中配置AI API。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink.withOpacity(0.7),
                ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: '包装文字或识别结果',
              hintText: '例如：保质期至2025年04月30日',
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading || !isConfigured ? null : onAnalyze,
              icon: const Icon(Icons.auto_awesome_rounded),
              label: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? const SizedBox(
                        key: ValueKey('loading'),
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        '开始识别',
                        key: ValueKey('ready'),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
