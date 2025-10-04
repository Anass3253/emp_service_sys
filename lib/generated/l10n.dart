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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enterYourPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter your ID`
  String get enterYourId {
    return Intl.message(
      'Enter your ID',
      name: 'enterYourId',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Id is required`
  String get idRequired {
    return Intl.message(
      'Id is required',
      name: 'idRequired',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcome {
    return Intl.message('Welcome back', name: 'welcome', desc: '', args: []);
  }

  /// `Your Dashboard`
  String get yourDashboard {
    return Intl.message(
      'Your Dashboard',
      name: 'yourDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `About Me`
  String get aboutMe {
    return Intl.message('About Me', name: 'aboutMe', desc: '', args: []);
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `Overview`
  String get overviewTitle {
    return Intl.message('Overview', name: 'overviewTitle', desc: '', args: []);
  }

  /// `Private Information`
  String get privateInformation {
    return Intl.message(
      'Private Information',
      name: 'privateInformation',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get department {
    return Intl.message('Department', name: 'department', desc: '', args: []);
  }

  /// `Job Position`
  String get jobPositionLowerCase {
    return Intl.message(
      'Job Position',
      name: 'jobPositionLowerCase',
      desc: '',
      args: [],
    );
  }

  /// `Coach`
  String get coach {
    return Intl.message('Coach', name: 'coach', desc: '', args: []);
  }

  /// `Working Hours`
  String get workingHours {
    return Intl.message(
      'Working Hours',
      name: 'workingHours',
      desc: '',
      args: [],
    );
  }

  /// `Work Address`
  String get workAddress {
    return Intl.message(
      'Work Address',
      name: 'workAddress',
      desc: '',
      args: [],
    );
  }

  /// `Work Location`
  String get workLocation {
    return Intl.message(
      'Work Location',
      name: 'workLocation',
      desc: '',
      args: [],
    );
  }

  /// `Work Mobile`
  String get workMobile {
    return Intl.message('Work Mobile', name: 'workMobile', desc: '', args: []);
  }

  /// `Work Phone`
  String get workPhone {
    return Intl.message('Work Phone', name: 'workPhone', desc: '', args: []);
  }

  /// `PRIVATE CONTACT`
  String get privateContact {
    return Intl.message(
      'PRIVATE CONTACT',
      name: 'privateContact',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Home-Work Distance`
  String get homeWorkDistance {
    return Intl.message(
      'Home-Work Distance',
      name: 'homeWorkDistance',
      desc: '',
      args: [],
    );
  }

  /// `JOB POSITION`
  String get jobPosition {
    return Intl.message(
      'JOB POSITION',
      name: 'jobPosition',
      desc: '',
      args: [],
    );
  }

  /// `Certificate Level`
  String get certificateLevel {
    return Intl.message(
      'Certificate Level',
      name: 'certificateLevel',
      desc: '',
      args: [],
    );
  }

  /// `Field of Study`
  String get fieldOfStudy {
    return Intl.message(
      'Field of Study',
      name: 'fieldOfStudy',
      desc: '',
      args: [],
    );
  }

  /// `School`
  String get school {
    return Intl.message('School', name: 'school', desc: '', args: []);
  }

  /// `WORK PERMIT`
  String get workPermit {
    return Intl.message('WORK PERMIT', name: 'workPermit', desc: '', args: []);
  }

  /// `Visa No`
  String get visaNo {
    return Intl.message('Visa No', name: 'visaNo', desc: '', args: []);
  }

  /// `Work Permit No`
  String get workPermitNo {
    return Intl.message(
      'Work Permit No',
      name: 'workPermitNo',
      desc: '',
      args: [],
    );
  }

  /// `Visa Expire Date`
  String get visaExpireDate {
    return Intl.message(
      'Visa Expire Date',
      name: 'visaExpireDate',
      desc: '',
      args: [],
    );
  }

  /// `Work Permit Expiration Date`
  String get workPermitExpirationDate {
    return Intl.message(
      'Work Permit Expiration Date',
      name: 'workPermitExpirationDate',
      desc: '',
      args: [],
    );
  }

  /// `FAMILY STATUS`
  String get familyStatus {
    return Intl.message(
      'FAMILY STATUS',
      name: 'familyStatus',
      desc: '',
      args: [],
    );
  }

  /// `Marital Status`
  String get maritalStatus {
    return Intl.message(
      'Marital Status',
      name: 'maritalStatus',
      desc: '',
      args: [],
    );
  }

  /// `Number of Dependent Children`
  String get dependentChildren {
    return Intl.message(
      'Number of Dependent Children',
      name: 'dependentChildren',
      desc: '',
      args: [],
    );
  }

  /// `EMERGENCY`
  String get emergency {
    return Intl.message('EMERGENCY', name: 'emergency', desc: '', args: []);
  }

  /// `Contact Name`
  String get contactName {
    return Intl.message(
      'Contact Name',
      name: 'contactName',
      desc: '',
      args: [],
    );
  }

  /// `Contact Phone`
  String get contactPhone {
    return Intl.message(
      'Contact Phone',
      name: 'contactPhone',
      desc: '',
      args: [],
    );
  }

  /// `CITIZENSHIP`
  String get citizenship {
    return Intl.message('CITIZENSHIP', name: 'citizenship', desc: '', args: []);
  }

  /// `Nationality (Country)`
  String get nationality {
    return Intl.message(
      'Nationality (Country)',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Identification No`
  String get identificationNo {
    return Intl.message(
      'Identification No',
      name: 'identificationNo',
      desc: '',
      args: [],
    );
  }

  /// `Passport No`
  String get passportNo {
    return Intl.message('Passport No', name: 'passportNo', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Place of Birth`
  String get placeOfBirth {
    return Intl.message(
      'Place of Birth',
      name: 'placeOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Country of Birth`
  String get countryOfBirth {
    return Intl.message(
      'Country of Birth',
      name: 'countryOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Attendance`
  String get attendanceTitle {
    return Intl.message(
      'Attendance',
      name: 'attendanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage your attendance`
  String get attendanceDescription {
    return Intl.message(
      'Manage your attendance',
      name: 'attendanceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tap to view`
  String get attendenceClickToView {
    return Intl.message(
      'Tap to view',
      name: 'attendenceClickToView',
      desc: '',
      args: [],
    );
  }

  /// `Click to check in`
  String get clickToCheckIn {
    return Intl.message(
      'Click to check in',
      name: 'clickToCheckIn',
      desc: '',
      args: [],
    );
  }

  /// `Click to check out`
  String get clickToCheckOut {
    return Intl.message(
      'Click to check out',
      name: 'clickToCheckOut',
      desc: '',
      args: [],
    );
  }

  /// `Check In`
  String get checkIn {
    return Intl.message('Check In', name: 'checkIn', desc: '', args: []);
  }

  /// `Check Out`
  String get checkOut {
    return Intl.message('Check Out', name: 'checkOut', desc: '', args: []);
  }

  /// `Check in successful!`
  String get checkInSuccessful {
    return Intl.message(
      'Check in successful!',
      name: 'checkInSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Check out successful!`
  String get checkOutSuccessful {
    return Intl.message(
      'Check out successful!',
      name: 'checkOutSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Failed to check in`
  String get failedToCheckIn {
    return Intl.message(
      'Failed to check in',
      name: 'failedToCheckIn',
      desc: '',
      args: [],
    );
  }

  /// `Failed to check out`
  String get failedToCheckOut {
    return Intl.message(
      'Failed to check out',
      name: 'failedToCheckOut',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Error Loading Attendance`
  String get errorLoadingAttendance {
    return Intl.message(
      'Error Loading Attendance',
      name: 'errorLoadingAttendance',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later`
  String get pleaseTryAgainLater {
    return Intl.message(
      'Please try again later',
      name: 'pleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Loading Attendance...`
  String get loadingAttendance {
    return Intl.message(
      'Loading Attendance...',
      name: 'loadingAttendance',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get days {
    return Intl.message('days', name: 'days', desc: '', args: []);
  }

  /// `h`
  String get hoursAbbreviation {
    return Intl.message('h', name: 'hoursAbbreviation', desc: '', args: []);
  }

  /// `Time Off`
  String get timeOffTitle {
    return Intl.message('Time Off', name: 'timeOffTitle', desc: '', args: []);
  }

  /// `Manage your time off`
  String get timeOffDescription {
    return Intl.message(
      'Manage your time off',
      name: 'timeOffDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tap to view`
  String get timeOffClickToView {
    return Intl.message(
      'Tap to view',
      name: 'timeOffClickToView',
      desc: '',
      args: [],
    );
  }

  /// `Request Time Off`
  String get requestTimeOff {
    return Intl.message(
      'Request Time Off',
      name: 'requestTimeOff',
      desc: '',
      args: [],
    );
  }

  /// `You currently don't have any time off records`
  String get noTimeOffRecords {
    return Intl.message(
      'You currently don\'t have any time off records',
      name: 'noTimeOffRecords',
      desc: '',
      args: [],
    );
  }

  /// `Loading Time Offs`
  String get loadingTimeoff {
    return Intl.message(
      'Loading Time Offs',
      name: 'loadingTimeoff',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get approved {
    return Intl.message('Approved', name: 'approved', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Refused`
  String get refused {
    return Intl.message('Refused', name: 'refused', desc: '', args: []);
  }

  /// `Submitted`
  String get submitted {
    return Intl.message('Submitted', name: 'submitted', desc: '', args: []);
  }

  /// `Rejected`
  String get rejected {
    return Intl.message('Rejected', name: 'rejected', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Failed to load time off`
  String get failedToLoadTimeOff {
    return Intl.message(
      'Failed to load time off',
      name: 'failedToLoadTimeOff',
      desc: '',
      args: [],
    );
  }

  /// `Available Hours`
  String get availableHours {
    return Intl.message(
      'Available Hours',
      name: 'availableHours',
      desc: '',
      args: [],
    );
  }

  /// `Requested Hours`
  String get requestedHours {
    return Intl.message(
      'Requested Hours',
      name: 'requestedHours',
      desc: '',
      args: [],
    );
  }

  /// `New Time Off Request`
  String get newTimeOffReq {
    return Intl.message(
      'New Time Off Request',
      name: 'newTimeOffReq',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `from`
  String get from {
    return Intl.message('from', name: 'from', desc: '', args: []);
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Enter Description`
  String get enterDescription {
    return Intl.message(
      'Enter Description',
      name: 'enterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Payslips`
  String get payslipsTitle {
    return Intl.message('Payslips', name: 'payslipsTitle', desc: '', args: []);
  }

  /// `Manage your payslips`
  String get payslipsDescription {
    return Intl.message(
      'Manage your payslips',
      name: 'payslipsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tap to view`
  String get payslipsClickToView {
    return Intl.message(
      'Tap to view',
      name: 'payslipsClickToView',
      desc: '',
      args: [],
    );
  }

  /// `View Payslip`
  String get viewPayslip {
    return Intl.message(
      'View Payslip',
      name: 'viewPayslip',
      desc: '',
      args: [],
    );
  }

  /// `You currently don't have any Payslips!`
  String get noPayslipsRecords {
    return Intl.message(
      'You currently don\'t have any Payslips!',
      name: 'noPayslipsRecords',
      desc: '',
      args: [],
    );
  }

  /// `Ref`
  String get ref {
    return Intl.message('Ref', name: 'ref', desc: '', args: []);
  }

  /// `Error Loading Payslips`
  String get errorLoadingPayslips {
    return Intl.message(
      'Error Loading Payslips',
      name: 'errorLoadingPayslips',
      desc: '',
      args: [],
    );
  }

  /// `Loading Payslips`
  String get loadingPayslips {
    return Intl.message(
      'Loading Payslips',
      name: 'loadingPayslips',
      desc: '',
      args: [],
    );
  }

  /// `Payslip Details`
  String get payslipDetails {
    return Intl.message(
      'Payslip Details',
      name: 'payslipDetails',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employeeSection {
    return Intl.message(
      'Employee',
      name: 'employeeSection',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Marital`
  String get marital {
    return Intl.message('Marital', name: 'marital', desc: '', args: []);
  }

  /// `Job ID`
  String get jobId {
    return Intl.message('Job ID', name: 'jobId', desc: '', args: []);
  }

  /// `Manager`
  String get manager {
    return Intl.message('Manager', name: 'manager', desc: '', args: []);
  }

  /// `Identification`
  String get identification {
    return Intl.message(
      'Identification',
      name: 'identification',
      desc: '',
      args: [],
    );
  }

  /// `Work Email`
  String get workEmail {
    return Intl.message('Work Email', name: 'workEmail', desc: '', args: []);
  }

  /// `Payslip`
  String get payslipSection {
    return Intl.message('Payslip', name: 'payslipSection', desc: '', args: []);
  }

  /// `Basic Salary`
  String get basicSalary {
    return Intl.message(
      'Basic Salary',
      name: 'basicSalary',
      desc: '',
      args: [],
    );
  }

  /// `Texable Salary`
  String get texableSalary {
    return Intl.message(
      'Texable Salary',
      name: 'texableSalary',
      desc: '',
      args: [],
    );
  }

  /// `Net Salary`
  String get netSalary {
    return Intl.message('Net Salary', name: 'netSalary', desc: '', args: []);
  }

  /// `Attendance`
  String get attendance {
    return Intl.message('Attendance', name: 'attendance', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `Expenses`
  String get expensesTitle {
    return Intl.message('Expenses', name: 'expensesTitle', desc: '', args: []);
  }

  /// `Tap to check expenses`
  String get expensesDescription {
    return Intl.message(
      'Tap to check expenses',
      name: 'expensesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Tap to view`
  String get expensesClickToView {
    return Intl.message(
      'Tap to view',
      name: 'expensesClickToView',
      desc: '',
      args: [],
    );
  }

  /// `Request Expense`
  String get requestExpense {
    return Intl.message(
      'Request Expense',
      name: 'requestExpense',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load expenses`
  String get failedToLoadExpenses {
    return Intl.message(
      'Failed to load expenses',
      name: 'failedToLoadExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Loading Expenses`
  String get loadingExpenses {
    return Intl.message(
      'Loading Expenses',
      name: 'loadingExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `You currently don't have any Expenses!`
  String get noExpenses {
    return Intl.message(
      'You currently don\'t have any Expenses!',
      name: 'noExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Uncategorized`
  String get uncategorized {
    return Intl.message(
      'Uncategorized',
      name: 'uncategorized',
      desc: '',
      args: [],
    );
  }

  /// `New Expense Request`
  String get newExpenseRequest {
    return Intl.message(
      'New Expense Request',
      name: 'newExpenseRequest',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Please select a category`
  String get categoryRequired {
    return Intl.message(
      'Please select a category',
      name: 'categoryRequired',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Amount is required`
  String get amountRequired {
    return Intl.message(
      'Amount is required',
      name: 'amountRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid amount`
  String get amountInvalid {
    return Intl.message(
      'Enter a valid amount',
      name: 'amountInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Please select a currency`
  String get currencyRequired {
    return Intl.message(
      'Please select a currency',
      name: 'currencyRequired',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Description is required`
  String get descriptionRequired {
    return Intl.message(
      'Description is required',
      name: 'descriptionRequired',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
