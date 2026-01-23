import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  late TextEditingController _searchController;

  final List<Map<String, String>> faqs = [
    {
      'category': 'getting-started',
      'question': 'How do I create my first bot?',
      'answer': 'To create your first bot, click the "New Bot" button in the top right corner. Fill in the bot name, description, and select your preferred AI model. Then click "Create Bot" to get started.',
    },
    {
      'category': 'getting-started',
      'question': 'What AI models are available?',
      'answer': 'We support GPT-4, GPT-3.5 Turbo, Claude 3 Opus, and Claude 3 Sonnet. Each model has different capabilities and pricing. Choose based on your needs.',
    },
    {
      'category': 'getting-started',
      'question': 'Can I customize my bot\'s behavior?',
      'answer': 'Yes! You can customize your bot through the Bot Builder. Set up conversation flows, add training data, configure integrations, and adjust AI settings.',
    },
    {
      'category': 'conversations',
      'question': 'How do I view conversation history?',
      'answer': 'Go to the Conversations tab to see all conversations. You can filter by status, search for specific conversations, and view detailed chat history.',
    },
    {
      'category': 'conversations',
      'question': 'Can I export conversations?',
      'answer': 'Yes, you can export conversations in CSV or JSON format. Select the conversations you want to export and click the export button.',
    },
    {
      'category': 'analytics',
      'question': 'What metrics are tracked in Analytics?',
      'answer': 'We track interactions, session duration, user retention, error rates, engagement metrics, and user satisfaction scores.',
    },
    {
      'category': 'analytics',
      'question': 'How often is analytics data updated?',
      'answer': 'Analytics data is updated in real-time. You can view live metrics and historical data for any time period.',
    },
    {
      'category': 'integrations',
      'question': 'How do I connect an integration?',
      'answer': 'Go to Integrations, find the service you want to connect, and click "Connect". Follow the authentication steps and authorize the connection.',
    },
    {
      'category': 'integrations',
      'question': 'Which integrations are available?',
      'answer': 'We support Shopify, Slack, Google Sheets, Zapier, Stripe, HubSpot, Mailchimp, Twilio, and many more. Check the Integrations page for the full list.',
    },
    {
      'category': 'billing',
      'question': 'How is billing calculated?',
      'answer': 'Billing is based on the number of conversations and API calls. You can view detailed billing information in your account settings.',
    },
    {
      'category': 'billing',
      'question': 'Can I upgrade or downgrade my plan?',
      'answer': 'Yes, you can change your plan anytime. Changes take effect at the start of your next billing cycle.',
    },
    {
      'category': 'support',
      'question': 'How do I contact support?',
      'answer': 'You can reach our support team via email at support@hammenga.nl or through the chat widget on our website.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final filteredFaqs = faqs.where((faq) {
      final matchesSearch = faq['question']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq['answer']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'all' || faq['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            'Help & Support',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Find answers to common questions and get support.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

          // Quick Links
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            children: [
              _buildQuickLink(
                context,
                icon: Icons.book_outlined,
                label: 'Documentation',
                themeProvider: themeProvider,
              ),
              _buildQuickLink(
                context,
                icon: Icons.video_library_outlined,
                label: 'Video Tutorials',
                themeProvider: themeProvider,
              ),
              _buildQuickLink(
                context,
                icon: Icons.mail_outline,
                label: 'Contact Support',
                themeProvider: themeProvider,
              ),
              _buildQuickLink(
                context,
                icon: Icons.bug_report_outlined,
                label: 'Report Issue',
                themeProvider: themeProvider,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Search and Filter
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search help articles...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
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
          const SizedBox(height: 24),

          // Category Filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryButton('All', 'all', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Getting Started', 'getting-started', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Conversations', 'conversations', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Analytics', 'analytics', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Integrations', 'integrations', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Billing', 'billing', themeProvider, isDark),
                const SizedBox(width: 8),
                _buildCategoryButton('Support', 'support', themeProvider, isDark),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // FAQ List
          Column(
            children: filteredFaqs.isEmpty
                ? [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your search or filter criteria',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                : List.generate(
                    filteredFaqs.length,
                    (index) => _buildFaqItem(
                      context,
                      faq: filteredFaqs[index],
                      isDark: isDark,
                      themeProvider: themeProvider,
                    ),
                  ),
          ),
          const SizedBox(height: 32),

          // Contact Support Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: themeProvider.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: themeProvider.primaryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Still need help?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Our support team is here to help. Contact us via email or live chat.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.mail_outline, size: 16),
                      label: const Text('Email Support'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_outlined, size: 16),
                      label: const Text('Live Chat'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: themeProvider.primaryColor,
                        side: BorderSide(color: themeProvider.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLink(
    BuildContext context, {
    required IconData icon,
    required String label,
    required ThemeProvider themeProvider,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 32,
                color: themeProvider.primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
    String label,
    String value,
    ThemeProvider themeProvider,
    bool isDark,
  ) {
    final isActive = _selectedCategory == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? themeProvider.primaryColor
              : (isDark ? const Color(0xFF2A2A2A) : Colors.grey[100]),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive
                ? themeProvider.primaryColor
                : (isDark ? Colors.grey[700]! : Colors.grey[300]!),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(
    BuildContext context, {
    required Map<String, String> faq,
    required bool isDark,
    required ThemeProvider themeProvider,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            faq['question']!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                faq['answer']!,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
