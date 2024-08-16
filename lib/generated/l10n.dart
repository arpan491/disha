// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hi welcome`
  String get welcomeText {
    return Intl.message(
      'hi welcome',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Hi Satyam`
  String get hiSatyam {
    return Intl.message(
      'Hi Satyam',
      name: 'hiSatyam',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get myAccount {
    return Intl.message(
      'My Account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Report An Issue`
  String get reportIssue {
    return Intl.message(
      'Report An Issue',
      name: 'reportIssue',
      desc: '',
      args: [],
    );
  }

  /// `App Guide`
  String get appGuide {
    return Intl.message(
      'App Guide',
      name: 'appGuide',
      desc: '',
      args: [],
    );
  }

  /// `Ask a Query`
  String get askAQuery {
    return Intl.message(
      'Ask a Query',
      name: 'askAQuery',
      desc: '',
      args: [],
    );
  }

  /// `Talk to Expert`
  String get talkToExpert {
    return Intl.message(
      'Talk to Expert',
      name: 'talkToExpert',
      desc: '',
      args: [],
    );
  }

  /// `Talk to Expert`
  String get talkToExpert2 {
    return Intl.message(
      'Talk to Expert',
      name: 'talkToExpert2',
      desc: '',
      args: [],
    );
  }

  /// `Connect in Offline Mode`
  String get connectOffline {
    return Intl.message(
      'Connect in Offline Mode',
      name: 'connectOffline',
      desc: '',
      args: [],
    );
  }

  /// `Connect in Offline Mode`
  String get connectOffline2 {
    return Intl.message(
      'Connect in Offline Mode',
      name: 'connectOffline2',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No`
  String get mob {
    return Intl.message(
      'Mobile No',
      name: 'mob',
      desc: '',
      args: [],
    );
  }

  /// `Change Plan`
  String get changePlan {
    return Intl.message(
      'Change Plan',
      name: 'changePlan',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePwd {
    return Intl.message(
      'Change Password',
      name: 'changePwd',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Facing issues with the app?`
  String get appIssue {
    return Intl.message(
      'Facing issues with the app?',
      name: 'appIssue',
      desc: '',
      args: [],
    );
  }

  /// `Facing issues with the Expert?`
  String get expertIssue {
    return Intl.message(
      'Facing issues with the Expert?',
      name: 'expertIssue',
      desc: '',
      args: [],
    );
  }

  /// `Explain your problem here`
  String get explainProb {
    return Intl.message(
      'Explain your problem here',
      name: 'explainProb',
      desc: '',
      args: [],
    );
  }

  /// `Expert ID`
  String get expertID {
    return Intl.message(
      'Expert ID',
      name: 'expertID',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Type a message`
  String get msgType {
    return Intl.message(
      'Type a message',
      name: 'msgType',
      desc: '',
      args: [],
    );
  }

  /// `Experts Near You`
  String get expertNearYou {
    return Intl.message(
      'Experts Near You',
      name: 'expertNearYou',
      desc: '',
      args: [],
    );
  }

  /// `Experts Near You`
  String get expertNearYou2 {
    return Intl.message(
      'Experts Near You',
      name: 'expertNearYou2',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Domain`
  String get domain {
    return Intl.message(
      'Domain',
      name: 'domain',
      desc: '',
      args: [],
    );
  }

  /// `Language Preferences`
  String get langPref {
    return Intl.message(
      'Language Preferences',
      name: 'langPref',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Language Settings`
  String get langsett {
    return Intl.message(
      'Language Settings',
      name: 'langsett',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get chooseLang {
    return Intl.message(
      'Choose Language',
      name: 'chooseLang',
      desc: '',
      args: [],
    );
  }

  /// `Profile Settings`
  String get profSett {
    return Intl.message(
      'Profile Settings',
      name: 'profSett',
      desc: '',
      args: [],
    );
  }

  /// `Chat Room`
  String get chatRoom {
    return Intl.message(
      'Chat Room',
      name: 'chatRoom',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
