import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('nl')
  ];

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @mijnBots.
  ///
  /// In en, this message translates to:
  /// **'My Bots'**
  String get mijnBots;

  /// No description provided for @conversaties.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get conversaties;

  /// No description provided for @crmLeads.
  ///
  /// In en, this message translates to:
  /// **'CRM / Leads'**
  String get crmLeads;

  /// No description provided for @aiKnowledge.
  ///
  /// In en, this message translates to:
  /// **'AI & Knowledge'**
  String get aiKnowledge;

  /// No description provided for @integraties.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get integraties;

  /// No description provided for @instellingen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get instellingen;

  /// No description provided for @adminAccount.
  ///
  /// In en, this message translates to:
  /// **'Admin Account'**
  String get adminAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @nieuweBotButton.
  ///
  /// In en, this message translates to:
  /// **'New Bot'**
  String get nieuweBotButton;

  /// No description provided for @themeHammenga.
  ///
  /// In en, this message translates to:
  /// **'Theme: Hammenga'**
  String get themeHammenga;

  /// No description provided for @conversatiesCount.
  ///
  /// In en, this message translates to:
  /// **'CONVERSATIONS'**
  String get conversatiesCount;

  /// No description provided for @activieBotsCount.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE BOTS'**
  String get activieBotsCount;

  /// No description provided for @leadsCount.
  ///
  /// In en, this message translates to:
  /// **'LEADS'**
  String get leadsCount;

  /// No description provided for @avgResponse.
  ///
  /// In en, this message translates to:
  /// **'AVG. RESPONSE'**
  String get avgResponse;

  /// No description provided for @vsVorigeMaand.
  ///
  /// In en, this message translates to:
  /// **'vs previous month'**
  String get vsVorigeMaand;

  /// No description provided for @stabiel.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get stabiel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @conversatieVolume.
  ///
  /// In en, this message translates to:
  /// **'Conversation Volume'**
  String get conversatieVolume;

  /// No description provided for @topBots.
  ///
  /// In en, this message translates to:
  /// **'Top Bots'**
  String get topBots;

  /// No description provided for @bekijkAlleBots.
  ///
  /// In en, this message translates to:
  /// **'View all bots'**
  String get bekijkAlleBots;

  /// No description provided for @recenteActiviteit.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recenteActiviteit;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get exportCsv;

  /// No description provided for @tijd.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get tijd;

  /// No description provided for @gebruiker.
  ///
  /// In en, this message translates to:
  /// **'USER'**
  String get gebruiker;

  /// No description provided for @bot.
  ///
  /// In en, this message translates to:
  /// **'BOT'**
  String get bot;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'TYPE'**
  String get type;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'STATUS'**
  String get status;

  /// No description provided for @acties.
  ///
  /// In en, this message translates to:
  /// **'ACTIONS'**
  String get acties;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @voice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get voice;

  /// No description provided for @afgerond.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get afgerond;

  /// No description provided for @inGesprek.
  ///
  /// In en, this message translates to:
  /// **'In conversation'**
  String get inGesprek;

  /// No description provided for @handoff.
  ///
  /// In en, this message translates to:
  /// **'Handoff'**
  String get handoff;

  /// No description provided for @minGeleden.
  ///
  /// In en, this message translates to:
  /// **'min ago'**
  String get minGeleden;

  /// No description provided for @uurGeleden.
  ///
  /// In en, this message translates to:
  /// **'hour ago'**
  String get uurGeleden;

  /// No description provided for @berichten.
  ///
  /// In en, this message translates to:
  /// **'messages'**
  String get berichten;

  /// No description provided for @gesproken.
  ///
  /// In en, this message translates to:
  /// **'spoken'**
  String get gesproken;

  /// No description provided for @conversations.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get conversations;

  /// No description provided for @conversationHistory.
  ///
  /// In en, this message translates to:
  /// **'Conversation History'**
  String get conversationHistory;

  /// No description provided for @monitorAllInteractions.
  ///
  /// In en, this message translates to:
  /// **'Monitor all interactions handled by this bot.'**
  String get monitorAllInteractions;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'DATE & TIME'**
  String get dateTime;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'USER'**
  String get user;

  /// No description provided for @sentiment.
  ///
  /// In en, this message translates to:
  /// **'SENTIMENT'**
  String get sentiment;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'ACTION'**
  String get action;

  /// No description provided for @exportToCsv.
  ///
  /// In en, this message translates to:
  /// **'Export to CSV'**
  String get exportToCsv;

  /// No description provided for @exportToPdf.
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get exportToPdf;

  /// No description provided for @viewTranscript.
  ///
  /// In en, this message translates to:
  /// **'View Transcript'**
  String get viewTranscript;

  /// No description provided for @aiHandled.
  ///
  /// In en, this message translates to:
  /// **'AI HANDLED'**
  String get aiHandled;

  /// No description provided for @humanTakeover.
  ///
  /// In en, this message translates to:
  /// **'HUMAN TAKEOVER'**
  String get humanTakeover;

  /// No description provided for @positive.
  ///
  /// In en, this message translates to:
  /// **'POSITIVE'**
  String get positive;

  /// No description provided for @negative.
  ///
  /// In en, this message translates to:
  /// **'NEGATIVE'**
  String get negative;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'NEUTRAL'**
  String get neutral;

  /// No description provided for @integrations.
  ///
  /// In en, this message translates to:
  /// **'Integrations'**
  String get integrations;

  /// No description provided for @newIntegration.
  ///
  /// In en, this message translates to:
  /// **'New Integration'**
  String get newIntegration;

  /// No description provided for @googleWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Google Workspace'**
  String get googleWorkspace;

  /// No description provided for @automationWebhooks.
  ///
  /// In en, this message translates to:
  /// **'Automation Webhooks'**
  String get automationWebhooks;

  /// No description provided for @googleAppScriptUrl.
  ///
  /// In en, this message translates to:
  /// **'GOOGLE APP SCRIPT URL'**
  String get googleAppScriptUrl;

  /// No description provided for @googleSheetId.
  ///
  /// In en, this message translates to:
  /// **'GOOGLE SHEET ID'**
  String get googleSheetId;

  /// No description provided for @zapierWebhookUrl.
  ///
  /// In en, this message translates to:
  /// **'ZAPIER WEBHOOK URL'**
  String get zapierWebhookUrl;

  /// No description provided for @makeIntegrationWebhookUrl.
  ///
  /// In en, this message translates to:
  /// **'MAKE (INTEGROMAT) WEBHOOK URL'**
  String get makeIntegrationWebhookUrl;

  /// No description provided for @emailMarketing.
  ///
  /// In en, this message translates to:
  /// **'Email Marketing'**
  String get emailMarketing;

  /// No description provided for @mailchimpApiKey.
  ///
  /// In en, this message translates to:
  /// **'MAILCHIMP API KEY'**
  String get mailchimpApiKey;

  /// No description provided for @activeConnections.
  ///
  /// In en, this message translates to:
  /// **'Active Connections'**
  String get activeConnections;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// No description provided for @shopifyConnected.
  ///
  /// In en, this message translates to:
  /// **'Shopify Connected'**
  String get shopifyConnected;

  /// No description provided for @googleSheetsActive.
  ///
  /// In en, this message translates to:
  /// **'Google Sheets Active'**
  String get googleSheetsActive;

  /// No description provided for @reservationSystemApi.
  ///
  /// In en, this message translates to:
  /// **'Reservation System API'**
  String get reservationSystemApi;

  /// No description provided for @endpointUrl.
  ///
  /// In en, this message translates to:
  /// **'ENDPOINT URL'**
  String get endpointUrl;

  /// No description provided for @checkAvailabilityAutomatically.
  ///
  /// In en, this message translates to:
  /// **'Check Availability Automatically'**
  String get checkAvailabilityAutomatically;

  /// No description provided for @bookingConfirmations.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmations'**
  String get bookingConfirmations;

  /// No description provided for @sendAutomatedEmailOrSms.
  ///
  /// In en, this message translates to:
  /// **'Send automated email or SMS confirmations once a booking is finalized by the bot.'**
  String get sendAutomatedEmailOrSms;

  /// No description provided for @connectSmsGateway.
  ///
  /// In en, this message translates to:
  /// **'CONNECT SMS GATEWAY'**
  String get connectSmsGateway;

  /// No description provided for @shopifyDescription.
  ///
  /// In en, this message translates to:
  /// **'The bot can check order status and provide tracking links from your Shopify store.'**
  String get shopifyDescription;

  /// No description provided for @disconnectShopify.
  ///
  /// In en, this message translates to:
  /// **'DISCONNECT SHOPIFY'**
  String get disconnectShopify;

  /// No description provided for @connectWoocommerce.
  ///
  /// In en, this message translates to:
  /// **'CONNECT WOOCOMMERCE'**
  String get connectWoocommerce;

  /// No description provided for @availabilityRules.
  ///
  /// In en, this message translates to:
  /// **'Availability Rules'**
  String get availabilityRules;

  /// No description provided for @googleCalendarIntegration.
  ///
  /// In en, this message translates to:
  /// **'GOOGLE CALENDAR INTEGRATION'**
  String get googleCalendarIntegration;

  /// No description provided for @linkGSuiteCalendar.
  ///
  /// In en, this message translates to:
  /// **'Link G-Suite Calendar'**
  String get linkGSuiteCalendar;

  /// No description provided for @enableConflictDetection.
  ///
  /// In en, this message translates to:
  /// **'Enable Conflict Detection'**
  String get enableConflictDetection;

  /// No description provided for @smsGatewayApiKey.
  ///
  /// In en, this message translates to:
  /// **'SMS GATEWAY API KEY'**
  String get smsGatewayApiKey;

  /// No description provided for @shopifyApiKey.
  ///
  /// In en, this message translates to:
  /// **'SHOPIFY API KEY'**
  String get shopifyApiKey;

  /// No description provided for @shopifyAccessToken.
  ///
  /// In en, this message translates to:
  /// **'SHOPIFY ACCESS TOKEN'**
  String get shopifyAccessToken;

  /// No description provided for @woocommerceApiKey.
  ///
  /// In en, this message translates to:
  /// **'WOOCOMMERCE API KEY'**
  String get woocommerceApiKey;

  /// No description provided for @woocommerceApiSecret.
  ///
  /// In en, this message translates to:
  /// **'WOOCOMMERCE API SECRET'**
  String get woocommerceApiSecret;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @woocommerceDescription.
  ///
  /// In en, this message translates to:
  /// **'The bot can check product availability and manage orders from your WooCommerce store.'**
  String get woocommerceDescription;

  /// No description provided for @aiMode.
  ///
  /// In en, this message translates to:
  /// **'AI Mode'**
  String get aiMode;

  /// No description provided for @aiPersonality.
  ///
  /// In en, this message translates to:
  /// **'AI Personality'**
  String get aiPersonality;

  /// No description provided for @whoAreYou.
  ///
  /// In en, this message translates to:
  /// **'WHO ARE YOU?'**
  String get whoAreYou;

  /// No description provided for @toneOfVoice.
  ///
  /// In en, this message translates to:
  /// **'TONE-OF-VOICE'**
  String get toneOfVoice;

  /// No description provided for @botRolePromptContext.
  ///
  /// In en, this message translates to:
  /// **'BOT ROLE (PROMPT CONTEXT)'**
  String get botRolePromptContext;

  /// No description provided for @speechForm.
  ///
  /// In en, this message translates to:
  /// **'SPEECH FORM (FORMAL/INFORMAL)'**
  String get speechForm;

  /// No description provided for @creativity.
  ///
  /// In en, this message translates to:
  /// **'CREATIVITY (TEMPERATURE: 0.7)'**
  String get creativity;

  /// No description provided for @factual.
  ///
  /// In en, this message translates to:
  /// **'FACTUAL (0.0)'**
  String get factual;

  /// No description provided for @creative.
  ///
  /// In en, this message translates to:
  /// **'CREATIVE (1.0)'**
  String get creative;

  /// No description provided for @customerSupportExpert.
  ///
  /// In en, this message translates to:
  /// **'Customer Support Expert'**
  String get customerSupportExpert;

  /// No description provided for @professional.
  ///
  /// In en, this message translates to:
  /// **'Professional'**
  String get professional;

  /// No description provided for @enthusiastic.
  ///
  /// In en, this message translates to:
  /// **'Enthusiastic'**
  String get enthusiastic;

  /// No description provided for @empathetic.
  ///
  /// In en, this message translates to:
  /// **'Empathetic'**
  String get empathetic;

  /// No description provided for @businessCorporate.
  ///
  /// In en, this message translates to:
  /// **'Business / Corporate'**
  String get businessCorporate;

  /// No description provided for @analyticsDashboard.
  ///
  /// In en, this message translates to:
  /// **'Analytics Dashboard'**
  String get analyticsDashboard;

  /// No description provided for @totalChats.
  ///
  /// In en, this message translates to:
  /// **'TOTAL CHATS'**
  String get totalChats;

  /// No description provided for @activeBots.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE BOTS'**
  String get activeBots;

  /// No description provided for @leads.
  ///
  /// In en, this message translates to:
  /// **'LEADS'**
  String get leads;

  /// No description provided for @responseTime.
  ///
  /// In en, this message translates to:
  /// **'RESPONSE TIME'**
  String get responseTime;

  /// No description provided for @conversationVolume.
  ///
  /// In en, this message translates to:
  /// **'CONVERSATION VOLUME'**
  String get conversationVolume;

  /// No description provided for @topMostAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'TOP 5 MOST ASKED QUESTIONS'**
  String get topMostAskedQuestions;

  /// No description provided for @returnsWarranty.
  ///
  /// In en, this message translates to:
  /// **'Returns & Warranty'**
  String get returnsWarranty;

  /// No description provided for @orderStatusInquiry.
  ///
  /// In en, this message translates to:
  /// **'Order Status Inquiry'**
  String get orderStatusInquiry;

  /// No description provided for @scheduleRescheduleAppointment.
  ///
  /// In en, this message translates to:
  /// **'Schedule / Reschedule Appointment'**
  String get scheduleRescheduleAppointment;

  /// No description provided for @shippingCostInformation.
  ///
  /// In en, this message translates to:
  /// **'Shipping Cost Information'**
  String get shippingCostInformation;

  /// No description provided for @exportFullReport.
  ///
  /// In en, this message translates to:
  /// **'EXPORT FULL REPORT'**
  String get exportFullReport;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'nl': return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
