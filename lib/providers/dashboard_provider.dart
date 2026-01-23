import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';

class DashboardProvider extends ChangeNotifier {
  late List<StatCard> statCards;
  late List<TopBot> topBots;
  late List<BotActivity> recentActivities;
  late List<ChartData> chartData;

  DashboardProvider() {
    _initializeDashboardData();
  }

  void _initializeDashboardData() {
    // Initialize stat cards
    statCards = [
      StatCard(
        label: 'conversatiesCount',
        value: '2,847',
        change: '12%',
        changeType: 'positive',
        subtitle: 'vsVorigeMaand',
        icon: '💬',
      ),
      StatCard(
        label: 'activieBotsCount',
        value: '12',
        change: '0%',
        changeType: 'neutral',
        subtitle: 'stabiel',
        icon: '🤖',
      ),
      StatCard(
        label: 'leadsCount',
        value: '156',
        change: '5%',
        changeType: 'positive',
        subtitle: 'vsVorigeMaand',
        icon: '⚡',
      ),
      StatCard(
        label: 'avgResponse',
        value: '1.2s',
        change: 'OK',
        changeType: 'positive',
        subtitle: 'target',
        icon: '⏱️',
      ),
    ];

    // Initialize top bots
    topBots = [
      TopBot(
        id: '1',
        name: 'Klantenservice NL',
        messageCount: 1204,
        changePercent: '+12%',
        icon: '🎧',
      ),
      TopBot(
        id: '2',
        name: 'Sales Assistant',
        messageCount: 854,
        changePercent: '+5%',
        icon: '🛒',
      ),
      TopBot(
        id: '3',
        name: 'Voice Intake',
        messageCount: 320,
        changePercent: '0%',
        icon: '🎤',
      ),
    ];

    // Initialize recent activities
    recentActivities = [
      BotActivity(
        id: '1',
        time: '2 min ago',
        user: 'jan@example.com',
        botName: 'Klantenservice NL',
        type: 'chat',
        status: 'afgerond',
        messageCount: 12,
      ),
      BotActivity(
        id: '2',
        time: '14 min ago',
        user: '+31 6 12345678',
        botName: 'Voice Intake',
        type: 'voice',
        status: 'inGesprek',
        messageCount: 5,
      ),
      BotActivity(
        id: '3',
        time: '1 hour ago',
        user: 'bezoeker_x92',
        botName: 'Sales Assistant',
        type: 'chat',
        status: 'handoff',
        messageCount: 8,
      ),
    ];

    // Initialize chart data
    chartData = [
      ChartData(day: 'MO', value: 30),
      ChartData(day: 'TU', value: 45),
      ChartData(day: 'WE', value: 35),
      ChartData(day: 'TH', value: 50),
      ChartData(day: 'FR', value: 70),
      ChartData(day: 'SA', value: 40),
      ChartData(day: 'SU', value: 25),
    ];
  }

  void refreshDashboard() {
    _initializeDashboardData();
    notifyListeners();
  }
}
