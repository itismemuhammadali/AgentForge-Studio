import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/language_provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/bot_builder_provider.dart';
import 'providers/bots_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/my_bots_screen.dart';
import 'screens/bot_builder_screen.dart';
import 'screens/conversations_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/integrations_screen.dart';
import 'screens/help_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/admin_login_screen.dart';
import 'screens/admin_signup_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/admin_users_screen.dart';
import 'screens/admin_hard_limits_screen.dart';
import 'screens/admin_bot_gallery_screen.dart';
import 'screens/admin_configuration_screen.dart';
import 'screens/admin_audit_logs_screen.dart';
import 'screens/admin_profile_screen.dart';
import 'widgets/sidebar.dart';
import 'widgets/top_bar.dart';
import 'dart:html' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => BotBuilderProvider()),
        ChangeNotifierProvider(create: (_) => BotsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return MaterialApp(
            title: 'AI Model Booking Platform',
            locale: languageProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('nl'),
            ],
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.light,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFA855F7),
                brightness: Brightness.light,
              ),
              scaffoldBackgroundColor: const Color(0xFFF9FAFB),
              appBarTheme: const AppBarTheme(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFFA855F7),
                brightness: Brightness.dark,
              ),
              scaffoldBackgroundColor: const Color(0xFF0F0F0F),
            ),
            themeMode: ThemeMode.light,
            home: const AdminPortal(),
          );
        },
      ),
    );
  }
}

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  String _currentRoute = '/login';
  String _currentPage = 'Login';
  bool _sidebarExpanded = false;
  bool _isLoggedIn = false;
  final List<String> _navigationHistory = ['/login'];
  int _historyIndex = 0;

  @override
  void initState() {
    super.initState();
    // Listen to browser back/forward button
    html.window.onPopState.listen((event) {
      _handleBrowserNavigation();
    });
  }

  void _handleBrowserNavigation() {
    // Get the current URL path
    final path = html.window.location.pathname ?? '/';
    // Extract route from path (e.g., /dashboard from /dashboard)
    final route = path.contains('/') ? path.split('/').last : path;
    final routePath = route.isEmpty ? '/dashboard' : '/$route';
    
    // Navigate to the route from browser history
    _navigateTo(routePath);
  }

  void _navigateTo(String route) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    setState(() {
      _currentRoute = route;
      
      // Update browser URL
      html.window.history.pushState(null, '', route);
      
      switch (route) {
        case '/login':
          _currentPage = 'Login';
          _isLoggedIn = false;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/signup':
          _currentPage = 'Sign Up';
          _isLoggedIn = false;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/admin-login':
          _currentPage = 'Admin Login';
          _isLoggedIn = false;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/admin-signup':
          _currentPage = 'Admin Sign Up';
          _isLoggedIn = false;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/dashboard':
          _currentPage = 'Dashboard';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/admin-dashboard':
          _currentPage = 'Admin Dashboard';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/admin-users':
          _currentPage = 'Users & Clients';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/admin-limits':
          _currentPage = 'Hard Limits (Plans)';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/admin-bots':
          _currentPage = 'Bot Gallery';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/admin-config':
          _currentPage = 'Configuration';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/admin-logs':
          _currentPage = 'Audit Logs';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Admin', lastName: 'Hammenga', userRole: 'admin');
          break;
        case '/bots':
          _currentPage = 'My Bots';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/conversations':
          _currentPage = 'Conversations';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/analytics':
          _currentPage = 'Analytics';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/integrations':
          _currentPage = 'Integrations';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/help':
          _currentPage = 'Help';
          _isLoggedIn = true;
          userProvider.setUserInfo(firstName: 'Gerald', lastName: 'Hendrix', userRole: 'client');
          break;
        case '/profile':
          _currentPage = 'Profile';
          _isLoggedIn = true;
          break;
        case '/bot-builder':
          _currentPage = 'Bot Builder';
          _isLoggedIn = true;
          break;
        default:
          _currentPage = 'Dashboard';
          _isLoggedIn = true;
      }
    });
  }

  void _toggleSidebar(bool expanded) {
    setState(() {
      _sidebarExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    // Show login/signup screens if not logged in
    if (!_isLoggedIn) {
      return Scaffold(
        body: _buildAuthContent(),
      );
    }

    // Show main app if logged in
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Sidebar(
            currentRoute: _currentRoute,
            onNavigate: _navigateTo,
            isExpanded: _sidebarExpanded,
            onToggle: _toggleSidebar,
            userRole: userProvider.userRole,
            firstName: userProvider.firstName,
            lastName: userProvider.lastName,
          ),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Bar
                TopBar(currentPage: _currentPage),
                // Content
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthContent() {
    switch (_currentRoute) {
      case '/signup':
        return SignupScreen(onNavigate: _navigateTo);
      case '/admin-login':
        return AdminLoginScreen(onNavigate: _navigateTo);
      case '/admin-signup':
        return AdminSignupScreen(onNavigate: _navigateTo);
      case '/login':
      default:
        return LoginScreen(onNavigate: _navigateTo);
    }
  }

  Widget _buildContent() {
    final userProvider = Provider.of<UserProvider>(context);
    
    switch (_currentRoute) {
      case '/dashboard':
        return const DashboardScreen();
      case '/admin-dashboard':
        return const AdminDashboardScreen();
      case '/admin-users':
        return const AdminUsersScreen();
      case '/admin-limits':
        return const AdminHardLimitsScreen();
      case '/admin-bots':
        return AdminBotGalleryScreen(onNavigate: _navigateTo);
      case '/admin-config':
        return const AdminConfigurationScreen();
      case '/admin-logs':
        return const AdminAuditLogsScreen();
      case '/profile':
        return userProvider.userRole == 'admin'
            ? const AdminProfileScreen()
            : const ProfileScreen();
      case '/bots':
        return MyBotsScreen(onNavigate: _navigateTo);
      case '/bot-builder':
        return BotBuilderScreen(onNavigate: _navigateTo);
      case '/conversations':
        return const ConversationsScreen();
      case '/analytics':
        return const AnalyticsScreen();
      case '/integrations':
        return const IntegrationsScreen();
      case '/help':
        return const HelpScreen();
      default:
        return const DashboardScreen();
    }
  }
}
