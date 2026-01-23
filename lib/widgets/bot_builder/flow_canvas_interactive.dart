import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/flow_node_models.dart';
import '../../providers/theme_provider.dart';
import 'flow_canvas_painter.dart';
import 'flow_node_widget.dart';

class FlowCanvasInteractive extends StatefulWidget {
  final List<FlowNode> nodes;
  final List<FlowConnection> connections;
  final Set<String> selectedNodeIds;
  final bool isArrowMode;
  final Function(bool) onArrowModeChanged;
  final Function(Set<String>) onSelectedNodesChanged;
  final Function(FlowNode) onNodeAdded;
  final Function(String) onNodeDeleted;
  final Function(FlowNode) onNodeUpdated;
  final Function(FlowConnection) onConnectionAdded;
  final Function(String) onConnectionDeleted;

  const FlowCanvasInteractive({
    Key? key,
    required this.nodes,
    required this.connections,
    required this.selectedNodeIds,
    required this.isArrowMode,
    required this.onArrowModeChanged,
    required this.onSelectedNodesChanged,
    required this.onNodeAdded,
    required this.onNodeDeleted,
    required this.onNodeUpdated,
    required this.onConnectionAdded,
    required this.onConnectionDeleted,
  }) : super(key: key);

  @override
  State<FlowCanvasInteractive> createState() => _FlowCanvasInteractiveState();
}

class _FlowCanvasInteractiveState extends State<FlowCanvasInteractive> {
  late TransformationController _transformationController;
  String? _connectingFromNodeId;
  EdgePosition? _connectingFromEdge;
  Offset? _connectingToPosition;
  String? _draggingNodeId;
  Offset? _dragStartPosition;
  Offset? _dragStartNodePosition;
  bool _isFullscreen = false;

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

  Set<String> get _selectedNodeIds => widget.selectedNodeIds;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (_isFullscreen) {
      return Scaffold(
        body: Row(
          children: [
            // Sidebar in fullscreen
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
                          // Arrow/Connection Tool
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.onArrowModeChanged(!widget.isArrowMode);
                                  });
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: widget.isArrowMode
                                        ? themeProvider.primaryColor.withOpacity(0.1)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: widget.isArrowMode
                                        ? Border.all(
                                            color: themeProvider.primaryColor,
                                            width: 2,
                                          )
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: widget.isArrowMode
                                            ? themeProvider.primaryColor
                                            : Colors.grey[600],
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Connect',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: widget.isArrowMode
                                                ? themeProvider.primaryColor
                                                : Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Divider(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Canvas in fullscreen
            Expanded(
              child: _buildCanvasContent(isDark, themeProvider),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: _buildCanvasContent(isDark, themeProvider),
        ),
      ],
    );
  }

  Widget _buildCanvasContent(bool isDark, ThemeProvider themeProvider) {
    return Column(
      children: [
        // Toolbar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Canvas (${widget.nodes.length} nodes, ${widget.connections.length} connections)',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_connectingFromNodeId != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_forward, size: 16, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'Connecting... Click an edge on another node to complete',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _connectingFromNodeId = null;
                              _connectingFromEdge = null;
                              _connectingToPosition = null;
                            });
                          },
                          child: const Icon(Icons.close, size: 16, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              // Zoom controls
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.zoom_out),
                    onPressed: () {
                      final currentScale = _transformationController.value.getMaxScaleOnAxis();
                      if (currentScale > 0.5) {
                        _transformationController.value = Matrix4.identity()
                          ..scale(currentScale - 0.1);
                      }
                    },
                    tooltip: 'Zoom Out',
                  ),
                  Text(
                    '${(_transformationController.value.getMaxScaleOnAxis() * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(fontSize: 12),
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_in),
                    onPressed: () {
                      final currentScale = _transformationController.value.getMaxScaleOnAxis();
                      if (currentScale < 3) {
                        _transformationController.value = Matrix4.identity()
                          ..scale(currentScale + 0.1);
                      }
                    },
                    tooltip: 'Zoom In',
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.fit_screen),
                    onPressed: () {
                      _transformationController.value = Matrix4.identity();
                    },
                    tooltip: 'Fit to Screen',
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_sweep),
                    onPressed: widget.selectedNodeIds.isNotEmpty
                        ? () {
                            for (final nodeId in widget.selectedNodeIds) {
                              _deleteNode(nodeId);
                            }
                          }
                        : null,
                    tooltip: 'Delete Selected',
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen),
                    onPressed: () {
                      setState(() {
                        _isFullscreen = !_isFullscreen;
                      });
                    },
                    tooltip: _isFullscreen ? 'Exit Fullscreen' : 'Fullscreen',
                  ),
                ],
              ),
            ],
          ),
        ),
        // Canvas
        Expanded(
          child: InteractiveViewer(
            transformationController: _transformationController,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.5,
            maxScale: 3,
            onInteractionEnd: (_) {
              setState(() {
                _connectingFromNodeId = null;
                _connectingToPosition = null;
              });
            },
            child: Listener(
              onPointerMove: (details) {
                if (_connectingFromNodeId != null && _connectingFromEdge != null) {
                  setState(() {
                    _connectingToPosition = details.position;
                  });
                }
              },
              onPointerUp: (_) {
                if (_connectingFromNodeId != null && _connectingToPosition != null) {
                  setState(() {
                    _connectingToPosition = null;
                  });
                }
              },
              child: GestureDetector(
                onTapDown: (details) {
                  // Only clear selection if not connecting
                  if (_connectingFromNodeId == null) {
                    widget.onSelectedNodesChanged({});
                  }
                },
                child: DragTarget<Map<String, dynamic>>(
                onAcceptWithDetails: (details) {
                  final component = details.data;
                  final renderBox = context.findRenderObject() as RenderBox;
                  final localPosition = renderBox.globalToLocal(details.offset);
                  
                  final newNode = FlowNode(
                    id: '${component['type']}_${DateTime.now().millisecondsSinceEpoch}',
                    type: component['type'] as NodeType,
                    position: localPosition,
                    label: component['name'] as String,
                  );
                  widget.onNodeAdded(newNode);
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 4000,
                    height: 4000,
                    color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
                    child: Stack(
                      children: [
                        // Canvas background with grid
                        CustomPaint(
                          painter: FlowCanvasPainter(
                            nodes: widget.nodes,
                            connections: widget.connections,
                            selectedNodeIds: _selectedNodeIds,
                            connectingFromNodeId: _connectingFromNodeId,
                            connectingFromEdge: _connectingFromEdge,
                            connectingToPosition: _connectingToPosition,
                            isDark: isDark,
                          ),
                          size: Size.infinite,
                        ),
                        // Nodes
                        ...widget.nodes.map((node) {
                          return FlowNodeWidget(
                            key: ValueKey(node.id),
                            node: node,
                            isSelected: _selectedNodeIds.contains(node.id),
                            isDark: isDark,
                            onTap: () {
                              final newSelection = Set<String>.from(_selectedNodeIds);
                              if (newSelection.contains(node.id)) {
                                newSelection.remove(node.id);
                              } else {
                                newSelection.add(node.id);
                              }
                              widget.onSelectedNodesChanged(newSelection);
                            },
                            onDragStart: (globalPos) {
                              setState(() {
                                _draggingNodeId = node.id;
                                _dragStartPosition = globalPos;
                                _dragStartNodePosition = node.position;
                              });
                            },
                            onDragUpdate: (globalPos) {
                              if (_draggingNodeId == node.id && _dragStartPosition != null) {
                                final delta = globalPos - _dragStartPosition!;
                                final newPosition = _dragStartNodePosition! + delta;
                                widget.onNodeUpdated(
                                  node.copyWith(position: newPosition),
                                );
                              }
                            },
                            onDragEnd: () {
                              setState(() {
                                _draggingNodeId = null;
                                _dragStartPosition = null;
                                _dragStartNodePosition = null;
                              });
                            },
                            onDelete: () => _deleteNode(node.id),
                            onEdit: () => _editNode(node),
                            onEdgeSelected: (edge) {
                              if (_connectingFromNodeId == null) {
                                // Start connection
                                setState(() {
                                  _connectingFromNodeId = node.id;
                                  _connectingFromEdge = edge;
                                });
                              } else if (_connectingFromNodeId != node.id) {
                                // Complete connection
                                _createConnectionWithEdges(_connectingFromNodeId!, _connectingFromEdge!, node.id, edge);
                                setState(() {
                                  _connectingFromNodeId = null;
                                  _connectingFromEdge = null;
                                  _connectingToPosition = null;
                                });
                              }
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
            ),
          ),
        ),
      ],
    );
  }

  void _deleteNode(String nodeId) {
    widget.onNodeDeleted(nodeId);
    // Also delete connections
    final connectionsToDelete = widget.connections
        .where((c) => c.fromNodeId == nodeId || c.toNodeId == nodeId)
        .toList();
    for (final connection in connectionsToDelete) {
      widget.onConnectionDeleted(connection.id);
    }
    final newSelection = Set<String>.from(_selectedNodeIds);
    newSelection.remove(nodeId);
    widget.onSelectedNodesChanged(newSelection);
  }

  void _editNode(FlowNode node) {
    showDialog(
      context: context,
      builder: (context) => _buildEditNodeDialog(node),
    );
  }

  void _createConnection(String fromNodeId, String toNodeId) {
    final connection = FlowConnection(
      id: '${fromNodeId}_${toNodeId}_${DateTime.now().millisecondsSinceEpoch}',
      fromNodeId: fromNodeId,
      toNodeId: toNodeId,
      fromEdge: EdgePosition.bottom,
      toEdge: EdgePosition.top,
    );
    widget.onConnectionAdded(connection);
  }

  void _createConnectionWithEdges(String fromNodeId, EdgePosition fromEdge, String toNodeId, EdgePosition toEdge) {
    final connection = FlowConnection(
      id: '${fromNodeId}_${toNodeId}_${DateTime.now().millisecondsSinceEpoch}',
      fromNodeId: fromNodeId,
      toNodeId: toNodeId,
      fromEdge: fromEdge,
      toEdge: toEdge,
    );
    widget.onConnectionAdded(connection);
  }

  Widget _buildEditNodeDialog(FlowNode node) {
    final notesController = TextEditingController(text: node.notes ?? '');
    final labelController = TextEditingController(text: node.label);

    return AlertDialog(
      title: Text('Edit ${FlowNode.getNodeTypeLabel(node.type)}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: labelController,
            decoration: const InputDecoration(
              labelText: 'Label',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: notesController,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onNodeUpdated(
              node.copyWith(
                label: labelController.text,
                notes: notesController.text,
              ),
            );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
