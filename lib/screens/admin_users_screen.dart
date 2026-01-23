import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({Key? key}) : super(key: key);

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'all';

  final List<Map<String, dynamic>> users = [
    {
      'name': 'Healthcare Amsterdam',
      'email': 'contact@healthcare.nl',
      'plan': 'PREMIUM PLAN',
      'planColor': const Color(0xFF7C3AED),
      'status': 'ACTIVE',
      'statusColor': const Color(0xFF10B981),
    },
    {
      'name': 'DigitalX Marketing Agency',
      'email': 'contact@digitalx.agency',
      'plan': 'AGENCY PLAN',
      'planColor': const Color(0xFF7C3AED),
      'status': 'ACTIVE',
      'statusColor': const Color(0xFF10B981),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
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
                'Account & Client Control',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage all users and client accounts',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Search and Create Button
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search clients, plans or logs...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF2563EB),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Create new account dialog
                  _showCreateAccountDialog(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Create New Account'),
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

          // Section Title
          const Text(
            'User & Client Management',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),

          // Table
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
              ),
            ),
            child: Column(
              children: [
                // Table Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'CLIENT / USER',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'ASSIGNED PLAN',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'STATUS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'ADMINISTRATIVE ACTIONS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[600],
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Table Rows
                ...users.map((user) => _buildUserRow(user, isDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRow(Map<String, dynamic> user, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user['email'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: user['planColor'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                user['plan'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: user['planColor'],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: user['statusColor'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                user['status'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: user['statusColor'],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('LOGIN AS CLIENT', Colors.blue),
                _buildActionButton('OVERWRITE PW', Colors.orange),
                _buildActionButton('Edit', Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color color) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label clicked')),
        );
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  void _showCreateAccountDialog(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final companyNameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    String selectedPlan = 'LITE PLAN';
    String selectedType = 'ENTERPRISE ACCOUNT';
    bool agreeToTerms = false;
    bool showPassword = false;
    bool showConfirmPassword = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final primaryColor = Theme.of(context).colorScheme.primary;
          final surfaceColor = Theme.of(context).colorScheme.surface;
          final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
          
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Container(
              width: 650,
              height: 800,
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Create New Account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('Add a new client or admin account to the platform', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.9))),
                      ],
                    ),
                  ),
                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(children: [Expanded(child: _buildField('ACCOUNT TYPE', DropdownButtonFormField<String>(value: selectedType, decoration: _inputDecoration(isDark, primaryColor), items: const [DropdownMenuItem(value: 'ENTERPRISE ACCOUNT', child: Text('Enterprise Account')), DropdownMenuItem(value: 'ADMIN ACCOUNT', child: Text('Admin Account'))], onChanged: (v) => setState(() => selectedType = v ?? 'ENTERPRISE ACCOUNT')))), const SizedBox(width: 16), Expanded(child: _buildField('PLAN', DropdownButtonFormField<String>(value: selectedPlan, decoration: _inputDecoration(isDark, primaryColor), items: const [DropdownMenuItem(value: 'LITE PLAN', child: Text('Lite Plan')), DropdownMenuItem(value: 'PREMIUM PLAN', child: Text('Premium Plan')), DropdownMenuItem(value: 'AGENCY PLAN', child: Text('Agency Plan'))], onChanged: (v) => setState(() => selectedPlan = v ?? 'LITE PLAN'))))]),
                          const SizedBox(height: 16),
                          _buildField('COMPANY NAME', TextField(controller: companyNameController, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'Enter company name'))),
                          const SizedBox(height: 16),
                          Row(children: [Expanded(child: _buildField('FIRST NAME', TextField(controller: firstNameController, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'First name')))), const SizedBox(width: 16), Expanded(child: _buildField('LAST NAME', TextField(controller: lastNameController, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'Last name'))))]),
                          const SizedBox(height: 16),
                          Row(children: [Expanded(child: _buildField('USERNAME', TextField(controller: usernameController, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'Username')))), const SizedBox(width: 16), Expanded(child: _buildField('EMAIL', TextField(controller: emailController, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'Email address'))))]),
                          const SizedBox(height: 16),
                          _buildField('PHONE', TextField(controller: phoneController, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'Phone number'))),
                          const SizedBox(height: 16),
                          Row(children: [Expanded(child: _buildField('PASSWORD', TextField(controller: passwordController, obscureText: !showPassword, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'Password', suffixIcon: IconButton(icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off, size: 18), onPressed: () => setState(() => showPassword = !showPassword)))))), const SizedBox(width: 16), Expanded(child: _buildField('CONFIRM PASSWORD', TextField(controller: confirmPasswordController, obscureText: !showConfirmPassword, decoration: _inputDecoration(isDark, primaryColor).copyWith(hintText: 'Confirm password', suffixIcon: IconButton(icon: Icon(showConfirmPassword ? Icons.visibility : Icons.visibility_off, size: 18), onPressed: () => setState(() => showConfirmPassword = !showConfirmPassword))))))]),
                          const SizedBox(height: 16),
                          Row(children: [Checkbox(value: agreeToTerms, onChanged: (v) => setState(() => agreeToTerms = v ?? false), activeColor: primaryColor), const Expanded(child: Text('I agree to the Terms and Conditions', style: TextStyle(fontSize: 12)))]),
                        ],
                      ),
                    ),
                  ),
                  // Footer
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: isDark ? Colors.grey[800]! : Colors.grey[200]!))),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: primaryColor))), const SizedBox(width: 12), ElevatedButton(onPressed: agreeToTerms ? () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Account for ${companyNameController.text} created successfully!'))); } : null, style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), child: const Text('Create Account'))]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(String label, Widget field) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey[600], letterSpacing: 0.5)), const SizedBox(height: 8), field]);
  }

  InputDecoration _inputDecoration(bool isDark, Color primaryColor) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: primaryColor, width: 2)),
      filled: true,
      fillColor: isDark ? Colors.grey[900] : Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }
}
