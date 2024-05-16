import 'package:collection/collection.dart';

enum RenewalType {
  periodic_days,
  day_of_month,
  day_of_year,
}

enum CurrencyType {
  USD,
  EUR,
  RUB,
}

enum SubscriptionCategory {
  Entertainment,
  HealthFitness,
  CloudServices,
  Culture,
  MobilityTransportation,
  Utilities,
  Other,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (RenewalType):
      return RenewalType.values.deserialize(value) as T?;
    case (CurrencyType):
      return CurrencyType.values.deserialize(value) as T?;
    case (SubscriptionCategory):
      return SubscriptionCategory.values.deserialize(value) as T?;
    default:
      return null;
  }
}
