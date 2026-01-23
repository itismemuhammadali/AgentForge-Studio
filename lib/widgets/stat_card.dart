import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class StatCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  final String changeType;
  final String? subtitle;
  final String? icon;

  const StatCardWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.change,
    required this.changeType,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color getChangeColor() {
      switch (changeType) {
        case 'positive':
          return const Color(0xFF10B981);
        case 'negative':
          return const Color(0xFFEF4444);
        default:
          return Colors.grey[600]!;
      }
    }

    String getLabel() {
      switch (label) {
        case 'conversatiesCount':
          return 'CONVERSATIONS';
        case 'activieBotsCount':
          return 'ACTIVE BOTS';
        case 'leadsCount':
          return 'LEADS';
        case 'avgResponse':
          return 'AVG. RESPONSE';
        default:
          return label;
      }
    }

    String getSubtitle() {
      if (subtitle == null) return '';
      switch (subtitle) {
        case 'vsVorigeMaand':
          return 'vs previous month';
        case 'stabiel':
          return 'Stable';
        case 'target':
          return 'Target: <2s';
        default:
          return subtitle!;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getLabel(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                  letterSpacing: 0.5,
                ),
              ),
              if (icon != null)
                Text(
                  icon!,
                  style: const TextStyle(fontSize: 18),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                changeType == 'positive'
                    ? Icons.trending_up
                    : changeType == 'negative'
                        ? Icons.trending_down
                        : Icons.check_circle,
                size: 14,
                color: getChangeColor(),
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: getChangeColor(),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                getSubtitle(),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
