import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({Key? key}) : super(key: key);

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  String _selectedFilter = 'all';
  String _searchQuery = '';
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            'Conversations',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'View and manage all conversations with your bots.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
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
                label: 'Total Conversations',
                value: '12,847',
                change: '+12%',
                icon: Icons.chat_bubble_outline,
                themeProvider: themeProvider,
              ),
              _buildStatCard(
                context,
                label: 'Active Chats',
                value: '342',
                change: '+5%',
                icon: Icons.chat_outlined,
                themeProvider: themeProvider,
              ),
              _buildStatCard(
                context,
                label: 'Avg. Response Time',
                value: '1.2s',
                change: '-8%',
                icon: Icons.schedule_outlined,
                themeProvider: themeProvider,
              ),
              _buildStatCard(
                context,
                label: 'User Satisfaction',
                value: '94%',
                change: '+3%',
                icon: Icons.sentiment_satisfied_outlined,
                themeProvider: themeProvider,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Filters and Search
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search conversations...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 18,
                        color: Colors.grey[500],
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _buildFilterButton(
                context,
                label: 'All',
                isActive: _selectedFilter == 'all',
                onTap: () => setState(() => _selectedFilter = 'all'),
                themeProvider: themeProvider,
              ),
              const SizedBox(width: 8),
              _buildFilterButton(
                context,
                label: 'Active',
                isActive: _selectedFilter == 'active',
                onTap: () => setState(() => _selectedFilter = 'active'),
                themeProvider: themeProvider,
              ),
              const SizedBox(width: 8),
              _buildFilterButton(
                context,
                label: 'Resolved',
                isActive: _selectedFilter == 'resolved',
                onTap: () => setState(() => _selectedFilter = 'resolved'),
                themeProvider: themeProvider,
              ),
              const SizedBox(width: 8),
              _buildFilterButton(
                context,
                label: 'Pending',
                isActive: _selectedFilter == 'pending',
                onTap: () => setState(() => _selectedFilter = 'pending'),
                themeProvider: themeProvider,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Conversations Table
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Bot Name',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'User',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Messages',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Duration',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Action',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Rows
                ..._buildConversationRows(context, isDark, themeProvider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildConversationRows(
    BuildContext context,
    bool isDark,
    ThemeProvider themeProvider,
  ) {
    final conversations = [
      {
        'bot': 'Customer Service NL',
        'user': 'John Doe',
        'messages': '24',
        'duration': '12m 34s',
        'status': 'Active',
        'statusColor': themeProvider.primaryColor,
      },
      {
        'bot': 'Sales Assistant',
        'user': 'Jane Smith',
        'messages': '18',
        'duration': '8m 12s',
        'status': 'Resolved',
        'statusColor': Colors.green,
      },
      {
        'bot': 'Support Bot',
        'user': 'Mike Johnson',
        'messages': '31',
        'duration': '25m 45s',
        'status': 'Active',
        'statusColor': themeProvider.primaryColor,
      },
      {
        'bot': 'Customer Service NL',
        'user': 'Sarah Williams',
        'messages': '12',
        'duration': '5m 20s',
        'status': 'Pending',
        'statusColor': Colors.orange,
      },
      {
        'bot': 'Sales Assistant',
        'user': 'Tom Brown',
        'messages': '28',
        'duration': '15m 10s',
        'status': 'Resolved',
        'statusColor': Colors.green,
      },
    ];

    return conversations.map((conv) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                conv['bot'] as String,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                conv['user'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                conv['messages'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                conv['duration'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (conv['statusColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  conv['status'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: conv['statusColor'] as Color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  size: 18,
                  color: Colors.grey[600],
                ),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required String change,
    required IconData icon,
    required ThemeProvider themeProvider,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPositive = change.startsWith('+');

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
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: isPositive ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context, {
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required ThemeProvider themeProvider,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
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
}
