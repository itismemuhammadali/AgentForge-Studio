import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bots_provider.dart';
import '../providers/bot_builder_provider.dart';
import '../widgets/bot_card.dart';

class MyBotsScreen extends StatelessWidget {
  final Function(String)? onNavigate;

  const MyBotsScreen({Key? key, this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BotsProvider>(
      builder: (context, botsProvider, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Bots',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage and monitor your specific AI agents.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // First Bot Card
              if (botsProvider.bots.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 320,
                        height: 240,
                        child: BotCard(
                          bot: botsProvider.bots[0],
                          isSelected: botsProvider.selectedBot?.id == botsProvider.bots[0].id,
                          onTap: () => botsProvider.selectBot(botsProvider.bots[0]),
                          onNavigate: onNavigate,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              // Full width border
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 24),
              // Start from Template section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Start from Template',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Restaurant
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<BotBuilderProvider>(context, listen: false)
                                .setFlowName('Restaurant');
                            onNavigate?.call('/bot-builder');
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 24),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '🍕',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Restaurant',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Reservations & Menu info',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Webshop
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<BotBuilderProvider>(context, listen: false)
                                .setFlowName('Webshop');
                            onNavigate?.call('/bot-builder');
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '🛒',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Webshop',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Order tracking & FAQs',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Healthcare
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<BotBuilderProvider>(context, listen: false)
                                .setFlowName('Healthcare');
                            onNavigate?.call('/bot-builder');
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 24),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '📱',
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Healthcare',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Appointment scheduling',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
