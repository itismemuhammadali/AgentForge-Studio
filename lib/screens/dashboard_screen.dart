import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/conversation_chart.dart';
import '../widgets/top_bots_section.dart';
import '../widgets/recent_activity_table.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<DashboardProvider>(
      builder: (context, dashboardProvider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Text(
                'Dashboard',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Here is what is happening with your bots today.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              // Stats Cards
              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2.2,
                children: dashboardProvider.statCards
                    .map(
                      (card) => StatCardWidget(
                        label: card.label,
                        value: card.value,
                        change: card.change,
                        changeType: card.changeType,
                        subtitle: card.subtitle,
                        icon: card.icon,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              // Charts Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ConversationChart(
                      data: dashboardProvider.chartData,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: TopBotsSection(
                      bots: dashboardProvider.topBots,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Recent Activity Table
              RecentActivityTable(
                activities: dashboardProvider.recentActivities,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
