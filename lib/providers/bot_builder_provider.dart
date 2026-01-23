import 'package:flutter/material.dart';
import '../models/bot_builder_models.dart';

class BotBuilderProvider extends ChangeNotifier {
  late BotFlow currentFlow;
  List<BotFlow> allFlows = [];
  String selectedTab = 'flow_builder';
  String flowBuilderSubTab = 'canvas';
  BotNode? selectedNode;
  bool isCreatingNewFlow = false;

  BotBuilderProvider() {
    _initializeFlows();
  }

  void _initializeFlows() {
    // Initialize with sample flow
    currentFlow = BotFlow(
      id: '1',
      name: 'Customer Service NL',
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      createdBy: 'Gerald H.',
      lastModified: DateTime.now(),
      lastModifiedBy: 'Gerald H.',
      nodes: [
        BotNode(
          id: 'start',
          type: 'start',
          label: 'START',
          x: 700,
          y: 220,
        ),
        BotNode(
          id: 'welcome',
          type: 'message',
          label: 'Welcome Msg',
          x: 700,
          y: 350,
          config: {
            'message': 'Hi there! Welcome to Hammenga. How can I help?',
          },
        ),
        BotNode(
          id: 'router',
          type: 'ai_agent',
          label: 'AI Router',
          x: 700,
          y: 480,
          config: {
            'model': 'gpt-4',
          },
        ),
      ],
      connections: [
        BotConnection(
          fromNodeId: 'start',
          toNodeId: 'welcome',
        ),
        BotConnection(
          fromNodeId: 'welcome',
          toNodeId: 'router',
        ),
      ],
    );

    allFlows = [currentFlow];
  }

  void selectTab(String tab) {
    selectedTab = tab;
    notifyListeners();
  }

  void selectFlowBuilderSubTab(String subTab) {
    flowBuilderSubTab = subTab;
    notifyListeners();
  }

  void selectNode(BotNode node) {
    selectedNode = node;
    notifyListeners();
  }

  void selectFlow(BotFlow flow) {
    currentFlow = flow;
    selectedNode = null;
    notifyListeners();
  }

  void setFlowName(String name) {
    currentFlow = BotFlow(
      id: currentFlow.id,
      name: name,
      status: currentFlow.status,
      createdAt: currentFlow.createdAt,
      createdBy: currentFlow.createdBy,
      lastModified: DateTime.now(),
      lastModifiedBy: currentFlow.lastModifiedBy,
      nodes: currentFlow.nodes,
      connections: currentFlow.connections,
    );
    notifyListeners();
  }

  void createNewFlow(String name) {
    final newFlow = BotFlow(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      status: 'draft',
      createdAt: DateTime.now(),
      createdBy: 'Gerald H.',
      lastModified: DateTime.now(),
      lastModifiedBy: 'Gerald H.',
      nodes: [
        BotNode(
          id: 'start_${DateTime.now().millisecondsSinceEpoch}',
          type: 'start',
          label: 'START',
          x: 700,
          y: 220,
        ),
      ],
      connections: [],
    );

    allFlows.add(newFlow);
    currentFlow = newFlow;
    isCreatingNewFlow = false;
    notifyListeners();
  }

  void addNode(BotNode node) {
    currentFlow.nodes.add(node);
    notifyListeners();
  }

  void removeNode(String nodeId) {
    currentFlow.nodes.removeWhere((n) => n.id == nodeId);
    currentFlow.connections.removeWhere(
      (c) => c.fromNodeId == nodeId || c.toNodeId == nodeId,
    );
    notifyListeners();
  }

  void addConnection(BotConnection connection) {
    currentFlow.connections.add(connection);
    notifyListeners();
  }

  void updateNodePosition(String nodeId, double x, double y) {
    final nodeIndex = currentFlow.nodes.indexWhere((n) => n.id == nodeId);
    if (nodeIndex != -1) {
      final node = currentFlow.nodes[nodeIndex];
      currentFlow.nodes[nodeIndex] = BotNode(
        id: node.id,
        type: node.type,
        label: node.label,
        x: x,
        y: y,
        config: node.config,
      );
      notifyListeners();
    }
  }

  void updateNodeConfig(String nodeId, Map<String, dynamic> config) {
    final nodeIndex = currentFlow.nodes.indexWhere((n) => n.id == nodeId);
    if (nodeIndex != -1) {
      final node = currentFlow.nodes[nodeIndex];
      currentFlow.nodes[nodeIndex] = BotNode(
        id: node.id,
        type: node.type,
        label: node.label,
        x: node.x,
        y: node.y,
        config: config,
      );
      notifyListeners();
    }
  }

  // Real-time update when user interacts with bot
  void updateFlowFromUserInteraction({
    required String nodeId,
    required String userInput,
    required String botResponse,
  }) {
    // Add a new node for the user interaction
    final newNodeId = 'node_${DateTime.now().millisecondsSinceEpoch}';
    final newNode = BotNode(
      id: newNodeId,
      type: 'message',
      label: 'User: $userInput',
      x: 700,
      y: (currentFlow.nodes.isNotEmpty 
          ? currentFlow.nodes.last.y + 130 
          : 220),
      config: {
        'message': userInput,
        'isUserMessage': true,
      },
    );

    currentFlow.nodes.add(newNode);

    // Add connection from previous node
    if (currentFlow.nodes.length > 1) {
      currentFlow.connections.add(
        BotConnection(
          fromNodeId: nodeId,
          toNodeId: newNodeId,
        ),
      );
    }

    // Add bot response node
    final responseNodeId = 'node_${DateTime.now().millisecondsSinceEpoch + 1}';
    final responseNode = BotNode(
      id: responseNodeId,
      type: 'message',
      label: 'Bot: ${botResponse.substring(0, (botResponse.length > 20 ? 20 : botResponse.length))}...',
      x: 700,
      y: newNode.y + 130,
      config: {
        'message': botResponse,
        'isUserMessage': false,
      },
    );

    currentFlow.nodes.add(responseNode);
    currentFlow.connections.add(
      BotConnection(
        fromNodeId: newNodeId,
        toNodeId: responseNodeId,
      ),
    );

    notifyListeners();
  }

  void saveFlow() {
    // TODO: Save to Firebase
    notifyListeners();
  }

  void toggleCreateNewFlow() {
    isCreatingNewFlow = !isCreatingNewFlow;
    notifyListeners();
  }
}
