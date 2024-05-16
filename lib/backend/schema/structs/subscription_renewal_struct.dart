// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubscriptionRenewalStruct extends FFFirebaseStruct {
  SubscriptionRenewalStruct({
    RenewalType? type,
    int? days,
    DateTime? startDate,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _type = type,
        _days = days,
        _startDate = startDate,
        super(firestoreUtilData);

  // "type" field.
  RenewalType? _type;
  RenewalType get type => _type ?? RenewalType.periodic_days;
  set type(RenewalType? val) => _type = val;
  bool hasType() => _type != null;

  // "days" field.
  int? _days;
  int get days => _days ?? 30;
  set days(int? val) => _days = val;
  void incrementDays(int amount) => _days = days + amount;
  bool hasDays() => _days != null;

  // "start_date" field.
  DateTime? _startDate;
  DateTime? get startDate => _startDate;
  set startDate(DateTime? val) => _startDate = val;
  bool hasStartDate() => _startDate != null;

  static SubscriptionRenewalStruct fromMap(Map<String, dynamic> data) =>
      SubscriptionRenewalStruct(
        type: deserializeEnum<RenewalType>(data['type']),
        days: castToType<int>(data['days']),
        startDate: data['start_date'] as DateTime?,
      );

  static SubscriptionRenewalStruct? maybeFromMap(dynamic data) => data is Map
      ? SubscriptionRenewalStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type?.serialize(),
        'days': _days,
        'start_date': _startDate,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.Enum,
        ),
        'days': serializeParam(
          _days,
          ParamType.int,
        ),
        'start_date': serializeParam(
          _startDate,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static SubscriptionRenewalStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SubscriptionRenewalStruct(
        type: deserializeParam<RenewalType>(
          data['type'],
          ParamType.Enum,
          false,
        ),
        days: deserializeParam(
          data['days'],
          ParamType.int,
          false,
        ),
        startDate: deserializeParam(
          data['start_date'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'SubscriptionRenewalStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SubscriptionRenewalStruct &&
        type == other.type &&
        days == other.days &&
        startDate == other.startDate;
  }

  @override
  int get hashCode => const ListEquality().hash([type, days, startDate]);
}

SubscriptionRenewalStruct createSubscriptionRenewalStruct({
  RenewalType? type,
  int? days,
  DateTime? startDate,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SubscriptionRenewalStruct(
      type: type,
      days: days,
      startDate: startDate,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SubscriptionRenewalStruct? updateSubscriptionRenewalStruct(
  SubscriptionRenewalStruct? subscriptionRenewal, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    subscriptionRenewal
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSubscriptionRenewalStructData(
  Map<String, dynamic> firestoreData,
  SubscriptionRenewalStruct? subscriptionRenewal,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (subscriptionRenewal == null) {
    return;
  }
  if (subscriptionRenewal.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && subscriptionRenewal.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final subscriptionRenewalData =
      getSubscriptionRenewalFirestoreData(subscriptionRenewal, forFieldValue);
  final nestedData =
      subscriptionRenewalData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      subscriptionRenewal.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSubscriptionRenewalFirestoreData(
  SubscriptionRenewalStruct? subscriptionRenewal, [
  bool forFieldValue = false,
]) {
  if (subscriptionRenewal == null) {
    return {};
  }
  final firestoreData = mapToFirestore(subscriptionRenewal.toMap());

  // Add any Firestore field values
  subscriptionRenewal.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSubscriptionRenewalListFirestoreData(
  List<SubscriptionRenewalStruct>? subscriptionRenewals,
) =>
    subscriptionRenewals
        ?.map((e) => getSubscriptionRenewalFirestoreData(e, true))
        .toList() ??
    [];
