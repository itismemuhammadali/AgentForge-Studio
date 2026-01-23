class StatCard {
  final String label;
  final String value;
  final String change;
  final String changeType; // 'positive', 'negative', 'neutral'
  final String? subtitle;
  final String? icon;

  StatCard({
    required this.label,
    required this.value,
    required this.change,
    required this.changeType,
    this.subtitle,
    this.icon,
  });
}

class BotActivity {
  final String id;
  final String time;
  final String user;
  final String botName;
  final String type; // 'chat', 'voice'
  final String status; // 'afgerond', 'inGesprek', 'handoff'
  final int messageCount;

  BotActivity({
    required this.id,
    required this.time,
    required this.user,
    required this.botName,
    required this.type,
    required this.status,
    required this.messageCount,
  });
}

class TopBot {
  final String id;
  final String name;
  final int messageCount;
  final String changePercent;
  final String icon;

  TopBot({
    required this.id,
    required this.name,
    required this.messageCount,
    required this.changePercent,
    required this.icon,
  });
}

class ChartData {
  final String day;
  final double value;

  ChartData({required this.day, required this.value});
}

class Bot {
  final String id;
  final String name;
  final String icon;
  final bool isActive;
  final String mode; // 'HYBRID MODE', 'AUTONOMOUS', etc.
  final int conversations;
  final String lastActivity;

  Bot({
    required this.id,
    required this.name,
    required this.icon,
    required this.isActive,
    required this.mode,
    required this.conversations,
    required this.lastActivity,
  });
}
