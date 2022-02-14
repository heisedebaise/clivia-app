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

  /// `Clivia`
  String get title {
    return Intl.message(
      'Clivia',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `http post failure !`
  String get httpFailure {
    return Intl.message(
      'http post failure !',
      name: 'httpFailure',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get me {
    return Intl.message(
      'Me',
      name: 'me',
      desc: '',
      args: [],
    );
  }

  /// `Unset`
  String get unset {
    return Intl.message(
      'Unset',
      name: 'unset',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
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

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Crop`
  String get pictureCrop {
    return Intl.message(
      'Crop',
      name: 'pictureCrop',
      desc: '',
      args: [],
    );
  }

  /// `Failed to crop picture`
  String get pictureCropFail {
    return Intl.message(
      'Failed to crop picture',
      name: 'pictureCropFail',
      desc: '',
      args: [],
    );
  }

  /// `Flip`
  String get pictureFlip {
    return Intl.message(
      'Flip',
      name: 'pictureFlip',
      desc: '',
      args: [],
    );
  }

  /// `Rotate Left`
  String get pictureRotateLeft {
    return Intl.message(
      'Rotate Left',
      name: 'pictureRotateLeft',
      desc: '',
      args: [],
    );
  }

  /// `Rotate Right`
  String get pictureRotateRight {
    return Intl.message(
      'Rotate Right',
      name: 'pictureRotateRight',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get pictureReset {
    return Intl.message(
      'Reset',
      name: 'pictureReset',
      desc: '',
      args: [],
    );
  }

  /// `Use the camera to take pictures`
  String get pictureCamera {
    return Intl.message(
      'Use the camera to take pictures',
      name: 'pictureCamera',
      desc: '',
      args: [],
    );
  }

  /// `Select from album`
  String get pictureAlbum {
    return Intl.message(
      'Select from album',
      name: 'pictureAlbum',
      desc: '',
      args: [],
    );
  }

  /// `Failed to upload picture`
  String get pictureUploadFail {
    return Intl.message(
      'Failed to upload picture',
      name: 'pictureUploadFail',
      desc: '',
      args: [],
    );
  }

  /// `New version found`
  String get upgraderNewer {
    return Intl.message(
      'New version found',
      name: 'upgraderNewer',
      desc: '',
      args: [],
    );
  }

  /// `Update Now`
  String get upgraderForward {
    return Intl.message(
      'Update Now',
      name: 'upgraderForward',
      desc: '',
      args: [],
    );
  }

  /// `Next Reminder`
  String get upgraderCancel {
    return Intl.message(
      'Next Reminder',
      name: 'upgraderCancel',
      desc: '',
      args: [],
    );
  }

  /// `Please draw a gesture password`
  String get passwordGestureNew {
    return Intl.message(
      'Please draw a gesture password',
      name: 'passwordGestureNew',
      desc: '',
      args: [],
    );
  }

  /// `Please draw gesture password again`
  String get passwordGestureRepeat {
    return Intl.message(
      'Please draw gesture password again',
      name: 'passwordGestureRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get passwordInputNew {
    return Intl.message(
      'Please enter a password',
      name: 'passwordInputNew',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password again`
  String get passwordInputRepeat {
    return Intl.message(
      'Please enter the password again',
      name: 'passwordInputRepeat',
      desc: '',
      args: [],
    );
  }

  /// `The two passwords are inconsistent`
  String get passwordNotEquals {
    return Intl.message(
      'The two passwords are inconsistent',
      name: 'passwordNotEquals',
      desc: '',
      args: [],
    );
  }

  /// `Connect at least `
  String get passwordGestureMinPrefix {
    return Intl.message(
      'Connect at least ',
      name: 'passwordGestureMinPrefix',
      desc: '',
      args: [],
    );
  }

  /// ` points`
  String get passwordGestureMinSuffix {
    return Intl.message(
      ' points',
      name: 'passwordGestureMinSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Enter at least `
  String get passwordInputMinPrefix {
    return Intl.message(
      'Enter at least ',
      name: 'passwordInputMinPrefix',
      desc: '',
      args: [],
    );
  }

  /// ` characters`
  String get passwordInputMinSuffix {
    return Intl.message(
      ' characters',
      name: 'passwordInputMinSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get passwordStandard {
    return Intl.message(
      'Standard',
      name: 'passwordStandard',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get passwordAdvanced {
    return Intl.message(
      'Advanced',
      name: 'passwordAdvanced',
      desc: '',
      args: [],
    );
  }

  /// `Professional`
  String get passwordProfessional {
    return Intl.message(
      'Professional',
      name: 'passwordProfessional',
      desc: '',
      args: [],
    );
  }

  /// `Digit`
  String get passwordDigit {
    return Intl.message(
      'Digit',
      name: 'passwordDigit',
      desc: '',
      args: [],
    );
  }

  /// `Text`
  String get passwordText {
    return Intl.message(
      'Text',
      name: 'passwordText',
      desc: '',
      args: [],
    );
  }

  /// `Please set a nickname`
  String get meSignNickEmpty {
    return Intl.message(
      'Please set a nickname',
      name: 'meSignNickEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get meSignInfo {
    return Intl.message(
      'Personal Information',
      name: 'meSignInfo',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get meSignAvatar {
    return Intl.message(
      'Avatar',
      name: 'meSignAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Change Avatar`
  String get meSignAvatarChange {
    return Intl.message(
      'Change Avatar',
      name: 'meSignAvatarChange',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get meSignNick {
    return Intl.message(
      'Nickname',
      name: 'meSignNick',
      desc: '',
      args: [],
    );
  }

  /// `Change Nickname`
  String get meSignNickChange {
    return Intl.message(
      'Change Nickname',
      name: 'meSignNickChange',
      desc: '',
      args: [],
    );
  }

  /// `A personalized nickname can make it easier for your friends to remember you`
  String get meSignNickChangeMemo {
    return Intl.message(
      'A personalized nickname can make it easier for your friends to remember you',
      name: 'meSignNickChangeMemo',
      desc: '',
      args: [],
    );
  }

  /// `Gesture Password`
  String get meSignGesture {
    return Intl.message(
      'Gesture Password',
      name: 'meSignGesture',
      desc: '',
      args: [],
    );
  }

  /// `Enable gesture password`
  String get meSignGestureOn {
    return Intl.message(
      'Enable gesture password',
      name: 'meSignGestureOn',
      desc: '',
      args: [],
    );
  }

  /// `Turn off gesture password`
  String get meSignGestureOff {
    return Intl.message(
      'Turn off gesture password',
      name: 'meSignGestureOff',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get meSignMobile {
    return Intl.message(
      'Mobile',
      name: 'meSignMobile',
      desc: '',
      args: [],
    );
  }

  /// `Change Mobile`
  String get meSignMobileChange {
    return Intl.message(
      'Change Mobile',
      name: 'meSignMobileChange',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get meSignEmail {
    return Intl.message(
      'Email',
      name: 'meSignEmail',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get meSignEmailChange {
    return Intl.message(
      'Change Email',
      name: 'meSignEmailChange',
      desc: '',
      args: [],
    );
  }

  /// `QR Code Business Card`
  String get meSignQrCode {
    return Intl.message(
      'QR Code Business Card',
      name: 'meSignQrCode',
      desc: '',
      args: [],
    );
  }

  /// `I have read and agree to the Privacy Policy`
  String get meSignUpAgree {
    return Intl.message(
      'I have read and agree to the Privacy Policy',
      name: 'meSignUpAgree',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get meSignUp {
    return Intl.message(
      'Sign Up',
      name: 'meSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get meSignIn {
    return Intl.message(
      'Sign In',
      name: 'meSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the gesture password`
  String get meSignInGesture {
    return Intl.message(
      'Please enter the gesture password',
      name: 'meSignInGesture',
      desc: '',
      args: [],
    );
  }

  /// `Retreat safely`
  String get meSignOut {
    return Intl.message(
      'Retreat safely',
      name: 'meSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username`
  String get meSignUsername {
    return Intl.message(
      'Please enter your username',
      name: 'meSignUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password`
  String get meSignPassword {
    return Intl.message(
      'Please enter the password',
      name: 'meSignPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the password again`
  String get meSignPasswordRepeat {
    return Intl.message(
      'Please enter the password again',
      name: 'meSignPasswordRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get meSignPasswordForget {
    return Intl.message(
      'Forgot password',
      name: 'meSignPasswordForget',
      desc: '',
      args: [],
    );
  }

  /// `Take a personal nickname`
  String get meSignNickNew {
    return Intl.message(
      'Take a personal nickname',
      name: 'meSignNickNew',
      desc: '',
      args: [],
    );
  }

  /// `Register a new account`
  String get meSignToUp {
    return Intl.message(
      'Register a new account',
      name: 'meSignToUp',
      desc: '',
      args: [],
    );
  }

  /// `I already have an account`
  String get meSignToIn {
    return Intl.message(
      'I already have an account',
      name: 'meSignToIn',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get meLanguage {
    return Intl.message(
      'Language',
      name: 'meLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select your language`
  String get meLanguageSelect {
    return Intl.message(
      'Select your language',
      name: 'meLanguageSelect',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get meSettings {
    return Intl.message(
      'Settings',
      name: 'meSettings',
      desc: '',
      args: [],
    );
  }

  /// `Automatically lock screen`
  String get meSettingsLockScreen {
    return Intl.message(
      'Automatically lock screen',
      name: 'meSettingsLockScreen',
      desc: '',
      args: [],
    );
  }

  /// `Enable automatic screen lock`
  String get meSettingsLockScreenOn {
    return Intl.message(
      'Enable automatic screen lock',
      name: 'meSettingsLockScreenOn',
      desc: '',
      args: [],
    );
  }

  /// `Turn off automatic screen lock`
  String get meSettingsLockScreenOff {
    return Intl.message(
      'Turn off automatic screen lock',
      name: 'meSettingsLockScreenOff',
      desc: '',
      args: [],
    );
  }

  /// `Lock screen password`
  String get meSettingsLockScreenPassword {
    return Intl.message(
      'Lock screen password',
      name: 'meSettingsLockScreenPassword',
      desc: '',
      args: [],
    );
  }

  /// `Lock screen password error`
  String get meSettingsLockScreenFailure {
    return Intl.message(
      'Lock screen password error',
      name: 'meSettingsLockScreenFailure',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get meSettingsDark {
    return Intl.message(
      'Dark mode',
      name: 'meSettingsDark',
      desc: '',
      args: [],
    );
  }

  /// `The interface is mainly black, which helps to save power and reduce the damage of light to the eyes`
  String get meSettingsDarkExplain {
    return Intl.message(
      'The interface is mainly black, which helps to save power and reduce the damage of light to the eyes',
      name: 'meSettingsDarkExplain',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get meFeedback {
    return Intl.message(
      'Feedback',
      name: 'meFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Your comments and suggestions are very important to us, thank you very much for your support!`
  String get meFeedbackMemo {
    return Intl.message(
      'Your comments and suggestions are very important to us, thank you very much for your support!',
      name: 'meFeedbackMemo',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get meVersion {
    return Intl.message(
      'Version',
      name: 'meVersion',
      desc: '',
      args: [],
    );
  }

  /// `Go to update`
  String get meVersionForward {
    return Intl.message(
      'Go to update',
      name: 'meVersionForward',
      desc: '',
      args: [],
    );
  }

  /// `Upload Log`
  String get meUploadLog {
    return Intl.message(
      'Upload Log',
      name: 'meUploadLog',
      desc: '',
      args: [],
    );
  }

  /// `The uploaded log is only used to find bugs and will be deleted immediately after troubleshooting. Thank you very much for your support!`
  String get meUploadLogMemo {
    return Intl.message(
      'The uploaded log is only used to find bugs and will be deleted immediately after troubleshooting. Thank you very much for your support!',
      name: 'meUploadLogMemo',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get mePrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'mePrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get meAboutUs {
    return Intl.message(
      'About Us',
      name: 'meAboutUs',
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
      Locale.fromSubtags(languageCode: 'zh'),
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
