import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

DateTime nextRenewalDate(SubscriptionRenewalStruct renewal) {
  // TODO: test this function thoroughly :')

  final today = DateUtils.dateOnly(DateTime.now());
  DateTime nextDate;

  switch (renewal.type) {
    case RenewalType.day_of_month:
      final payday = renewal.startDate!.day;
      nextDate = today.copyWith(day: payday);
      if (nextDate.isBefore(today)) {
        nextDate =
            DateUtils.addMonthsToMonthDate(today, 1).copyWith(day: payday);
      }
    case RenewalType.day_of_year:
      return renewal.startDate!;
    case RenewalType.periodic_days:
      final daysSince = today.difference(renewal.startDate!).inDays;
      final toAdd = daysSince % renewal.days;
      return today.add(Duration(days: toAdd));
  }
  return today; // unreachable
}

RenewalType? formChoiceToRenewalType(String choice) {
  switch (choice) {
    case 'Monthly':
      return RenewalType.day_of_month;
    case 'Weekly':
      return RenewalType.periodic_days;
    case 'Yearly':
      return RenewalType.day_of_year;
  }
  return null;
}

DateTime? parseDateWithFormat(
  String format,
  String dateStr,
) {
  try {
    return (new DateFormat(format)).parse(dateStr);
  } on FormatException {
    return null;
  }
}

double? currencyConverter(
  double? valueUSD,
  CurrencyType? currencyType,
) {
  switch (currencyType) {
    case CurrencyType.USD:
      return valueUSD;
    case CurrencyType.EUR:
      return valueUSD! * 1.22;
    case CurrencyType.RUB:
      return valueUSD! * 74.25;
    default:
      throw ArgumentError('currency not valid');
  }
}

DateTime? newRenewalDate(
  RenewalType? renewal,
  SubscriptionsRecord subscription,
) {
  DateTime currentDate = DateTime.now();
  DateTime? date = subscription.date;

  if (date == null) {
    return null;
  }

  if (date.isBefore(currentDate)) {
    switch (renewal) {
      case RenewalType.day_of_month:
        return currentDate.add(Duration(days: 30));
      case RenewalType.day_of_year:
        return DateTime(
            currentDate.year + 1, currentDate.month, currentDate.day);
      case RenewalType.periodic_days:
        return currentDate.add(Duration(days: 7));
      default:
        return currentDate;
    }
  } else {
    return date;
  }
}

DateTime startOfMonth(DateTime? date) {
  date ??= DateTime.now();
  return DateTime(date.year, date.month, 1);
}

DocumentReference? getMainBudgetRef(DocumentReference user) {
  return user.collection('user_budgets').doc('main');
}

double getMonthlyExpenses(List<SubscriptionsRecord> subscriptions) {
  return subscriptions.map((sub) {
    switch (sub.renewal!) {
      case RenewalType.periodic_days:
        return sub.amount * 4;
      case RenewalType.day_of_month:
        return sub.amount;
      case RenewalType.day_of_year:
        return sub.amount / 12;
    }
  }).fold(0, (v, a) => v + a);
}

List<MonthlyReportEntryStruct>? getMonthlyReport(
  List<SubscriptionsRecord> subscriptions,
  List<String> categoryFullNames,
) {
  final map = Map<SubscriptionCategory, double>();
  for (final sub in subscriptions) {
    final cat = sub.category ?? SubscriptionCategory.Other;
    final multiplierMap = {
      RenewalType.day_of_month: 1,
      RenewalType.day_of_year: 1 / 12,
      RenewalType.periodic_days: 4,
    };
    final multiplier = multiplierMap[sub.renewal] ?? 1;
    map[cat] = map.putIfAbsent(cat, () => 0.0) + sub.amount * multiplier;
  }
  final report = List<MonthlyReportEntryStruct>.from(map.entries.map((e) =>
      MonthlyReportEntryStruct(
          categoryName: categoryFullNames[e.key.index], amount: e.value)));
  report.sort((a, b) => b.amount.compareTo(a.amount));
  return report;
}

SubscriptionCategory categoryFromString(String categoryStr) {
  // FIXME: This is a temporary "bad" solution. It would be much more sensible to have
  // a dropdown with predefined values.  However, last time I tried adding it, FlutterFlow had
  // some wild un-debuggable error, giving no logs or diagnostics, but refusing to generate
  // any code and crashing when building or testing or exporting the project.
  // So I gave up  :shrug:
  // (-Max)

  return SubscriptionCategory.values.firstWhere(
    (cat) => cat.name == categoryStr,
    orElse: () => SubscriptionCategory.Other,
  );
}
