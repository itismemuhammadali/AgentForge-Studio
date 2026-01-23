import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';

class BotsProvider extends ChangeNotifier {
  List<Bot> _bots = [];
  Bot? _selectedBot;

  List<Bot> get bots => _bots;
  Bot? get selectedBot => _selectedBot;

  BotsProvider() {
    _initializeBots();
  }

  void _initializeBots() {
    _bots = [
      Bot(
        id: '1',
        name: 'Customer Support NL',
        icon: '🤖',
        isActive: true,
        mode: 'HYBRID MODE',
        conversations: 1204,
        lastActivity: '2m ago',
      ),
      Bot(
        id: '2',
        name: 'Sales Assistant',
        icon: '💼',
        isActive: true,
        mode: 'AUTONOMOUS',
        conversations: 856,
        lastActivity: '5m ago',
      ),
      Bot(
        id: '3',
        name: 'FAQ Bot',
        icon: '❓',
        isActive: false,
        mode: 'HYBRID MODE',
        conversations: 432,
        lastActivity: '1h ago',
      ),
    ];
  }

  void selectBot(Bot bot) {
    _selectedBot = bot;
    notifyListeners();
  }

  void clearSelection() {
    _selectedBot = null;
    notifyListeners();
  }

  void toggleBotStatus(String botId) {
    final index = _bots.indexWhere((b) => b.id == botId);
    if (index != -1) {
      final bot = _bots[index];
      _bots[index] = Bot(
        id: bot.id,
        name: bot.name,
        icon: bot.icon,
        isActive: !bot.isActive,
        mode: bot.mode,
        conversations: bot.conversations,
        lastActivity: bot.lastActivity,
      );
      notifyListeners();
    }
  }
}
