import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class AIModeTab extends StatefulWidget {
  const AIModeTab({super.key});

  @override
  State<AIModeTab> createState() => _AIModeTabState();
}

class _AIModeTabState extends State<AIModeTab> {
  late String _selectedPersonality;
  late String _selectedTone;
  double _creativityValue = 0.7;
  bool _useFormalSpeech = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _selectedPersonality = l10n.customerSupportExpert;
    _selectedTone = l10n.professional;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              l10n.aiPersonality,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            // Who Are You and Tone of Voice - Side by Side
            Row(
              children: [
                // Who Are You Section (Left)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.whoAreYou,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[900] : Colors.grey[50],
                          border: Border.all(
                            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: TextField(
                          controller: TextEditingController(text: _selectedPersonality),
                          onChanged: (value) => setState(() => _selectedPersonality = value),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: l10n.customerSupportExpert,
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[400],
                            ),
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                // Tone of Voice Section (Right)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.toneOfVoice,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.grey[900] : Colors.grey[50],
                          border: Border.all(
                            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedTone,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: [l10n.professional, l10n.enthusiastic, l10n.empathetic, l10n.businessCorporate]
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() => _selectedTone = newValue);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Bot Role Section
            Text(
              l10n.botRolePromptContext,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.grey[50],
                border: Border.all(
                  color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:
                      'You are a helpful assistant for Hammenga.nl. Your primary goal is to assist customers with technical queries and lead generation.',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[400],
                  ),
                ),
                style: const TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(height: 24),

            // Speech Form Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.speechForm,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Informal',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _useFormalSpeech ? Colors.grey[600] : const Color(0xFF2563EB),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Switch(
                      value: _useFormalSpeech,
                      onChanged: (value) => setState(() => _useFormalSpeech = value),
                      activeColor: const Color(0xFF2563EB),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Formal',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _useFormalSpeech ? const Color(0xFF2563EB) : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Creativity Section
            Text(
              l10n.creativity,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  l10n.factual,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 6,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 12,
                      ),
                    ),
                    child: Slider(
                      value: _creativityValue,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      activeColor: const Color(0xFF2563EB),
                      inactiveColor: Colors.grey[300],
                      onChanged: (value) {
                        setState(() => _creativityValue = value);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.creative,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
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
