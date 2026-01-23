import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late TextEditingController _botReplyController;
  late TextEditingController _chatInputController;
  late TextEditingController _colorCodeController;
  String _humanTakeoverDelay = '5 minutes';
  bool _showPoweredByBranding = true;
  Color _themeColor = const Color(0xFF2563EB);
  List<ChatMessage> _chatMessages = [];
  bool _initialized = false;
  String _selectedIcon = 'star';
  String? _avatarPath;
  String _selectedBotMode = 'Hybrid (Flow + AI)';

  final List<String> _botModes = [
    'Hybrid (Flow + AI)',
    'Fully AI Agent',
    'Rule-Based Flow',
  ];

  final List<Map<String, dynamic>> _availableIcons = [
    {'name': 'star', 'icon': Icons.star, 'label': 'Star'},
    {'name': 'heart', 'icon': Icons.favorite, 'label': 'Heart'},
    {'name': 'chat', 'icon': Icons.chat_bubble, 'label': 'Chat'},
    {'name': 'bot', 'icon': Icons.smart_toy, 'label': 'Bot'},
  ];

  @override
  void initState() {
    super.initState();
    _botReplyController = TextEditingController(
      text: "Hello! I'm your AI assistant. How can I help you today?",
    );
    _chatInputController = TextEditingController();
    _colorCodeController = TextEditingController(
      text: _themeColor.value.toRadixString(16).substring(2).toUpperCase(),
    );
    _chatMessages.add(
      ChatMessage(
        text: _botReplyController.text,
        isUser: false,
      ),
    );
    _initialized = true;
  }

  @override
  void dispose() {
    _botReplyController.dispose();
    _chatInputController.dispose();
    _colorCodeController.dispose();
    super.dispose();
  }

  void _sendUserMessage() {
    if (_chatInputController.text.isNotEmpty) {
      setState(() {
        _chatMessages.add(
          ChatMessage(
            text: _chatInputController.text,
            isUser: true,
          ),
        );
        _chatInputController.clear();
      });
    }
  }

  void _updateBotReply() {
    setState(() {
      if (_chatMessages.isNotEmpty && !_chatMessages.last.isUser) {
        _chatMessages.removeLast();
      }
      _chatMessages.add(
        ChatMessage(
          text: _botReplyController.text,
          isUser: false,
        ),
      );
    });
  }

  void _uploadAvatar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        _avatarPath = result.files.single.name;
      });
    }
  }

  void _updateColorFromCode(String code) {
    try {
      final hexColor = code.replaceAll('#', '');
      if (hexColor.length == 6) {
        final color = Color(int.parse('FF$hexColor', radix: 16));
        setState(() {
          _themeColor = color;
          _colorCodeController.text = hexColor.toUpperCase();
        });
      }
    } catch (e) {
      // Invalid color code
    }
  }

  IconData _getIconForSelected() {
    final icon = _availableIcons.firstWhere(
      (i) => i['name'] == _selectedIcon,
      orElse: () => _availableIcons[0],
    );
    return icon['icon'];
  }

  Widget _buildColorOption(Color color, String label) {
    final isSelected = _themeColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _themeColor = color;
        });
      },
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey[300]!,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: isSelected
                ? const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_initialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      children: [
        // Left Panel - Settings
        Expanded(
          flex: 1,
          child: Container(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // General Configuration
                  Text(
                    'GENERAL CONFIGURATION',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Bot Reply
                  Text(
                    'BOT REPLY',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _botReplyController,
                    maxLines: 4,
                    onChanged: (_) => _updateBotReply(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Bot Mode
                  Text(
                    'BOT MODE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _selectedBotMode,
                    isExpanded: true,
                    items: _botModes
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedBotMode = newValue;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  // Human Takeover Delay
                  Text(
                    'HUMAN TAKEOVER DELAY',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: _humanTakeoverDelay,
                    isExpanded: true,
                    items: ['5 minutes', '10 minutes', '15 minutes', '30 minutes']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _humanTakeoverDelay = newValue;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  // Timeout Message
                  Text(
                    'TIMEOUT MESSAGE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter timeout message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Show Powered by Branding
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Powered by Branding',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Switch(
                        value: _showPoweredByBranding,
                        onChanged: (bool value) {
                          setState(() {
                            _showPoweredByBranding = value;
                          });
                        },
                        activeColor: const Color(0xFF2563EB),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Branding Section - Compact
                  Text(
                    'BRANDING',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Avatar and Icons Row
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _uploadAvatar,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: _avatarPath != null
                                ? Text(
                                    _avatarPath!.substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 24,
                                    color: Colors.grey[400],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ...(_availableIcons.map((iconData) {
                        final isSelected = _selectedIcon == iconData['name'];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIcon = iconData['name'];
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isSelected ? _themeColor : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? _themeColor : Colors.grey[300]!,
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  iconData['icon'],
                                  size: 18,
                                  color: isSelected ? Colors.white : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Theme Color - Compact
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          children: [
                            _buildColorOption(const Color(0xFF2563EB), 'Blue'),
                            _buildColorOption(const Color(0xFF10B981), 'Green'),
                            _buildColorOption(const Color(0xFFEF4444), 'Red'),
                            _buildColorOption(const Color(0xFFF59E0B), 'Amber'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: _colorCodeController,
                          onChanged: _updateColorFromCode,
                          decoration: InputDecoration(
                            hintText: '#2563EB',
                            prefixText: '#',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 6,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Show Branding Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Branding',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Switch(
                        value: _showPoweredByBranding,
                        onChanged: (bool value) {
                          setState(() {
                            _showPoweredByBranding = value;
                          });
                        },
                        activeColor: const Color(0xFF2563EB),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // Right Panel - Preview
        Expanded(
          flex: 1,
          child: Container(
            color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'INTERACTIVE LIVE PREVIEW',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[600],
                        letterSpacing: 0.5,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'RESET',
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _themeColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: _avatarPath != null
                                      ? Text(
                                          _avatarPath!.substring(0, 1).toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        )
                                      : Icon(
                                          _getIconForSelected(),
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Customer Support',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListView.builder(
                              itemCount: _chatMessages.length,
                              itemBuilder: (context, index) {
                                final message = _chatMessages[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Align(
                                    alignment: message.isUser
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.4,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: message.isUser
                                            ? _themeColor
                                            : Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        message.text,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: message.isUser
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: TextField(
                            controller: _chatInputController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 13,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _themeColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onPressed: _sendUserMessage,
                                    padding: const EdgeInsets.all(4),
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser,
  });
}
