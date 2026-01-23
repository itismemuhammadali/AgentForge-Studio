import 'package:flutter/material.dart';
import '../../models/flow_node_models.dart';

class FlowNodeWidget extends StatefulWidget {
  final FlowNode node;
  final bool isSelected;
  final VoidCallback onTap;
  final Function(Offset) onDragStart;
  final Function(Offset) onDragUpdate;
  final VoidCallback onDragEnd;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final Function(EdgePosition) onEdgeSelected;
  final bool isDark;

  const FlowNodeWidget({
    Key? key,
    required this.node,
    required this.isSelected,
    required this.onTap,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
    required this.onDelete,
    required this.onEdit,
    required this.onEdgeSelected,
    required this.isDark,
  }) : super(key: key);

  @override
  State<FlowNodeWidget> createState() => _FlowNodeWidgetState();
}

class _FlowNodeWidgetState extends State<FlowNodeWidget> {
  EdgePosition? _hoveredEdge;

  @override
  Widget build(BuildContext context) {
    final nodeColor = FlowNode.getNodeColor(widget.node.type);
    final nodeIcon = FlowNode.getNodeIcon(widget.node.type);
    const nodeWidth = 140.0;
    const nodeHeight = 140.0;

    return Positioned(
      left: widget.node.position.dx,
      top: widget.node.position.dy,
      child: GestureDetector(
        onTap: () => widget.onTap(),
        onLongPressStart: (details) {
          widget.onDragStart(details.globalPosition);
        },
        onLongPressMoveUpdate: (details) {
          widget.onDragUpdate(details.globalPosition);
        },
        onLongPressEnd: (_) {
          widget.onDragEnd();
        },
        child: Container(
          width: nodeWidth,
          height: nodeHeight,
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF2A2A2A) : Colors.white,
            border: Border.all(
              color: widget.isSelected ? Colors.blue : nodeColor,
              width: widget.isSelected ? 3 : 2,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    nodeIcon,
                    size: 40,
                    color: nodeColor,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.node.label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              // Edge connection points (only show when selected)
              if (widget.isSelected) ...[
                // Top edge
                Positioned(
                  top: -12,
                  left: nodeWidth / 2 - 15,
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _hoveredEdge = EdgePosition.top),
                    onExit: (_) => setState(() => _hoveredEdge = null),
                    child: _buildEdgePoint(EdgePosition.top, nodeColor),
                  ),
                ),
                // Right edge
                Positioned(
                  right: -12,
                  top: nodeHeight / 2 - 15,
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _hoveredEdge = EdgePosition.right),
                    onExit: (_) => setState(() => _hoveredEdge = null),
                    child: _buildEdgePoint(EdgePosition.right, nodeColor),
                  ),
                ),
                // Bottom edge
                Positioned(
                  bottom: -12,
                  left: nodeWidth / 2 - 15,
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _hoveredEdge = EdgePosition.bottom),
                    onExit: (_) => setState(() => _hoveredEdge = null),
                    child: _buildEdgePoint(EdgePosition.bottom, nodeColor),
                  ),
                ),
                // Left edge
                Positioned(
                  left: -12,
                  top: nodeHeight / 2 - 15,
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _hoveredEdge = EdgePosition.left),
                    onExit: (_) => setState(() => _hoveredEdge = null),
                    child: _buildEdgePoint(EdgePosition.left, nodeColor),
                  ),
                ),
              ],
              // Action buttons (always visible)
              Positioned(
                top: 4,
                right: 4,
                child: Column(
                  children: [
                    _buildActionButton(
                      icon: Icons.edit,
                      onTap: widget.onEdit,
                      tooltip: 'Edit',
                    ),
                    const SizedBox(height: 4),
                    _buildActionButton(
                      icon: Icons.delete,
                      onTap: widget.onDelete,
                      tooltip: 'Delete',
                      isDelete: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEdgePoint(EdgePosition edge, Color nodeColor) {
    final isHovered = _hoveredEdge == edge;
    
    return GestureDetector(
      onTap: () => widget.onEdgeSelected(edge),
      child: Container(
        width: isHovered ? 36 : 30,
        height: isHovered ? 36 : 30,
        decoration: BoxDecoration(
          color: nodeColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.isDark ? const Color(0xFF2A2A2A) : Colors.white,
            width: isHovered ? 4 : 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isHovered ? 0.4 : 0.2),
              blurRadius: isHovered ? 8 : 4,
            ),
          ],
        ),
        child: Icon(
          _getEdgeIcon(edge),
          size: isHovered ? 16 : 14,
          color: Colors.white,
        ),
      ),
    );
  }

  IconData _getEdgeIcon(EdgePosition edge) {
    switch (edge) {
      case EdgePosition.top:
        return Icons.arrow_upward;
      case EdgePosition.right:
        return Icons.arrow_forward;
      case EdgePosition.bottom:
        return Icons.arrow_downward;
      case EdgePosition.left:
        return Icons.arrow_back;
    }
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
    bool isDelete = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isDelete ? Colors.red : Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
