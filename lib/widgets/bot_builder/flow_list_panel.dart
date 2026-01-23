import 'package:flutter/material.dart';
import '../../models/bot_builder_models.dart';
import '../../providers/bot_builder_provider.dart';
import '../../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class FlowListPanel extends StatefulWidget {
  const FlowListPanel({Key? key}) : super(key: key);

  @override
  State<FlowListPanel> createState() => _FlowListPanelState();
}

class _FlowListPanelState extends State<FlowListPanel> {
  late TextEditingController _flowNameController;

  @override
  void initState() {
    super.initState();
    _flowNameController = TextEditingController();
  }

  @override
  void dispose() {
    _flowNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<BotBuilderProvider>(
      builder: (context, provider, _) {
        return Container(
          width: 300,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            border: Border(
              right: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Flows',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: () => _showCreateFlowDialog(context, provider),
                      tooltip: 'Create new flow',
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Flow list
              Expanded(
                child: ListView.builder(
                  itemCount: provider.allFlows.length,
                  itemBuilder: (context, index) {
                    final flow = provider.allFlows[index];
                    final isSelected = provider.currentFlow.id == flow.id;

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => provider.selectFlow(flow),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2563EB).withOpacity(0.1)
                                : Colors.transparent,
                            border: Border(
                              left: BorderSide(
                                color: isSelected
                                    ? const Color(0xFF2563EB)
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      flow.name,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? const Color(0xFF2563EB)
                                            : Colors.grey[700],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: flow.status == 'active'
                                          ? const Color(0xFF10B981).withOpacity(0.1)
                                          : const Color(0xFFF59E0B).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      flow.status.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: flow.status == 'active'
                                            ? const Color(0xFF10B981)
                                            : const Color(0xFFF59E0B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${flow.nodes.length} nodes',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreateFlowDialog(
    BuildContext context,
    BotBuilderProvider provider,
  ) {
    _flowNameController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Flow'),
        content: TextField(
          controller: _flowNameController,
          decoration: const InputDecoration(
            hintText: 'Enter flow name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_flowNameController.text.isNotEmpty) {
                provider.createNewFlow(_flowNameController.text);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Provider.of<ThemeProvider>(context, listen: false).primaryColor,
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
