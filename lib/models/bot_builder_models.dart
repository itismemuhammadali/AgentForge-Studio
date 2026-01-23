class BotNode {
  final String id;
  final String type; // 'start', 'message', 'question', 'choices', 'ai_agent', 'function', 'handoff'
  final String label;
  final double x;
  final double y;
  final Map<String, dynamic> config;

  BotNode({
    required this.id,
    required this.type,
    required this.label,
    required this.x,
    required this.y,
    this.config = const {},
  });
}

class BotConnection {
  final String fromNodeId;
  final String toNodeId;
  final String? label;

  BotConnection({
    required this.fromNodeId,
    required this.toNodeId,
    this.label,
  });
}

class BotFlow {
  final String id;
  final String name;
  final String status; // 'active', 'inactive', 'draft'
  final List<BotNode> nodes;
  final List<BotConnection> connections;
  final DateTime lastModified;
  final String lastModifiedBy;
  final DateTime createdAt;
  final String createdBy;

  BotFlow({
    required this.id,
    required this.name,
    required this.status,
    required this.nodes,
    required this.connections,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.createdAt,
    required this.createdBy,
  });

  BotFlow copyWith({
    String? id,
    String? name,
    String? status,
    List<BotNode>? nodes,
    List<BotConnection>? connections,
    DateTime? lastModified,
    String? lastModifiedBy,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return BotFlow(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      nodes: nodes ?? this.nodes,
      connections: connections ?? this.connections,
      lastModified: lastModified ?? this.lastModified,
      lastModifiedBy: lastModifiedBy ?? this.lastModifiedBy,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}

class NodeType {
  final String id;
  final String name;
  final String icon;
  final String category; // 'basic', 'advanced'
  final String description;

  NodeType({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
    required this.description,
  });
}
