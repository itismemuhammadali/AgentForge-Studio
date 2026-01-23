import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/dashboard_models.dart';

class RecentActivityTable extends StatelessWidget {
  final List<BotActivity> activities;

  const RecentActivityTable({
    Key? key,
    required this.activities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color getStatusColor(String status) {
      switch (status) {
        case 'afgerond':
          return const Color(0xFF10B981);
        case 'inGesprek':
          return const Color(0xFF3B82F6);
        case 'handoff':
          return const Color(0xFFF59E0B);
        default:
          return Colors.grey[600]!;
      }
    }

    String getStatusLabel(String status) {
      switch (status) {
        case 'afgerond':
          return 'Completed';
        case 'inGesprek':
          return 'In conversation';
        case 'handoff':
          return 'Handoff';
        default:
          return status;
      }
    }

    String getTypeLabel(String type) {
      switch (type) {
        case 'chat':
          return 'Chat';
        case 'voice':
          return 'Voice';
        default:
          return type;
      }
    }

    return Container(
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
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.recenteActiviteit,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    l10n.exportCsv,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            height: 1,
          ),
          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width - 48,
              ),
              child: DataTable(
                columnSpacing: 32,
                dataRowHeight: 70,
                headingRowHeight: 52,
                dividerThickness: 1,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                ),
              columns: [
                DataColumn(
                  label: Text(
                    'TIME',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'USER',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'BOT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'TYPE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'STATUS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ACTIONS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
              rows: activities
                  .map(
                    (activity) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            activity.time,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        DataCell(
                          Text(
                            activity.user,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        DataCell(
                          Text(
                            activity.botName,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Icon(
                                activity.type == 'chat'
                                    ? Icons.chat_bubble_outline
                                    : Icons.mic_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                getTypeLabel(activity.type),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(activity.status)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              getStatusLabel(activity.status),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: getStatusColor(activity.status),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
