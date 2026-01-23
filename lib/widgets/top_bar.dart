import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import 'create_bot_dialog.dart';

class TopBar extends StatelessWidget {
  final String currentPage;

  const TopBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    final themeNames = {
      'hammenga': 'Theme: Hammenga',
      'eco_agency': 'Theme: Eco Agency',
      'creative': 'Theme: Creative',
    };

    // Check if user is admin
    final isAdmin = userProvider.userRole == 'admin';

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            // Breadcrumb
            Row(
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '>',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                Text(
                  currentPage,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            // Search Bar
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search bots, conversations or settings... [CMD+K]',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 18,
                      color: Colors.grey[500],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 24),
            // Right Actions
            Row(
              children: [
                // Theme Switcher
                PopupMenuButton<String>(
                  onSelected: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(value);
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'hammenga',
                      child: Row(
                        children: [
                          Icon(Icons.palette_outlined, size: 16),
                          SizedBox(width: 8),
                          Text('Theme: Hammenga'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'eco_agency',
                      child: Row(
                        children: [
                          Icon(Icons.palette_outlined, size: 16),
                          SizedBox(width: 8),
                          Text('Theme: Eco Agency'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'creative',
                      child: Row(
                        children: [
                          Icon(Icons.palette_outlined, size: 16),
                          SizedBox(width: 8),
                          Text('Theme: Creative'),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.palette_outlined,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          themeNames[themeProvider.selectedTheme] ?? 'Theme: Hammenga',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.expand_more,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Notifications
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),

                // Language Switcher
                PopupMenuButton<String>(
                  onSelected: (value) {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLanguage(value);
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'en',
                      child: Text('English'),
                    ),
                    const PopupMenuItem(
                      value: 'nl',
                      child: Text('Dutch'),
                    ),
                  ],
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: themeProvider.primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Text(
                          languageProvider.locale.languageCode.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.expand_more,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // System Status Indicator (only for admins)
                if (isAdmin)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'System: 98%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
