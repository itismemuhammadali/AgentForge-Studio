import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../models/flow_node_models.dart';
import '../flow_canvas_interactive.dart';

class FlowBuilderTab extends StatefulWidget {
  const FlowBuilderTab({Key? key}) : super(key: key);

  @override
  State<FlowBuilderTab> createState() => _FlowBuilderTabState();
}

class _FlowBuilderTabState extends State<FlowBuilderTab> {
  late List<FlowNode> nodes;
  late List<FlowConnection> connections;
  Set<String> _selectedNodeIds = {};
  bool _showCanvas = false;

  final List<Map<String, dynamic>> flowComponents = [
    {
      'name': 'Start',
      'type': NodeType.start,
      'icon': Icons.play_circle_outline,
      'color': const Color(0xFF10B981),
    },
    {
      'name': 'Stop',
      'type': NodeType.stop,
      'icon': Icons.stop_circle_outlined,
      'color': const Color(0xFFEF4444),
    },
    {
      'name': 'Question',
      'type': NodeType.question,
      'icon': Icons.help_outline,
      'color': const Color(0xFFEF4444),
    },
    {
      'name': 'Text Message',
      'type': NodeType.textMessage,
      'icon': Icons.message_outlined,
      'color': const Color(0xFF9CA3AF),
    },
    {
      'name': 'AI Node',
      'type': NodeType.aiNode,
      'icon': Icons.auto_awesome,
      'color': const Color(0xFFFCD34D),
    },
    {
      'name': 'API Call',
      'type': NodeType.apiCall,
      'icon': Icons.api,
      'color': const Color(0xFF000000),
    },
    {
      'name': 'Logic Switch',
      'type': NodeType.logicSwitch,
      'icon': Icons.toggle_on,
      'color': const Color(0xFF3B82F6),
    },
    {
      'name': 'Handover',
      'type': NodeType.handover,
      'icon': Icons.person,
      'color': const Color(0xFFEF4444),
    },
    {
      'name': 'Booking Mode',
      'type': NodeType.bookingMode,
      'icon': Icons.calendar_today,
      'color': const Color(0xFF9CA3AF),
    },
    {
      'name': 'Lead Capture',
      'type': NodeType.leadCapture,
      'icon': Icons.person_add,
      'color': const Color(0xFF9CA3AF),
    },
  ];

  @override
  void initState() {
    super.initState();
    nodes = [];
    connections = [];
  }

  bool _hasConnectionBetween(String nodeId1, String nodeId2) {
    return connections.any((c) =>
        (c.fromNodeId == nodeId1 && c.toNodeId == nodeId2) ||
        (c.fromNodeId == nodeId2 && c.toNodeId == nodeId1));
  }

  void _removeConnection(String nodeId1, String nodeId2) {
    setState(() {
      connections.removeWhere((c) =>
          (c.fromNodeId == nodeId1 && c.toNodeId == nodeId2) ||
          (c.fromNodeId == nodeId2 && c.toNodeId == nodeId1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (_showCanvas) {
      return Row(
        children: [
          // Left Sidebar
          Container(
            width: 240,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
              border: Border(
                right: BorderSide(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'FLOW COMPONENTS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...flowComponents.map((component) {
                          return _buildComponentItem(
                            context,
                            component: component,
                            isDark: isDark,
                            themeProvider: themeProvider,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Canvas
          Expanded(
            child: FlowCanvasInteractive(
              nodes: nodes,
              connections: connections,
              selectedNodeIds: _selectedNodeIds,
              isArrowMode: false,
              onArrowModeChanged: (_) {},
              onSelectedNodesChanged: (selectedIds) {
                setState(() {
                  _selectedNodeIds = selectedIds;
                });
              },
              onNodeAdded: (node) {
                setState(() {
                  nodes.add(node);
                });
              },
              onNodeDeleted: (nodeId) {
                setState(() {
                  nodes.removeWhere((n) => n.id == nodeId);
                });
              },
              onNodeUpdated: (node) {
                setState(() {
                  final index = nodes.indexWhere((n) => n.id == node.id);
                  if (index != -1) {
                    nodes[index] = node;
                  }
                });
              },
              onConnectionAdded: (connection) {
                setState(() {
                  connections.add(connection);
                });
              },
              onConnectionDeleted: (connectionId) {
                setState(() {
                  connections.removeWhere((c) => c.id == connectionId);
                });
              },
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        // Left Sidebar - Flow Components
        Container(
          width: 240,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
            border: Border(
              right: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'FLOW COMPONENTS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: flowComponents.length,
                  itemBuilder: (context, index) {
                    final component = flowComponents[index];
                    return _buildComponentItem(
                      context,
                      component: component,
                      isDark: isDark,
                      themeProvider: themeProvider,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // Main Canvas Area
        Expanded(
          child: Container(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        'Visual Logic Designer',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Drag components here or start with a template.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTemplateButton(
                        context,
                        name: 'Restaurant Template',
                        isDark: isDark,
                        themeProvider: themeProvider,
                        onTap: () => _loadTemplate('restaurant'),
                      ),
                      const SizedBox(width: 24),
                      _buildTemplateButton(
                        context,
                        name: 'Webshop Template',
                        isDark: isDark,
                        themeProvider: themeProvider,
                        onTap: () => _loadTemplate('webshop'),
                      ),
                      const SizedBox(width: 24),
                      _buildTemplateButton(
                        context,
                        name: 'Healthcare Template',
                        isDark: isDark,
                        themeProvider: themeProvider,
                        onTap: () => _loadTemplate('healthcare'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showCanvas = true;
                      nodes = [
                        FlowNode(
                          id: 'start_${DateTime.now().millisecondsSinceEpoch}',
                          type: NodeType.start,
                          position: const Offset(200, 100),
                          label: 'Start',
                        ),
                      ];
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Start from Scratch'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _loadTemplate(String templateType) {
    setState(() {
      _showCanvas = true;
      nodes = _generateTemplateNodes(templateType);
      connections = _generateTemplateConnections(templateType);
    });
  }

  List<FlowNode> _generateTemplateNodes(String templateType) {
    switch (templateType) {
      case 'restaurant':
        return [
          FlowNode(
            id: 'start',
            type: NodeType.start,
            position: const Offset(200, 50),
            label: 'Start',
          ),
          FlowNode(
            id: 'greeting',
            type: NodeType.textMessage,
            position: const Offset(200, 200),
            label: 'Greeting',
          ),
          FlowNode(
            id: 'booking_question',
            type: NodeType.question,
            position: const Offset(200, 350),
            label: 'Make Booking?',
          ),
          FlowNode(
            id: 'booking_mode',
            type: NodeType.bookingMode,
            position: const Offset(200, 500),
            label: 'Booking',
          ),
          FlowNode(
            id: 'end',
            type: NodeType.stop,
            position: const Offset(200, 650),
            label: 'End',
          ),
        ];
      case 'webshop':
        return [
          FlowNode(
            id: 'start',
            type: NodeType.start,
            position: const Offset(200, 50),
            label: 'Start',
          ),
          FlowNode(
            id: 'product_inquiry',
            type: NodeType.question,
            position: const Offset(200, 200),
            label: 'Product Inquiry',
          ),
          FlowNode(
            id: 'api_call',
            type: NodeType.apiCall,
            position: const Offset(200, 350),
            label: 'Fetch Products',
          ),
          FlowNode(
            id: 'lead_capture',
            type: NodeType.leadCapture,
            position: const Offset(200, 500),
            label: 'Capture Lead',
          ),
          FlowNode(
            id: 'end',
            type: NodeType.stop,
            position: const Offset(200, 650),
            label: 'End',
          ),
        ];
      case 'healthcare':
        return [
          FlowNode(
            id: 'start',
            type: NodeType.start,
            position: const Offset(200, 50),
            label: 'Start',
          ),
          FlowNode(
            id: 'symptom_check',
            type: NodeType.question,
            position: const Offset(200, 200),
            label: 'Symptom Check',
          ),
          FlowNode(
            id: 'ai_diagnosis',
            type: NodeType.aiNode,
            position: const Offset(200, 350),
            label: 'AI Diagnosis',
          ),
          FlowNode(
            id: 'booking',
            type: NodeType.bookingMode,
            position: const Offset(200, 500),
            label: 'Book Appointment',
          ),
          FlowNode(
            id: 'end',
            type: NodeType.stop,
            position: const Offset(200, 650),
            label: 'End',
          ),
        ];
      default:
        return [];
    }
  }

  List<FlowConnection> _generateTemplateConnections(String templateType) {
    switch (templateType) {
      case 'restaurant':
        return [
          FlowConnection(
            id: 'conn1',
            fromNodeId: 'start',
            toNodeId: 'greeting',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn2',
            fromNodeId: 'greeting',
            toNodeId: 'booking_question',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn3',
            fromNodeId: 'booking_question',
            toNodeId: 'booking_mode',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn4',
            fromNodeId: 'booking_mode',
            toNodeId: 'end',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
        ];
      case 'webshop':
        return [
          FlowConnection(
            id: 'conn1',
            fromNodeId: 'start',
            toNodeId: 'product_inquiry',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn2',
            fromNodeId: 'product_inquiry',
            toNodeId: 'api_call',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn3',
            fromNodeId: 'api_call',
            toNodeId: 'lead_capture',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn4',
            fromNodeId: 'lead_capture',
            toNodeId: 'end',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
        ];
      case 'healthcare':
        return [
          FlowConnection(
            id: 'conn1',
            fromNodeId: 'start',
            toNodeId: 'symptom_check',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn2',
            fromNodeId: 'symptom_check',
            toNodeId: 'ai_diagnosis',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn3',
            fromNodeId: 'ai_diagnosis',
            toNodeId: 'booking',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
          FlowConnection(
            id: 'conn4',
            fromNodeId: 'booking',
            toNodeId: 'end',
            fromEdge: EdgePosition.bottom,
            toEdge: EdgePosition.top,
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildComponentItem(
    BuildContext context, {
    required Map<String, dynamic> component,
    required bool isDark,
    required ThemeProvider themeProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Draggable<Map<String, dynamic>>(
        data: component,
        feedback: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            border: Border.all(
              color: component['color'] as Color,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                component['icon'] as IconData,
                size: 28,
                color: component['color'] as Color,
              ),
              const SizedBox(height: 4),
              Text(
                component['name'] as String,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    component['icon'] as IconData,
                    size: 20,
                    color: component['color'] as Color,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      component['name'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplateButton(
    BuildContext context, {
    required String name,
    required bool isDark,
    required ThemeProvider themeProvider,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: themeProvider.primaryColor.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: themeProvider.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
