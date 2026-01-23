import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';

class AITrainingTab extends StatefulWidget {
  const AITrainingTab({Key? key}) : super(key: key);

  @override
  State<AITrainingTab> createState() => _AITrainingTabState();
}

class _AITrainingTabState extends State<AITrainingTab> {
  final List<IndexedItem> _indexedItems = [
    IndexedItem(name: 'Handbook_2025.pdf', type: 'document'),
    IndexedItem(name: 'hammenga.nl/faq', type: 'url'),
  ];
  late TextEditingController _urlController;
  late TextEditingController _guidanceController;
  late TextEditingController _savedGuidanceController;
  bool _isEditingGuidance = false;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController();
    _guidanceController = TextEditingController();
    _savedGuidanceController = TextEditingController();
    _isEditingGuidance = false;
  }

  @override
  void dispose() {
    _urlController.dispose();
    _guidanceController.dispose();
    _savedGuidanceController.dispose();
    super.dispose();
  }

  void _deleteItem(int index) {
    setState(() {
      _indexedItems.removeAt(index);
    });
  }

  void _crawlUrl() {
    if (_urlController.text.isNotEmpty) {
      setState(() {
        _indexedItems.add(
          IndexedItem(name: _urlController.text, type: 'url'),
        );
        _urlController.clear();
      });
    }
  }

  void _saveGuidance() {
    setState(() {
      _savedGuidanceController.text = _guidanceController.text;
      _isEditingGuidance = false;
    });
  }

  void _editGuidance() {
    setState(() {
      _guidanceController.text = _savedGuidanceController.text;
      _isEditingGuidance = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row - Learn from Sources and Currently Indexed
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Learn from Sources Card (60% width)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with title
                        Text(
                          'Learn from Sources',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Upload Knowledge Documents Card
                        GestureDetector(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['pdf', 'docx', 'txt'],
                            );
                            if (result != null) {
                              setState(() {
                                _indexedItems.add(
                                  IndexedItem(
                                    name: result.files.single.name,
                                    type: 'document',
                                  ),
                                );
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF2563EB),
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.description_outlined,
                                  size: 44,
                                  color: const Color(0xFF2563EB),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Upload Knowledge Documents',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'PDF, DOCX, TXT (MAX 50MB)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Divider
                        Container(
                          height: 1,
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                        ),
                        const SizedBox(height: 20),
                        // URL Crawling Section
                        Text(
                          'CRAWL WEBSITE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _urlController,
                                decoration: InputDecoration(
                                  hintText: 'https://yourwebsite.com/help-center',
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
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _crawlUrl,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeProvider.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Crawl URL',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Divider
                        Container(
                          height: 1,
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                        ),
                        const SizedBox(height: 20),
                        // Manual Conversational Guidance Section
                        Text(
                          'CONVERSATIONAL GUIDANCE',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _guidanceController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'e.g. Always be polite, don\'t mention competitors, and suggest the pricing page if asked about costs.',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey[300]!,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveGuidance,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeProvider.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Save Guidance',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Currently Indexed Card (40% width)
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Currently Indexed',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Documents Section
                            if (_indexedItems.where((i) => i.type == 'document').isNotEmpty) ...[
                              Text(
                                'DOCUMENTS',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ..._indexedItems
                                  .asMap()
                                  .entries
                                  .where((e) => e.value.type == 'document')
                                  .map((e) {
                                final index = e.key;
                                final item = e.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF2563EB),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text(
                                          'Sync',
                                          style: TextStyle(
                                            color: Color(0xFF2563EB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      TextButton(
                                        onPressed: () => _deleteItem(index),
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Color(0xFFEF4444),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              const SizedBox(height: 16),
                            ],
                            // Links Section
                            if (_indexedItems.where((i) => i.type == 'url').isNotEmpty) ...[
                              Text(
                                'LINKS',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ..._indexedItems
                                  .asMap()
                                  .entries
                                  .where((e) => e.value.type == 'url')
                                  .map((e) {
                                final index = e.key;
                                final item = e.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF2563EB),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text(
                                          'Sync',
                                          style: TextStyle(
                                            color: Color(0xFF2563EB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      TextButton(
                                        onPressed: () => _deleteItem(index),
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Color(0xFFEF4444),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                            if (_indexedItems.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 32),
                                  child: Text(
                                    'No items indexed yet',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Conversational Guidance Card
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Conversational Guidance',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                if (_savedGuidanceController.text.isNotEmpty)
                                  TextButton(
                                    onPressed: _editGuidance,
                                    child: const Text(
                                      'Edit',
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
                            _savedGuidanceController.text.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 24),
                                      child: Text(
                                        'No guidance added yet',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[50],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      _savedGuidanceController.text,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isDark ? Colors.white : Colors.black87,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class IndexedItem {
  final String name;
  final String type; // 'document' or 'url'

  IndexedItem({
    required this.name,
    required this.type,
  });
}
