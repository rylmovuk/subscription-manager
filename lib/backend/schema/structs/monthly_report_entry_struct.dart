// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MonthlyReportEntryStruct extends FFFirebaseStruct {
  MonthlyReportEntryStruct({
    String? categoryName,
    double? amount,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _categoryName = categoryName,
        _amount = amount,
        super(firestoreUtilData);

  // "categoryName" field.
  String? _categoryName;
  String get categoryName => _categoryName ?? '';
  set categoryName(String? val) => _categoryName = val;
  bool hasCategoryName() => _categoryName != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  set amount(double? val) => _amount = val;
  void incrementAmount(double amount) => _amount = amount + amount;
  bool hasAmount() => _amount != null;

  static MonthlyReportEntryStruct fromMap(Map<String, dynamic> data) =>
      MonthlyReportEntryStruct(
        categoryName: data['categoryName'] as String?,
        amount: castToType<double>(data['amount']),
      );

  static MonthlyReportEntryStruct? maybeFromMap(dynamic data) => data is Map
      ? MonthlyReportEntryStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'categoryName': _categoryName,
        'amount': _amount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'categoryName': serializeParam(
          _categoryName,
          ParamType.String,
        ),
        'amount': serializeParam(
          _amount,
          ParamType.double,
        ),
      }.withoutNulls;

  static MonthlyReportEntryStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      MonthlyReportEntryStruct(
        categoryName: deserializeParam(
          data['categoryName'],
          ParamType.String,
          false,
        ),
        amount: deserializeParam(
          data['amount'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'MonthlyReportEntryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MonthlyReportEntryStruct &&
        categoryName == other.categoryName &&
        amount == other.amount;
  }

  @override
  int get hashCode => const ListEquality().hash([categoryName, amount]);
}

MonthlyReportEntryStruct createMonthlyReportEntryStruct({
  String? categoryName,
  double? amount,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    MonthlyReportEntryStruct(
      categoryName: categoryName,
      amount: amount,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

MonthlyReportEntryStruct? updateMonthlyReportEntryStruct(
  MonthlyReportEntryStruct? monthlyReportEntry, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    monthlyReportEntry
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addMonthlyReportEntryStructData(
  Map<String, dynamic> firestoreData,
  MonthlyReportEntryStruct? monthlyReportEntry,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (monthlyReportEntry == null) {
    return;
  }
  if (monthlyReportEntry.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && monthlyReportEntry.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final monthlyReportEntryData =
      getMonthlyReportEntryFirestoreData(monthlyReportEntry, forFieldValue);
  final nestedData =
      monthlyReportEntryData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      monthlyReportEntry.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getMonthlyReportEntryFirestoreData(
  MonthlyReportEntryStruct? monthlyReportEntry, [
  bool forFieldValue = false,
]) {
  if (monthlyReportEntry == null) {
    return {};
  }
  final firestoreData = mapToFirestore(monthlyReportEntry.toMap());

  // Add any Firestore field values
  monthlyReportEntry.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getMonthlyReportEntryListFirestoreData(
  List<MonthlyReportEntryStruct>? monthlyReportEntrys,
) =>
    monthlyReportEntrys
        ?.map((e) => getMonthlyReportEntryFirestoreData(e, true))
        .toList() ??
    [];
