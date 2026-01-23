import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bot_builder_provider.dart';
import '../widgets/create_bot_dialog.dart';

class AdminBotGalleryScreen extends StatefulWidget {
  final Function(String)? onNavigate;

  const AdminBotGalleryScreen({Key? key, this.onNavigate}) : super(key: key);

  @override
  State<AdminBotGalleryScreen> createState() => _AdminBotGalleryScreenState();
}

class _AdminBotGalleryScreenState extends State<AdminBotGalleryScreen> {
  final List<Map<String, dynamic>> templates = [
    {
      'name': 'Restaurant Starter',
      'description': 'Reservations & Menu Flow Pre-configured',
      'icon': '🍕',
      'isLive': true,
      'isDraft': false,
    },
    {
      'name': 'Webshop Pro',
      'description': 'Order Tracking & Shopify Integration Ready',
      'icon': '🛒',
      'isLive': true,
      'isDraft': false,
    },
    {
      'name': 'Healthcare Lite',
      'description': 'Appointments & Medical FAQ Logic',
      'icon': '📱',
      'isLive': false,
      'isDraft': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Template Gallery Management',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manage bot templates and pre-built configurations',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _showCreateTemplateDialog(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Create New Template'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Templates Grid
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 2.2,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              return _buildTemplateCard(context, isDark, template);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateCard(
    BuildContext context,
    bool isDark,
    Map<String, dynamic> template,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Opening ${template['name']}...'),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Icon and Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon with background
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          template['icon'],
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    // Toggle Button
                    Transform.scale(
                      scale: 0.75,
                      child: Switch(
                        value: template['isLive'],
                        onChanged: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${template['name']} is now ${value ? 'LIVE' : 'STOPPED'}',
                              ),
                            ),
                          );
                        },
                        activeColor: const Color(0xFF10B981),
                        inactiveThumbColor: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Name
                Text(
                  template['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),

                // Description
                Text(
                  template['description'],
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),

                // Bottom Row: Status and Edit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: template['isLive']
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        template['isLive'] ? 'LIVE' : 'STOPPED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: template['isLive']
                              ? const Color(0xFF10B981)
                              : Colors.grey[600],
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    // Edit Link
                    GestureDetector(
                      onTap: () {
                        // Set the flow name and navigate to bot builder
                        Provider.of<BotBuilderProvider>(context, listen: false)
                            .setFlowName(template['name']);
                        widget.onNavigate?.call('/bot-builder');
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 16,
                            color: const Color(0xFF2563EB),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2563EB),
                              letterSpacing: 0.5,
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
        ),
      ),
    );
  }

  void _showCreateTemplateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreateBotDialog(),
    );
  }
}
