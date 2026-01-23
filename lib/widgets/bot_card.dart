import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dashboard_models.dart';
import '../providers/theme_provider.dart';

class BotCard extends StatelessWidget {
  final Bot bot;
  final VoidCallback onTap;
  final bool isSelected;
  final Function(String)? onNavigate;

  const BotCard({
    Key? key,
    required this.bot,
    required this.onTap,
    required this.isSelected,
    this.onNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isSelected
              ? themeProvider.primaryColor
              : (isDark ? const Color(0xFF3A3A3A) : const Color(0xFFE5E7EB)),
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row: Icon, Status, Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF3A3A3A) : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    bot.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              // Status and Toggle
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: bot.isActive
                          ? const Color(0xFFD1FAE5)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      bot.isActive ? 'ACTIVE' : 'INACTIVE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: bot.isActive
                            ? const Color(0xFF059669)
                            : Colors.grey[600],
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Toggle switch
                  SizedBox(
                    width: 36,
                    height: 20,
                    child: Switch(
                      value: bot.isActive,
                      onChanged: (_) {
                        // Toggle will be handled by provider
                      },
                      activeThumbColor: Colors.white,
                      activeTrackColor: const Color(0xFF2563EB),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Bot name
          Text(
            bot.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          // Mode badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE9D5FF),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              bot.mode,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7C3AED),
                letterSpacing: 0.3,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONVERSATIONS',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    bot.conversations.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'LAST ACTIVITY',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    bot.lastActivity,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Manage Bot button
          SizedBox(
            width: double.infinity,
            child: _ManageBotButton(onTap: onTap, onNavigate: onNavigate),
          ),
        ],
      ),
    );
  }
}

class _ManageBotButton extends StatefulWidget {
  final VoidCallback onTap;
  final Function(String)? onNavigate;

  const _ManageBotButton({required this.onTap, this.onNavigate});

  @override
  State<_ManageBotButton> createState() => _ManageBotButtonState();
}

class _ManageBotButtonState extends State<_ManageBotButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        if (!_isHovered) {
          setState(() => _isHovered = true);
        }
      },
      onPointerDown: (event) {
        widget.onNavigate?.call('/bot-builder');
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFF2563EB) : Colors.white,
            border: Border.all(
              color: const Color(0xFF2563EB),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'MANAGE BOT',
              style: TextStyle(
                color: _isHovered ? Colors.white : const Color(0xFF2563EB),
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
