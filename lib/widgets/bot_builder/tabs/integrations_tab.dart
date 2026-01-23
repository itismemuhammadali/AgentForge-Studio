import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/theme_provider.dart';

class IntegrationsTab extends StatefulWidget {
  const IntegrationsTab({super.key});

  @override
  State<IntegrationsTab> createState() => _IntegrationsTabState();
}

class _IntegrationsTabState extends State<IntegrationsTab> {
  final TextEditingController _googleScriptUrlController = TextEditingController();
  final TextEditingController _googleSheetIdController = TextEditingController();
  final TextEditingController _zapierWebhookController = TextEditingController();
  final TextEditingController _makeWebhookController = TextEditingController();
  
  bool _shopifyConnected = true;
  bool _woocommerceConnected = false;
  bool _emailMarketingConnected = false;
  bool _bookingConfirmationsConnected = false;
  bool _googleWorkspaceConnected = false;
  bool _automationWebhooksConnected = false;
  bool _reservationSystemConnected = false;
  bool _availabilityRulesConnected = false;

  @override
  void dispose() {
    _googleScriptUrlController.dispose();
    _googleSheetIdController.dispose();
    _zapierWebhookController.dispose();
    _makeWebhookController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.integrations,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.newIntegration),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeProvider.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Active Connections - Full Width
            _buildActiveConnectionsCard(context, l10n),
            const SizedBox(height: 32),
            // First Row: Google Workspace and Automation Webhooks
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Google Workspace
                Expanded(
                  child: _buildIntegrationCard(
                    context,
                    icon: 'G',
                    iconColor: const Color(0xFF4285F4),
                    title: l10n.googleWorkspace,
                    isConnected: _googleWorkspaceConnected,
                    onConnectionChanged: (value) {
                      setState(() => _googleWorkspaceConnected = value);
                    },
                    fields: [
                      _buildTextField(
                        context,
                        label: l10n.googleAppScriptUrl,
                        controller: _googleScriptUrlController,
                        placeholder: 'https://script.google.com/macros/s/...',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        label: l10n.googleSheetId,
                        controller: _googleSheetIdController,
                        placeholder: 'e.g. 1aZb3c4d5e6F7g8h',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Automation Webhooks
                Expanded(
                  child: _buildIntegrationCard(
                    context,
                    icon: '⚡',
                    iconColor: const Color(0xFFFF6B35),
                    title: l10n.automationWebhooks,
                    isConnected: _automationWebhooksConnected,
                    onConnectionChanged: (value) {
                      setState(() => _automationWebhooksConnected = value);
                    },
                    fields: [
                      _buildTextField(
                        context,
                        label: l10n.zapierWebhookUrl,
                        controller: _zapierWebhookController,
                        placeholder: 'https://hooks.zapier.com/...',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        context,
                        label: l10n.makeIntegrationWebhookUrl,
                        controller: _makeWebhookController,
                        placeholder: 'http://hook.make.com/...',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Second Row: Email Marketing and Availability Rules
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email Marketing
                Expanded(
                  child: _buildEmailMarketingCard(context, l10n, _emailMarketingConnected, (value) {
                    setState(() => _emailMarketingConnected = value);
                  }),
                ),
                const SizedBox(width: 24),
                // Availability Rules
                Expanded(
                  child: _buildAvailabilityRulesCard(context, l10n),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Third Row: Reservation System API and Booking Confirmations
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Reservation System API
                Expanded(
                  child: _buildIntegrationCard(
                    context,
                    icon: '⊞',
                    iconColor: const Color(0xFF6366F1),
                    title: l10n.reservationSystemApi,
                    isConnected: _reservationSystemConnected,
                    onConnectionChanged: (value) {
                      setState(() => _reservationSystemConnected = value);
                    },
                    fields: [
                      _buildTextField(
                        context,
                        label: l10n.endpointUrl,
                        controller: TextEditingController(),
                        placeholder: 'https://api.yourbooking.com/v1',
                      ),
                      const SizedBox(height: 16),
                      _buildToggleField(
                        context,
                        label: l10n.checkAvailabilityAutomatically,
                        value: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Booking Confirmations
                Expanded(
                  child: _buildBookingConfirmationsCard(context, l10n, _bookingConfirmationsConnected, (value) {
                    setState(() => _bookingConfirmationsConnected = value);
                  }),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Fourth Row: Shopify and WooCommerce
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shopify
                Expanded(
                  child: _buildShopifyCard(context, l10n, _shopifyConnected, (value) {
                    setState(() => _shopifyConnected = value);
                  }),
                ),
                const SizedBox(width: 24),
                // WooCommerce
                Expanded(
                  child: _buildWoocommerceCard(context, l10n, _woocommerceConnected, (value) {
                    setState(() => _woocommerceConnected = value);
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailMarketingCard(BuildContext context, AppLocalizations l10n, bool isConnected, Function(bool) onConnectionChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.emailMarketing,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (isConnected)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.connected,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!isConnected)
            _buildTextField(
              context,
              label: l10n.mailchimpApiKey,
              controller: TextEditingController(),
              placeholder: 'e.g. abc123def456ghi789',
            ),
          if (!isConnected) const SizedBox(height: 16),
          _buildConnectButton(
            context,
            isConnected: isConnected,
            onPressed: () => onConnectionChanged(!isConnected),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationCard(
    BuildContext context, {
    required String icon,
    required Color iconColor,
    required String title,
    required List<Widget> fields,
    bool isConnected = false,
    Function(bool)? onConnectionChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    icon,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Fields
          ...fields,
          if (onConnectionChanged != null) ...[
            const SizedBox(height: 16),
            _buildConnectButton(
              context,
              isConnected: isConnected,
              onPressed: () => onConnectionChanged(!isConnected),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String placeholder,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey[400],
            ),
            filled: true,
            fillColor: isDark ? Colors.grey[900] : Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xFF2563EB),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildActiveConnectionsCard(BuildContext context, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Build list of connected integrations
    final connectedIntegrations = <Map<String, String>>[];
    
    if (_shopifyConnected) {
      connectedIntegrations.add({
        'title': l10n.shopifyConnected,
        'status': l10n.connected,
      });
    }
    if (_woocommerceConnected) {
      connectedIntegrations.add({
        'title': l10n.woocommerceDescription,
        'status': l10n.connected,
      });
    }
    if (_emailMarketingConnected) {
      connectedIntegrations.add({
        'title': l10n.emailMarketing,
        'status': l10n.connected,
      });
    }
    if (_bookingConfirmationsConnected) {
      connectedIntegrations.add({
        'title': l10n.bookingConfirmations,
        'status': l10n.connected,
      });
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.activeConnections,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          if (connectedIntegrations.isEmpty)
            Text(
              'No active connections',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            )
          else
            ...connectedIntegrations.asMap().entries.map((entry) {
              final index = entry.key;
              final integration = entry.value;
              final isLast = index == connectedIntegrations.length - 1;

              return Column(
                children: [
                  _buildConnectionItem(
                    context,
                    title: integration['title']!,
                    status: integration['status']!,
                    isDark: isDark,
                  ),
                  if (!isLast) const SizedBox(height: 12),
                ],
              );
            }),
        ],
      ),
    );
  }

  Widget _buildConnectionItem(
    BuildContext context, {
    required String title,
    required String status,
    required bool isDark,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFD1FAE5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF047857),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              l10n.disconnect,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFFDC2626),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectButton(
    BuildContext context, {
    required bool isConnected,
    required VoidCallback onPressed,
    String? connectText,
    String? disconnectText,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final buttonText = isConnected ? (disconnectText ?? l10n.disconnect) : (connectText ?? 'Connect');

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isConnected ? const Color(0xFFDC2626) : Provider.of<ThemeProvider>(context, listen: false).primaryColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleField(
    BuildContext context, {
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2563EB),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF2563EB),
        ),
      ],
    );
  }

  Widget _buildBookingConfirmationsCard(BuildContext context, AppLocalizations l10n, bool isConnected, Function(bool) onConnectionChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.bookingConfirmations,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.sendAutomatedEmailOrSms,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          if (!isConnected)
            _buildTextField(
              context,
              label: l10n.smsGatewayApiKey,
              controller: TextEditingController(),
              placeholder: 'e.g. sk_live_abc123def456',
            ),
          if (!isConnected) const SizedBox(height: 20),
          _buildConnectButton(
            context,
            isConnected: isConnected,
            onPressed: () => onConnectionChanged(!isConnected),
            connectText: l10n.connect,
          ),
        ],
      ),
    );
  }

  Widget _buildShopifyCard(BuildContext context, AppLocalizations l10n, bool isConnected, Function(bool) onConnectionChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF96C93D).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '🛍',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shopify',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (isConnected)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.connected,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.shopifyDescription,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          if (!isConnected) ...[
            _buildTextField(
              context,
              label: l10n.shopifyApiKey,
              controller: TextEditingController(),
              placeholder: 'e.g. shppa_abc123def456',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              context,
              label: l10n.shopifyAccessToken,
              controller: TextEditingController(),
              placeholder: 'e.g. shpat_abc123def456',
            ),
            const SizedBox(height: 16),
          ],
          _buildConnectButton(
            context,
            isConnected: isConnected,
            onPressed: () => onConnectionChanged(!isConnected),
          ),
        ],
      ),
    );
  }

  Widget _buildWoocommerceCard(BuildContext context, AppLocalizations l10n, bool isConnected, Function(bool) onConnectionChanged) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF96588A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '🏪',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'WooCommerce',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (isConnected)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        l10n.connected,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.woocommerceDescription,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          if (!isConnected) ...[
            _buildTextField(
              context,
              label: l10n.woocommerceApiKey,
              controller: TextEditingController(),
              placeholder: 'e.g. ck_abc123def456',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              context,
              label: l10n.woocommerceApiSecret,
              controller: TextEditingController(),
              placeholder: 'e.g. cs_abc123def456',
            ),
            const SizedBox(height: 16),
          ],
          _buildConnectButton(
            context,
            isConnected: isConnected,
            onPressed: () => onConnectionChanged(!isConnected),
            connectText: l10n.connect,
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityRulesCard(BuildContext context, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.availabilityRules,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.googleCalendarIntegration,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          if (!_availabilityRulesConnected)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.grey[400]!,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  l10n.linkGSuiteCalendar,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.enableConflictDetection,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Switch(
                value: false,
                onChanged: (value) {},
                activeColor: const Color(0xFF2563EB),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildConnectButton(
            context,
            isConnected: _availabilityRulesConnected,
            onPressed: () => setState(() => _availabilityRulesConnected = !_availabilityRulesConnected),
          ),
        ],
      ),
    );
  }
}
