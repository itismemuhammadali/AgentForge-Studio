import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/bot_builder_models.dart';
import '../../providers/bot_builder_provider.dart';
import 'package:provider/provider.dart';

class FlowCanvas extends StatefulWidget {
  const FlowCanvas({Key? key}) : super(key: key);

  @override
  State<FlowCanvas> createState() => _FlowCanvasState();
}

class _FlowCanvasState extends State<FlowCanvas> {
  late TransformationController _transformationController;
  double _zoomLevel = 1.0;
  Offset? _draggedNodeId;
  String? _selectedNodeForConnection;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<BotBuilderProvider>(
      builder: (context, provider, _) {
        return Stack(
          children: [
            // Canvas
            InteractiveViewer(
              transformationController: _transformationController,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 3,
              onInteractionUpdate: (details) {
                setState(() {
                  _zoomLevel = _transformationController.value.getMaxScaleOnAxis();
                });
              },
              child: Stack(
                children: [
                  // Grid background
                  CustomPaint(
                    painter: GridPainter(isDark: isDark),
                    size: const Size(2000, 2000),
                  ),
                  // Connections
                  CustomPaint(
                    painter: ConnectionPainter(
                      connections: provider.currentFlow.connections,
                      nodes: provider.currentFlow.nodes,
                    ),
                    size: const Size(2000, 2000),
                  ),
                  // Nodes
                  ...provider.currentFlow.nodes.map((node) {
                    return Positioned(
                      left: node.x - 60,
                      top: node.y - 30,
                      child: _buildNode(context, node, provider),
                    );
                  }).toList(),
                ],
              ),
            ),
            // Zoom Controls
            Positioned(
              right: 20,
              bottom: 20,
              child: Column(
                children: [
                  FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      _transformationController.value = Matrix4.identity()
                        ..scale(_zoomLevel + 0.2);
                      setState(() {
                        _zoomLevel += 0.2;
                      });
                    },
                    backgroundColor: const Color(0xFF2563EB),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2563EB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${(_zoomLevel * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      if (_zoomLevel > 0.5) {
                        _transformationController.value = Matrix4.identity()
                          ..scale(_zoomLevel - 0.2);
                        setState(() {
                          _zoomLevel -= 0.2;
                        });
                      }
                    },
                    backgroundColor: const Color(0xFF2563EB),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNode(
    BuildContext context,
    BotNode node,
    BotBuilderProvider provider,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = provider.selectedNode?.id == node.id;

    Color getNodeColor() {
      switch (node.type) {
        case 'start':
          return const Color(0xFF10B981);
        case 'message':
          return const Color(0xFF3B82F6);
        case 'question':
          return const Color(0xFF10B981);
        case 'choices':
          return const Color(0xFFF59E0B);
        case 'ai_agent':
          return const Color(0xFF8B5CF6);
        case 'function':
          return const Color(0xFF1F2937);
        case 'handoff':
          return const Color(0xFFEF4444);
        default:
          return const Color(0xFF6B7280);
      }
    }

    IconData getNodeIcon() {
      switch (node.type) {
        case 'start':
          return Icons.play_circle_outline;
        case 'message':
          return Icons.chat_bubble_outline;
        case 'question':
          return Icons.help_outline;
        case 'choices':
          return Icons.list_outlined;
        case 'ai_agent':
          return Icons.psychology_outlined;
        case 'function':
          return Icons.code_outlined;
        case 'handoff':
          return Icons.person_outline;
        default:
          return Icons.circle_outlined;
      }
    }

    return GestureDetector(
      onTap: () => provider.selectNode(node),
      onLongPressStart: (details) {
        setState(() {
          _draggedNodeId = details.globalPosition;
        });
      },
      onLongPressMoveUpdate: (details) {
        // Update node position during drag
        final newX = node.x + (details.globalPosition.dx - (_draggedNodeId?.dx ?? 0));
        final newY = node.y + (details.globalPosition.dy - (_draggedNodeId?.dy ?? 0));
        provider.updateNodePosition(node.id, newX, newY);
        setState(() {
          _draggedNodeId = details.globalPosition;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? getNodeColor() : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: getNodeColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  getNodeIcon(),
                  size: 16,
                  color: getNodeColor(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              node.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final bool isDark;

  GridPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark ? Colors.grey[800]!.withOpacity(0.3) : Colors.grey[200]!.withOpacity(0.5)
      ..strokeWidth = 0.5;

    const gridSize = 20.0;

    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) => oldDelegate.isDark != isDark;
}

class ConnectionPainter extends CustomPainter {
  final List<BotConnection> connections;
  final List<BotNode> nodes;

  ConnectionPainter({
    required this.connections,
    required this.nodes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (final connection in connections) {
      final fromNode = nodes.firstWhere((n) => n.id == connection.fromNodeId);
      final toNode = nodes.firstWhere((n) => n.id == connection.toNodeId);

      final fromOffset = Offset(fromNode.x, fromNode.y + 30);
      final toOffset = Offset(toNode.x, toNode.y - 30);

      // Draw curved line
      final path = Path();
      path.moveTo(fromOffset.dx, fromOffset.dy);

      final controlY = (fromOffset.dy + toOffset.dy) / 2;
      path.cubicTo(
        fromOffset.dx,
        controlY,
        toOffset.dx,
        controlY,
        toOffset.dx,
        toOffset.dy,
      );

      canvas.drawPath(path, paint);

      // Draw arrow
      final angle = (toOffset - fromOffset).direction;
      final arrowSize = 10.0;
      final arrowPath = Path();
      arrowPath.moveTo(toOffset.dx, toOffset.dy);
      arrowPath.lineTo(
        toOffset.dx - arrowSize * 0.866 * math.cos(angle),
        toOffset.dy - arrowSize * 0.866 * math.sin(angle),
      );
      arrowPath.lineTo(
        toOffset.dx - arrowSize * 0.5 * math.sin(angle),
        toOffset.dy + arrowSize * 0.5 * math.cos(angle),
      );
      arrowPath.close();

      canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(ConnectionPainter oldDelegate) =>
      oldDelegate.connections != connections || oldDelegate.nodes != nodes;
}
