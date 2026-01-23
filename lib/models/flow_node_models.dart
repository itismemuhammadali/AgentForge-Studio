import 'package:flutter/material.dart';

enum NodeType {
  start,
  stop,
  question,
  textMessage,
  aiNode,
  apiCall,
  logicSwitch,
  handover,
  bookingMode,
  leadCapture,
}

enum EdgePosition {
  top,
  right,
  bottom,
  left,
}

class FlowNode {
  final String id;
  final NodeType type;
  final Offset position;
  final String label;
  final String? notes;
  final List<String> outputConnections; // IDs of connected nodes

  FlowNode({
    required this.id,
    required this.type,
    required this.position,
    required this.label,
    this.notes,
    this.outputConnections = const [],
  });

  FlowNode copyWith({
    String? id,
    NodeType? type,
    Offset? position,
    String? label,
    String? notes,
    List<String>? outputConnections,
  }) {
    return FlowNode(
      id: id ?? this.id,
      type: type ?? this.type,
      position: position ?? this.position,
      label: label ?? this.label,
      notes: notes ?? this.notes,
      outputConnections: outputConnections ?? this.outputConnections,
    );
  }

  static String getNodeTypeLabel(NodeType type) {
    switch (type) {
      case NodeType.start:
        return 'Start';
      case NodeType.stop:
        return 'Stop';
      case NodeType.question:
        return 'Question';
      case NodeType.textMessage:
        return 'Text Message';
      case NodeType.aiNode:
        return 'AI Node';
      case NodeType.apiCall:
        return 'API Call';
      case NodeType.logicSwitch:
        return 'Logic Switch';
      case NodeType.handover:
        return 'Handover';
      case NodeType.bookingMode:
        return 'Booking Mode';
      case NodeType.leadCapture:
        return 'Lead Capture';
    }
  }

  static Color getNodeColor(NodeType type) {
    switch (type) {
      case NodeType.start:
        return const Color(0xFF10B981);
      case NodeType.stop:
        return const Color(0xFFEF4444);
      case NodeType.question:
        return const Color(0xFFEF4444);
      case NodeType.textMessage:
        return const Color(0xFF9CA3AF);
      case NodeType.aiNode:
        return const Color(0xFFFCD34D);
      case NodeType.apiCall:
        return const Color(0xFF000000);
      case NodeType.logicSwitch:
        return const Color(0xFF3B82F6);
      case NodeType.handover:
        return const Color(0xFFEF4444);
      case NodeType.bookingMode:
        return const Color(0xFF9CA3AF);
      case NodeType.leadCapture:
        return const Color(0xFF9CA3AF);
    }
  }

  static IconData getNodeIcon(NodeType type) {
    switch (type) {
      case NodeType.start:
        return Icons.play_circle_outline;
      case NodeType.stop:
        return Icons.stop_circle_outlined;
      case NodeType.question:
        return Icons.help_outline;
      case NodeType.textMessage:
        return Icons.message_outlined;
      case NodeType.aiNode:
        return Icons.auto_awesome;
      case NodeType.apiCall:
        return Icons.api;
      case NodeType.logicSwitch:
        return Icons.toggle_on;
      case NodeType.handover:
        return Icons.person;
      case NodeType.bookingMode:
        return Icons.calendar_today;
      case NodeType.leadCapture:
        return Icons.person_add;
    }
  }
}

class FlowConnection {
  final String id;
  final String fromNodeId;
  final String toNodeId;
  final EdgePosition fromEdge;
  final EdgePosition toEdge;
  final String? label;

  FlowConnection({
    required this.id,
    required this.fromNodeId,
    required this.toNodeId,
    required this.fromEdge,
    required this.toEdge,
    this.label,
  });

  FlowConnection copyWith({
    String? id,
    String? fromNodeId,
    String? toNodeId,
    EdgePosition? fromEdge,
    EdgePosition? toEdge,
    String? label,
  }) {
    return FlowConnection(
      id: id ?? this.id,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      toNodeId: toNodeId ?? this.toNodeId,
      fromEdge: fromEdge ?? this.fromEdge,
      toEdge: toEdge ?? this.toEdge,
      label: label ?? this.label,
    );
  }
}
