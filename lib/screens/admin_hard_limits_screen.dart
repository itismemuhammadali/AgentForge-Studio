import 'package:flutter/material.dart';

class AdminHardLimitsScreen extends StatefulWidget {
  const AdminHardLimitsScreen({Key? key}) : super(key: key);

  @override
  State<AdminHardLimitsScreen> createState() => _AdminHardLimitsScreenState();
}

class _AdminHardLimitsScreenState extends State<AdminHardLimitsScreen> {
  final _litePlanBotsController = TextEditingController(text: '1');
  final _litePlanResponsesController = TextEditingController(text: '500');
  final _litePlanTokensController = TextEditingController(text: '50000');

  final _premiumPlanBotsController = TextEditingController(text: '5');
  final _premiumPlanResponsesController = TextEditingController(text: '5000');
  final _premiumPlanTokensController = TextEditingController(text: '1000000');

  final _agencyPlanBotsController = TextEditingController(text: 'UNLIMITED');
  final _agencyPlanSeatsController = TextEditingController(text: '25');

  @override
  void dispose() {
    _litePlanBotsController.dispose();
    _litePlanResponsesController.dispose();
    _litePlanTokensController.dispose();
    _premiumPlanBotsController.dispose();
    _premiumPlanResponsesController.dispose();
    _premiumPlanTokensController.dispose();
    _agencyPlanBotsController.dispose();
    _agencyPlanSeatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Technical Hard Limits',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Configure plan limits and restrictions',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Plans Grid
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lite Plan
              Expanded(
                child: _buildPlanCard(
                  context,
                  isDark,
                  title: 'Lite Plan Limits',
                  tier: 'Tier 1',
                  fields: [
                    {
                      'label': 'MAXIMUM BOTS',
                      'controller': _litePlanBotsController,
                    },
                    {
                      'label': 'MONTHLY RESPONSES',
                      'controller': _litePlanResponsesController,
                    },
                    {
                      'label': 'TOKEN HARD LIMIT',
                      'controller': _litePlanTokensController,
                    },
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Premium Plan
              Expanded(
                child: _buildPlanCard(
                  context,
                  isDark,
                  title: 'Premium Plan Limits',
                  tier: 'Tier 2',
                  fields: [
                    {
                      'label': 'MAXIMUM BOTS',
                      'controller': _premiumPlanBotsController,
                    },
                    {
                      'label': 'MONTHLY RESPONSES',
                      'controller': _premiumPlanResponsesController,
                    },
                    {
                      'label': 'TOKEN HARD LIMIT',
                      'controller': _premiumPlanTokensController,
                    },
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Agency Plan
              Expanded(
                child: _buildPlanCard(
                  context,
                  isDark,
                  title: 'Agency Plan Limits',
                  tier: 'Tier 3',
                  fields: [
                    {
                      'label': 'MAXIMUM BOTS',
                      'controller': _agencyPlanBotsController,
                      'readOnly': true,
                    },
                    {
                      'label': 'TEAM SEATS (USERS)',
                      'controller': _agencyPlanSeatsController,
                    },
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    bool isDark, {
    required String title,
    required String tier,
    required List<Map<String, dynamic>> fields,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Tier
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tier,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Fields
          ...fields.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> field = entry.value;
            bool isLast = index == fields.length - 1;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  field['label'],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: field['controller'],
                  readOnly: field['readOnly'] ?? false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF2563EB),
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: isDark
                        ? Colors.grey[900]
                        : Colors.grey[50],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
                if (!isLast) const SizedBox(height: 16),
              ],
            );
          }).toList(),

          const SizedBox(height: 24),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$title saved successfully!'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'SAVE HARD LIMITS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
