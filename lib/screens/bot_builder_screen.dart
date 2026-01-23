import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bot_builder_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/bot_builder/tabs/flow_builder_tab.dart';
import '../widgets/bot_builder/tabs/settings_tab.dart';
import '../widgets/bot_builder/tabs/ai_training_tab.dart';
import '../widgets/bot_builder/tabs/ai_mode_tab.dart';
import '../widgets/bot_builder/tabs/conversations_tab.dart';
import '../widgets/bot_builder/tabs/integrations_tab.dart';
import '../widgets/bot_builder/tabs/analytics_tab.dart';

class BotBuilderScreen extends StatelessWidget {
  final Function(String)? onNavigate;

  const BotBuilderScreen({Key? key, this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Consumer<BotBuilderProvider>(
      builder: (context, provider, _) {
        // Determine back navigation route based on user role
        final backRoute = userProvider.userRole == 'admin' ? '/admin-bots' : '/bots';

        return Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => onNavigate?.call(backRoute),
                  ),
                  const SizedBox(width: 12),
                  // Bot name and status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            provider.currentFlow.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'ACTIVE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF10B981),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Last modified: 2 hours ago by ${provider.currentFlow.lastModifiedBy}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Action buttons
                  ElevatedButton.icon(
                    onPressed: () => provider.saveFlow(),
                    icon: const Icon(Icons.save, size: 16),
                    label: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeProvider.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Tabs
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  _buildTab(
                    context,
                    label: 'Flow Builder',
                    tabId: 'flow_builder',
                    isActive: provider.selectedTab == 'flow_builder',
                    onTap: () => provider.selectTab('flow_builder'),
                  ),
                  _buildTab(
                    context,
                    label: 'Settings',
                    tabId: 'bot_settings',
                    isActive: provider.selectedTab == 'bot_settings',
                    onTap: () => provider.selectTab('bot_settings'),
                  ),
                  _buildTab(
                    context,
                    label: 'AI Training',
                    tabId: 'ai_training',
                    isActive: provider.selectedTab == 'ai_training',
                    onTap: () => provider.selectTab('ai_training'),
                  ),
                  _buildTab(
                    context,
                    label: 'AI Mode',
                    tabId: 'ai_mode',
                    isActive: provider.selectedTab == 'ai_mode',
                    onTap: () => provider.selectTab('ai_mode'),
                  ),
                  _buildTab(
                    context,
                    label: 'Conversations',
                    tabId: 'conversations',
                    isActive: provider.selectedTab == 'conversations',
                    onTap: () => provider.selectTab('conversations'),
                  ),
                  _buildTab(
                    context,
                    label: 'Integrations',
                    tabId: 'integrations',
                    isActive: provider.selectedTab == 'integrations',
                    onTap: () => provider.selectTab('integrations'),
                  ),
                  _buildTab(
                    context,
                    label: 'Analytics',
                    tabId: 'analytics',
                    isActive: provider.selectedTab == 'analytics',
                    onTap: () => provider.selectTab('analytics'),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: _buildTabContent(provider.selectedTab),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String label,
    required String tabId,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? const Color(0xFF2563EB) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? const Color(0xFF2563EB) : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(String tab) {
    switch (tab) {
      case 'flow_builder':
        return const FlowBuilderTab();
      case 'bot_settings':
        return const SettingsTab();
      case 'ai_training':
        return const AITrainingTab();
      case 'ai_mode':
        return const AIModeTab();
      case 'conversations':
        return const ConversationsTab();
      case 'integrations':
        return const IntegrationsTab();
      case 'analytics':
        return const AnalyticsTab();
      default:
        return const FlowBuilderTab();
    }
  }
}

