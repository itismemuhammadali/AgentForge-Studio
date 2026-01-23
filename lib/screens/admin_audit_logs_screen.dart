import 'package:flutter/material.dart';

class AdminAuditLogsScreen extends StatefulWidget {
  const AdminAuditLogsScreen({Key? key}) : super(key: key);

  @override
  State<AdminAuditLogsScreen> createState() => _AdminAuditLogsScreenState();
}

class _AdminAuditLogsScreenState extends State<AdminAuditLogsScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> auditLogs = [
    {
      'timestamp': '2025-01-18 11:24',
      'admin': 'Admin Root',
      'action': 'Overwrite Password',
      'actionColor': const Color(0xFFEF4444),
      'target': 'Visitor #8241 (healthcare@ex.nl)',
    },
    {
      'timestamp': '2025-01-18 10:12',
      'admin': 'Admin Root',
      'action': 'Plan Hard Limit Adjustment',
      'actionColor': const Color(0xFF2563EB),
      'target': 'Agency Tier',
    },
    {
      'timestamp': '2025-01-18 09:45',
      'admin': 'Admin Root',
      'action': 'User Account Suspended',
      'actionColor': const Color(0xFFEF4444),
      'target': 'User #5123 (test@example.com)',
    },
    {
      'timestamp': '2025-01-18 08:30',
      'admin': 'Admin Root',
      'action': 'API Key Rotated',
      'actionColor': const Color(0xFFF59E0B),
      'target': 'OpenAI Master Key',
    },
    {
      'timestamp': '2025-01-18 07:15',
      'admin': 'Admin Root',
      'action': 'Template Published',
      'actionColor': const Color(0xFF10B981),
      'target': 'Restaurant Starter v2.1',
    },
    {
      'timestamp': '2025-01-18 06:00',
      'admin': 'Admin Root',
      'action': 'Configuration Updated',
      'actionColor': const Color(0xFF2563EB),
      'target': 'Base Platform Prompt',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Internal Audit & GDPR Logs',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Complete audit trail of all administrative actions',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Search and Filter
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search logs by admin, action, or target...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF2563EB),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Filter Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<String>(
                  value: _selectedFilter,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(
                      value: 'all',
                      child: Text('All Actions'),
                    ),
                    const DropdownMenuItem(
                      value: 'security',
                      child: Text('Security'),
                    ),
                    const DropdownMenuItem(
                      value: 'configuration',
                      child: Text('Configuration'),
                    ),
                    const DropdownMenuItem(
                      value: 'user_management',
                      child: Text('User Management'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value ?? 'all';
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Section Title
          const Text(
            'Security & Audit Logs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),

          // Logs Table
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
              ),
            ),
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'TIMESTAMP',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'ADMIN',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'ACTION PERFORMED',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'TARGET',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Rows
                ...auditLogs.map((log) => _buildLogRow(log, isDark)),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {},
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '2',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '3',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogRow(Map<String, dynamic> log, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              log['timestamp'],
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              log['admin'],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              log['action'],
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: log['actionColor'],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              log['target'],
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
