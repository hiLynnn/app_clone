import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_vi.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
    Locale('vi'),
  ];

  /// No description provided for @findYourHome.
  ///
  /// In en, this message translates to:
  /// **'Findddddd'**
  String get findYourHome;

  /// No description provided for @footer_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get footer_search;

  /// No description provided for @footer_nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get footer_nearby;

  /// No description provided for @footer_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get footer_home;

  /// No description provided for @footer_board.
  ///
  /// In en, this message translates to:
  /// **'Board'**
  String get footer_board;

  /// No description provided for @footer_mypage.
  ///
  /// In en, this message translates to:
  /// **'My Page'**
  String get footer_mypage;

  /// No description provided for @quick_menu.
  ///
  /// In en, this message translates to:
  /// **'Quick Menu'**
  String get quick_menu;

  /// No description provided for @hotPropertiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommended Properties'**
  String get hotPropertiesTitle;

  /// No description provided for @search_title.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_title;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @location_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Select Hanoi, Ho Chi Minh, Danang...'**
  String get location_placeholder;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @category_buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get category_buy;

  /// No description provided for @category_rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get category_rent;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @search_button.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_button;

  /// No description provided for @search_failed.
  ///
  /// In en, this message translates to:
  /// **'Search failed'**
  String get search_failed;

  /// No description provided for @select_location_warning.
  ///
  /// In en, this message translates to:
  /// **'Please select a location'**
  String get select_location_warning;

  /// No description provided for @location_danang.
  ///
  /// In en, this message translates to:
  /// **'Danang'**
  String get location_danang;

  /// No description provided for @location_hcm.
  ///
  /// In en, this message translates to:
  /// **'Ho Chi Minh City'**
  String get location_hcm;

  /// No description provided for @location_hanoi.
  ///
  /// In en, this message translates to:
  /// **'Hanoi'**
  String get location_hanoi;

  /// No description provided for @property_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get property_land;

  /// No description provided for @property_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get property_apartment;

  /// No description provided for @property_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get property_villa;

  /// No description provided for @property_officetel.
  ///
  /// In en, this message translates to:
  /// **'Officetel'**
  String get property_officetel;

  /// No description provided for @search_result_title.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get search_result_title;

  /// No description provided for @search_no_result.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get search_no_result;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'My Page'**
  String get profile_title;

  /// No description provided for @profile_username.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get profile_username;

  /// No description provided for @profile_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profile_email;

  /// No description provided for @profile_edit_info.
  ///
  /// In en, this message translates to:
  /// **'Edit Information'**
  String get profile_edit_info;

  /// No description provided for @profile_edit_info_sub.
  ///
  /// In en, this message translates to:
  /// **'Modify profile'**
  String get profile_edit_info_sub;

  /// No description provided for @profile_inbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get profile_inbox;

  /// No description provided for @profile_inbox_sub.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get profile_inbox_sub;

  /// No description provided for @profile_contract.
  ///
  /// In en, this message translates to:
  /// **'Contract Info'**
  String get profile_contract;

  /// No description provided for @profile_contract_sub.
  ///
  /// In en, this message translates to:
  /// **'Contract details'**
  String get profile_contract_sub;

  /// No description provided for @profile_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profile_logout;

  /// No description provided for @profile_logout_sub.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profile_logout_sub;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ko', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ko':
      return AppLocalizationsKo();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
