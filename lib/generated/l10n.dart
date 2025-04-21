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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `In Progress`
  String get in_progress {
    return Intl.message('In Progress', name: 'in_progress', desc: '', args: []);
  }

  /// `Approved`
  String get approved {
    return Intl.message('Approved', name: 'approved', desc: '', args: []);
  }

  /// `Pending Tasks`
  String get pendingTasks {
    return Intl.message(
      'Pending Tasks',
      name: 'pendingTasks',
      desc: '',
      args: [],
    );
  }

  /// `Approved Tasks`
  String get approvedTasks {
    return Intl.message(
      'Approved Tasks',
      name: 'approvedTasks',
      desc: '',
      args: [],
    );
  }

  /// `Task List`
  String get taskList {
    return Intl.message('Task List', name: 'taskList', desc: '', args: []);
  }

  /// `Not Assigned`
  String get notAssigned {
    return Intl.message(
      'Not Assigned',
      name: 'notAssigned',
      desc: '',
      args: [],
    );
  }

  /// `Assigned to you`
  String get assignedToYou {
    return Intl.message(
      'Assigned to you',
      name: 'assignedToYou',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Start Task`
  String get startTask {
    return Intl.message('Start Task', name: 'startTask', desc: '', args: []);
  }

  /// `Approve Task`
  String get approveTask {
    return Intl.message(
      'Approve Task',
      name: 'approveTask',
      desc: '',
      args: [],
    );
  }

  /// `Complete Task`
  String get completeTask {
    return Intl.message(
      'Complete Task',
      name: 'completeTask',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Task`
  String get cancelTask {
    return Intl.message('Cancel Task', name: 'cancelTask', desc: '', args: []);
  }

  /// `Please enter password`
  String get enterPassword {
    return Intl.message(
      'Please enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkYourEmail {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `A password reset link has been sent to your email address`
  String get resetPasswordLinkSent {
    return Intl.message(
      'A password reset link has been sent to your email address',
      name: 'resetPasswordLinkSent',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Send Reset Link`
  String get sendResetLink {
    return Intl.message(
      'Send Reset Link',
      name: 'sendResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Back to login`
  String get backToLogin {
    return Intl.message(
      'Back to login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Please enter email`
  String get enterEmail {
    return Intl.message(
      'Please enter email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email`
  String get enterValidEmail {
    return Intl.message(
      'Please enter valid email',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `forgot password?`
  String get forgotPassword {
    return Intl.message(
      'forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
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

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Leave empty to keep current`
  String get leaveEmptyToKeepCurrent {
    return Intl.message(
      'Leave empty to keep current',
      name: 'leaveEmptyToKeepCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Surname`
  String get surname {
    return Intl.message('Surname', name: 'surname', desc: '', args: []);
  }

  /// `Job`
  String get job {
    return Intl.message('Job', name: 'job', desc: '', args: []);
  }

  /// `Please enter name`
  String get enterName {
    return Intl.message(
      'Please enter name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Sur Name`
  String get surName {
    return Intl.message('Sur Name', name: 'surName', desc: '', args: []);
  }

  /// `Please enter surname`
  String get enterSurname {
    return Intl.message(
      'Please enter surname',
      name: 'enterSurname',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get enterPhone {
    return Intl.message(
      'Please enter phone number',
      name: 'enterPhone',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
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
      Locale.fromSubtags(languageCode: 'tr'),
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
