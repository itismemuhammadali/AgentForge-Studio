import 'package:flutter/material.dart';
import '../../providers/bot_builder_provider.dart';
import '../../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class TestPanel extends StatefulWidget {
  const TestPanel({Key? key}) : super(key: key);

  @override
  State<TestPanel> createState() => _TestPanelState();
}

class _TestPanelState extends State<TestPanel> {
  late TextEditingController _userInputController;
  late TextEditingController _botResponseController;
  final List<Map<String, String>> _chatHistory = [];

  @override
  void initState() {
    super.initState();
    _userInputController = TextEditingController();
    _botResponseController = TextEditingController();
  }

  @override
  void dispose() {
    _userInputController.dispose();
    _botResponseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Consumer<BotBuilderProvider>(
      builder: (context, provider, _) {
        return Container(
          width: 320,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            border: Border(
              left: BorderSide(
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
                  children: [
                    Icon(
                      Icons.chat_outlined,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Test Flow',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Chat history
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _chatHistory.length,
                  itemBuilder: (context, index) {
                    final message = _chatHistory[index];
                    final isUser = message['type'] == 'user';

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isUser
                                ? const Color(0xFF2563EB)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: isUser ? Colors.white : Colors.black,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              // Input area
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Input',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _userInputController,
                      decoration: InputDecoration(
                        hintText: 'What user says...',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Bot Response',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _botResponseController,
                      decoration: InputDecoration(
                        hintText: 'Bot response...',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_userInputController.text.isNotEmpty &&
                              _botResponseController.text.isNotEmpty) {
                            // Add to chat history
                            setState(() {
                              _chatHistory.add({
                                'type': 'user',
                                'text': _userInputController.text,
                              });
                              _chatHistory.add({
                                'type': 'bot',
                                'text': _botResponseController.text,
                              });
                            });

                            // Update flow
                            final lastNode = provider.currentFlow.nodes.last;
                            provider.updateFlowFromUserInteraction(
                              nodeId: lastNode.id,
                              userInput: _userInputController.text,
                              botResponse: _botResponseController.text,
                            );

                            // Clear inputs
                            _userInputController.clear();
                            _botResponseController.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeProvider.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: const Text(
                          'Send & Update Flow',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
