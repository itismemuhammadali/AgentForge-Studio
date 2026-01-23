import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class IntegrationsScreen extends StatefulWidget {
  const IntegrationsScreen({Key? key}) : super(key: key);

  @override
  State<IntegrationsScreen> createState() => _IntegrationsScreenState();
}

class _IntegrationsScreenState extends State<IntegrationsScreen> {
  String _selectedCategory = 'all';

  final List<Map<String, dynamic>> integrations = [
    {
      'name': 'Shopify',
      'category': 'ecommerce',
      'description': 'Connect your Shopify store to manage orders and customer interactions',
      'icon': '🛍️',
      'connected': true,
      'users': 1250,
    },
    {
      'name': 'Slack',
      'category': 'communication',
      'description': 'Send bot notifications and manage conversations directly in Slack',
      'icon': '💬',
      'connected': true,
      'users': 890,
    },
    {
      'name': 'Google Sheets',
      'category': 'productivity',
      'description': 'Sync data and automate workflows with Google Sheets',
      'icon': '📊',
      'connected': false,
      'users': 0,
    },
    {
      'name': 'Zapier',
      'category': 'automation',
      'description': 'Connect to 5000+ apps and automate your workflows',
      'icon': '⚡',
      'connected': true,
      'users': 2100,
    },
    {
      'name': 'Stripe',
      'category': 'payments',
      'description': 'Process payments and manage transactions seamlessly',
      'icon': '💳',
      'connected': false,
      'users': 0,
    },
    {
      'name': 'HubSpot',
      'category': 'crm',
      'description': 'Manage customer relationships and sales pipelines',
      'icon': '👥',
      'connected': true,
      'users': 567,
    },
    {
      'name': 'Mailchimp',
      'category': 'marketing',
      'description': 'Send email campaigns and manage subscriber lists',
      'icon': '📧',
      'connected': false,
      'users': 0,
    },
    {
      'name': 'Twilio',
      'category': 'communication',
      'description': 'Send SMS and voice messages to your customers',
      'icon': '📱',
      'connected': true,
      'users': 445,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final filteredIntegrations = _selectedCategory == 'all'
        ? integrations
        : integrations.where((i) => i['category'] == _selectedCategory).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Integrations',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Connect your bots with your favorite tools and services.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Integration'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stats Row
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.2,
            children: [
              _buildStatCard(
                context,
                label: 'Connected',
                value: '5',
                icon: Icons.check_circle_outline,
                themeProvider: themeProvider,
              ),
              _buildStatCard(
                context,
                label: 'Available',
                value: '8',
                icon: Icons.apps_outlined,
                themeProvider: themeProvider,
              ),
              _buildStatCard(
                context,
                label: 'Total Users',
                value: '5,252',
                icon: Icons.people_outline,
                themeProvider: themeProvider,
              ),
              _buildStatCard(
                context,
                label: 'Active Connections',
                value: '12',
                icon: Icons.link_outlined,
                themeProvider: themeProvider,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Category Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryButton('All', 'all', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('E-commerce', 'ecommerce', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Communication', 'communication', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Productivity', 'productivity', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Automation', 'automation', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Payments', 'payments', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('CRM', 'crm', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Marketing', 'marketing', themeProvider, isDark),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Integrations Grid
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
            ),
            itemCount: filteredIntegrations.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final integration = filteredIntegrations[index];
              return _buildIntegrationCard(
                context,
                integration: integration,
                isDark: isDark,
                themeProvider: themeProvider,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    String label,
    String value,
    ThemeProvider themeProvider,
    bool isDark,
  ) {
    final isActive = _selectedCategory == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? themeProvider.primaryColor
              : (isDark ? const Color(0xFF2A2A2A) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive
                ? themeProvider.primaryColor
                : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required ThemeProvider themeProvider,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                icon,
                size: 18,
                color: themeProvider.primaryColor,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationCard(
    BuildContext context, {
    required Map<String, dynamic> integration,
    required bool isDark,
    required ThemeProvider themeProvider,
  }) {
    final isConnected = integration['connected'] as bool;

    return Container(
      padding: const EdgeInsets.all(16),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                integration['icon'] as String,
                style: const TextStyle(fontSize: 28),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isConnected
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isConnected ? 'Connected' : 'Not Connected',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isConnected ? Colors.green : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            integration['name'] as String,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            integration['description'] as String,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          if (isConnected)
            Text(
              '${integration['users']} users connected',
              style: TextStyle(
                fontSize: 11,
                color: themeProvider.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            const SizedBox.shrink(),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isConnected
                    ? Colors.red
                    : themeProvider.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                isConnected ? 'Disconnect' : 'Connect',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
