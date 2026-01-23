import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class ConversationsTab extends StatefulWidget {
  const ConversationsTab({Key? key}) : super(key: key);

  @override
  State<ConversationsTab> createState() => _ConversationsTabState();
}

class _ConversationsTabState extends State<ConversationsTab> {
  // Sample conversation data
  final List<ConversationRecord> conversations = [
    ConversationRecord(
      dateTime: '17 Jan, 15:42',
      user: 'Visitor #8241',
      status: 'AI_HANDLED',
      sentiment: 'POSITIVE',
      action: 'View Transcript',
    ),
    ConversationRecord(
      dateTime: '17 Jan, 14:15',
      user: 'Visitor #8239',
      status: 'HUMAN_TAKEOVER',
      sentiment: 'NEGATIVE',
      action: 'View Transcript',
    ),
    ConversationRecord(
      dateTime: '17 Jan, 13:02',
      user: 'Visitor #8238',
      status: 'AI_HANDLED',
      sentiment: 'NEUTRAL',
      action: 'View Transcript',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.conversationHistory,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.monitorAllInteractions,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Export buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 16),
                  label: Text(l10n.exportToCsv),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2563EB),
                    side: const BorderSide(color: Color(0xFF2563EB)),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 16),
                  label: Text(l10n.exportToPdf),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2563EB),
                    side: const BorderSide(color: Color(0xFF2563EB)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Table
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Table header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.grey[50],
                      border: Border(
                        bottom: BorderSide(
                          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            l10n.dateTime,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            l10n.user,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            l10n.status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            l10n.sentiment,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            l10n.action,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Table rows
                  ...conversations.asMap().entries.map((entry) {
                    final index = entry.key;
                    final record = entry.value;
                    final isLast = index == conversations.length - 1;

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  record.dateTime,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  record.user,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: _buildStatusBadge(context, record.status, l10n),
                              ),
                              Expanded(
                                flex: 2,
                                child: _buildSentimentBadge(context, record.sentiment, l10n),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    l10n.viewTranscript,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF2563EB),
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            color: isDark ? Colors.grey[800] : Colors.grey[200],
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status, AppLocalizations l10n) {
    String label;
    Color backgroundColor;
    Color textColor;

    if (status == 'AI_HANDLED') {
      label = l10n.aiHandled;
      backgroundColor = const Color(0xFF10B981).withOpacity(0.1);
      textColor = const Color(0xFF10B981);
    } else {
      label = l10n.humanTakeover;
      backgroundColor = const Color(0xFFF59E0B).withOpacity(0.1);
      textColor = const Color(0xFFF59E0B);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildSentimentBadge(BuildContext context, String sentiment, AppLocalizations l10n) {
    String label;
    Color textColor;

    switch (sentiment) {
      case 'POSITIVE':
        label = l10n.positive;
        textColor = const Color(0xFF10B981);
        break;
      case 'NEGATIVE':
        label = l10n.negative;
        textColor = const Color(0xFFEF4444);
        break;
      default:
        label = l10n.neutral;
        textColor = Colors.grey[600]!;
    }

    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
    );
  }
}

class ConversationRecord {
  final String dateTime;
  final String user;
  final String status;
  final String sentiment;
  final String action;

  ConversationRecord({
    required this.dateTime,
    required this.user,
    required this.status,
    required this.sentiment,
    required this.action,
  });
}
