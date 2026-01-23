import 'package:flutter/material.dart';
import '../../models/bot_builder_models.dart';
import '../../providers/bot_builder_provider.dart';
import 'package:provider/provider.dart';

class NodePalette extends StatelessWidget {
  const NodePalette({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<BotBuilderProvider>(
      builder: (context, provider, _) {
        return Container(
          width: 280,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            border: Border(
              right: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Nodes Section
                Text(
                  'BASIC NODES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildNodeButton(
                  context,
                  icon: Icons.chat_bubble_outline,
                  label: 'Message',
                  color: const Color(0xFF3B82F6),
                  onTap: () => _addNodeToCanvas(provider, 'message', 'Message'),
                ),
                const SizedBox(height: 8),
                _buildNodeButton(
                  context,
                  icon: Icons.help_outline,
                  label: 'Question',
                  color: const Color(0xFF10B981),
                  onTap: () => _addNodeToCanvas(provider, 'question', 'Question'),
                ),
                const SizedBox(height: 8),
                _buildNodeButton(
                  context,
                  icon: Icons.list_outlined,
                  label: 'Choices',
                  color: const Color(0xFFF59E0B),
                  onTap: () => _addNodeToCanvas(provider, 'choices', 'Choices'),
                ),
                const SizedBox(height: 24),
                // Advanced Nodes Section
                Text(
                  'ADVANCED',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildNodeButton(
                  context,
                  icon: Icons.psychology_outlined,
                  label: 'AI Agent',
                  color: const Color(0xFF8B5CF6),
                  onTap: () => _addNodeToCanvas(provider, 'ai_agent', 'AI Agent'),
                ),
                const SizedBox(height: 8),
                _buildNodeButton(
                  context,
                  icon: Icons.code_outlined,
                  label: 'Function',
                  color: const Color(0xFF1F2937),
                  onTap: () => _addNodeToCanvas(provider, 'function', 'Function'),
                ),
                const SizedBox(height: 8),
                _buildNodeButton(
                  context,
                  icon: Icons.person_outline,
                  label: 'Human Handoff',
                  color: const Color(0xFFEF4444),
                  onTap: () => _addNodeToCanvas(provider, 'handoff', 'Human Handoff'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNodeButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 16,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNodeToCanvas(BotBuilderProvider provider, String nodeType, String label) {
    final newNodeId = 'node_${DateTime.now().millisecondsSinceEpoch}';
    final lastNode = provider.currentFlow.nodes.isNotEmpty
        ? provider.currentFlow.nodes.last
        : null;

    final newNode = BotNode(
      id: newNodeId,
      type: nodeType,
      label: label,
      x: lastNode != null ? lastNode.x : 700,
      y: lastNode != null ? lastNode.y + 130 : 220,
    );

    provider.addNode(newNode);

    // Auto-connect to last node if exists
    if (lastNode != null) {
      provider.addConnection(
        BotConnection(
          fromNodeId: lastNode.id,
          toNodeId: newNodeId,
        ),
      );
    }
  }
}
