import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class Sidebar extends StatefulWidget {
  final String currentRoute;
  final Function(String) onNavigate;
  final bool isExpanded;
  final Function(bool) onToggle;
  final String userRole; // 'client' or 'admin'
  final String? firstName;
  final String? lastName;

  const Sidebar({
    Key? key,
    required this.currentRoute,
    required this.onNavigate,
    this.isExpanded = true,
    required this.onToggle,
    this.userRole = 'client',
    this.firstName,
    this.lastName,
  }) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String get _initials {
    final firstName = widget.firstName ?? 'G';
    final lastName = widget.lastName ?? 'H';
    final firstInitial = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final lastInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }

  String get _displayName {
    final firstName = widget.firstName ?? 'Gerald';
    final lastName = widget.lastName ?? 'Hendrix';
    final lastNameInitial = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$firstName $lastNameInitial.';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final expandedWidth = 250.0;
    final collapsedWidth = 92.0;
    final isExpanded = widget.isExpanded ?? true;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      width: isExpanded ? expandedWidth : collapsedWidth,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Column(
        children: [
          // Logo with Toggle Button
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            child: isExpanded
                ? Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: themeProvider.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'H',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Hammenga.nl',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => widget.onToggle(!isExpanded),
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.chevron_left,
                              size: 20,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: themeProvider.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'H',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => widget.onToggle(!isExpanded),
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const Divider(height: 1, thickness: 1),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // COMMAND Section (Admin Only)
                  if (widget.userRole == 'admin') ...[
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                        child: Text(
                          'COMMAND',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                    _buildNavItem(
                      context,
                      icon: Icons.dashboard_outlined,
                      label: 'Dashboard',
                      route: '/admin-dashboard',
                      isActive: widget.currentRoute == '/admin-dashboard',
                      isExpanded: isExpanded,
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.people_outline,
                      label: 'Users & Clients',
                      route: '/admin-users',
                      isActive: widget.currentRoute == '/admin-users',
                      isExpanded: isExpanded,
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.security_outlined,
                      label: 'Hard Limits (Plans)',
                      route: '/admin-limits',
                      isActive: widget.currentRoute == '/admin-limits',
                      isExpanded: isExpanded,
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.smart_toy_outlined,
                      label: 'Bot Gallery',
                      route: '/admin-bots',
                      isActive: widget.currentRoute == '/admin-bots',
                      isExpanded: isExpanded,
                    ),
                    if (isExpanded) const SizedBox(height: 20),
                    // SYSTEM Section (Admin Only)
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          'SYSTEM',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                    _buildNavItem(
                      context,
                      icon: Icons.settings_outlined,
                      label: 'Configuration',
                      route: '/admin-config',
                      isActive: widget.currentRoute == '/admin-config',
                      isExpanded: isExpanded,
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.history_outlined,
                      label: 'Audit Logs',
                      route: '/admin-logs',
                      isActive: widget.currentRoute == '/admin-logs',
                      isExpanded: isExpanded,
                    ),
                  ] else ...[
                    // PLATFORM Section (Client Only)
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                        child: Text(
                          'PLATFORM',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                    _buildNavItem(
                      context,
                      icon: Icons.dashboard_outlined,
                      label: 'Dashboard',
                      route: '/dashboard',
                      isActive: widget.currentRoute == '/dashboard',
                      isExpanded: isExpanded,
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.smart_toy_outlined,
                      label: 'My Bots',
                      route: '/bots',
                      isActive: widget.currentRoute == '/bots',
                      isExpanded: isExpanded,
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.chat_bubble_outline,
                      label: 'Conversations',
                      route: '/conversations',
                      isActive: widget.currentRoute == '/conversations',
                      badge: '0',
                      isExpanded: isExpanded,
                    ),
                    _buildNavItem(
                      context,
                      icon: Icons.analytics_outlined,
                      label: 'Analytics',
                      route: '/analytics',
                      isActive: widget.currentRoute == '/analytics',
                      isExpanded: isExpanded,
                    ),
                    if (isExpanded) const SizedBox(height: 20),
                    // CONFIGURATION Section (Client Only)
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          'CONFIGURATION',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                    _buildNavItem(
                      context,
                      icon: Icons.extension_outlined,
                      label: 'Integrations',
                      route: '/integrations',
                      isActive: widget.currentRoute == '/integrations',
                      isExpanded: isExpanded,
                    ),
                    if (isExpanded) const SizedBox(height: 20),
                    // HELP Section (Client Only)
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: Text(
                          'HELP',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      )
                    else
                      const SizedBox(height: 12),
                    _buildNavItem(
                      context,
                      icon: Icons.help_outline,
                      label: 'Help',
                      route: '/help',
                      isActive: widget.currentRoute == '/help',
                      isExpanded: isExpanded,
                    ),
                  ],
                ],
              ),
            ),
          ),
          // User Profile
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widget.onNavigate('/profile'),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: widget.userRole == 'admin'
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              _initials,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                widget.userRole == 'admin'
                                    ? 'Root Access'
                                    : 'Enterprise Account',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: widget.userRole == 'admin'
                                      ? const Color(0xFFEF4444)
                                      : Colors.grey[600],
                                  fontWeight: widget.userRole == 'admin'
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.userRole == 'admin'
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    _initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isActive,
    required bool isExpanded,
    String? badge,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onNavigate(route),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isActive
                  ? themeProvider.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: isExpanded
                ? Row(
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isActive ? themeProvider.primaryColor : Colors.grey[600],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                            color: isActive ? themeProvider.primaryColor : Colors.grey[700],
                          ),
                        ),
                      ),
                      if (badge != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: themeProvider.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              badge,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 20,
                        color: isActive ? themeProvider.primaryColor : Colors.grey[600],
                      ),
                      if (badge != null)
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: themeProvider.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              badge,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
