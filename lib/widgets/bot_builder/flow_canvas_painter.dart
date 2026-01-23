import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/flow_node_models.dart';

class FlowCanvasPainter extends CustomPainter {
  final List<FlowNode> nodes;
  final List<FlowConnection> connections;
  final Set<String> selectedNodeIds;
  final String? connectingFromNodeId;
  final EdgePosition? connectingFromEdge;
  final Offset? connectingToPosition;
  final bool isDark;

  FlowCanvasPainter({
    required this.nodes,
    required this.connections,
    required this.selectedNodeIds,
    this.connectingFromNodeId,
    this.connectingFromEdge,
    this.connectingToPosition,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid background
    _drawGrid(canvas, size);

    // Draw connections
    for (final connection in connections) {
      final fromNode = nodes.firstWhere((n) => n.id == connection.fromNodeId);
      final toNode = nodes.firstWhere((n) => n.id == connection.toNodeId);
      final fromPoint = _getEdgePoint(fromNode, connection.fromEdge);
      final toPoint = _getEdgePoint(toNode, connection.toEdge);
      _drawConnection(canvas, fromPoint, toPoint, false);
    }

    // Draw temporary connection while dragging
    if (connectingFromNodeId != null && connectingFromEdge != null && connectingToPosition != null) {
      final fromNode = nodes.firstWhere((n) => n.id == connectingFromNodeId);
      final fromPoint = _getEdgePoint(fromNode, connectingFromEdge!);
      _drawConnection(canvas, fromPoint, connectingToPosition!, true);
    }
  }

  Offset _getEdgePoint(FlowNode node, EdgePosition edge) {
    const nodeWidth = 140.0;
    const nodeHeight = 140.0;
    final centerX = node.position.dx + nodeWidth / 2;
    final centerY = node.position.dy + nodeHeight / 2;

    switch (edge) {
      case EdgePosition.top:
        return Offset(centerX, node.position.dy);
      case EdgePosition.right:
        return Offset(node.position.dx + nodeWidth, centerY);
      case EdgePosition.bottom:
        return Offset(centerX, node.position.dy + nodeHeight);
      case EdgePosition.left:
        return Offset(node.position.dx, centerY);
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridSize = 20.0;
    final paint = Paint()
      ..color = isDark ? Colors.grey[800]! : Colors.grey[300]!
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  void _drawConnection(Canvas canvas, Offset from, Offset to, bool isTemporary) {
    final paint = Paint()
      ..color = isTemporary ? Colors.blue[400]! : Colors.blue[600]!
      ..strokeWidth = isTemporary ? 3 : 2.5
      ..style = PaintingStyle.stroke;

    // Draw curved line
    final controlPoint = Offset(
      (from.dx + to.dx) / 2,
      (from.dy + to.dy) / 2 + 50,
    );

    final path = Path()
      ..moveTo(from.dx, from.dy)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, to.dx, to.dy);

    if (isTemporary) {
      _drawDashedPath(canvas, path, paint);
    } else {
      canvas.drawPath(path, paint);
    }

    // Draw arrow head
    final angle = math.atan2(to.dy - from.dy, to.dx - from.dx);
    final arrowSize = 12.0;
    final arrowPaint = Paint()
      ..color = isTemporary ? Colors.blue[400]! : Colors.blue[600]!
      ..style = PaintingStyle.fill;

    final arrowPath = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - arrowSize * (math.cos(angle) + math.sin(angle)),
        to.dy - arrowSize * (math.sin(angle) - math.cos(angle)),
      )
      ..lineTo(
        to.dx - arrowSize * (math.cos(angle) - math.sin(angle)),
        to.dy - arrowSize * (math.sin(angle) + math.cos(angle)),
      )
      ..close();

    canvas.drawPath(arrowPath, arrowPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double distance = 0.0;

    for (final metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final start = metric.getTangentForOffset(distance);
        final end = metric.getTangentForOffset(distance + dashWidth);
        
        if (start != null && end != null) {
          canvas.drawLine(start.position, end.position, paint);
        }
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(FlowCanvasPainter oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.connections != connections ||
        oldDelegate.selectedNodeIds != selectedNodeIds ||
        oldDelegate.connectingFromNodeId != connectingFromNodeId ||
        oldDelegate.connectingFromEdge != connectingFromEdge ||
        oldDelegate.connectingToPosition != connectingToPosition;
  }
}
