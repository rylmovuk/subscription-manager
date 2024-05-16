import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BudgetsRecord extends FirestoreRecord {
  BudgetsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "budgetDescription" field.
  String? _budgetDescription;
  String get budgetDescription => _budgetDescription ?? '';
  bool hasBudgetDescription() => _budgetDescription != null;

  // "budgetStartDate" field.
  DateTime? _budgetStartDate;
  DateTime? get budgetStartDate => _budgetStartDate;
  bool hasBudgetStartDate() => _budgetStartDate != null;

  // "budgetTime" field.
  String? _budgetTime;
  String get budgetTime => _budgetTime ?? '';
  bool hasBudgetTime() => _budgetTime != null;

  // "budgetName" field.
  String? _budgetName;
  String get budgetName => _budgetName ?? '';
  bool hasBudgetName() => _budgetName != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "amount" field.
  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  void _initializeFields() {
    _budgetDescription = snapshotData['budgetDescription'] as String?;
    _budgetStartDate = snapshotData['budgetStartDate'] as DateTime?;
    _budgetTime = snapshotData['budgetTime'] as String?;
    _budgetName = snapshotData['budgetName'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _amount = castToType<double>(snapshotData['amount']);
    _createdTime = snapshotData['created_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('budgets');

  static Stream<BudgetsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BudgetsRecord.fromSnapshot(s));

  static Future<BudgetsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BudgetsRecord.fromSnapshot(s));

  static BudgetsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BudgetsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BudgetsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BudgetsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BudgetsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BudgetsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBudgetsRecordData({
  String? budgetDescription,
  DateTime? budgetStartDate,
  String? budgetTime,
  String? budgetName,
  DocumentReference? user,
  double? amount,
  DateTime? createdTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'budgetDescription': budgetDescription,
      'budgetStartDate': budgetStartDate,
      'budgetTime': budgetTime,
      'budgetName': budgetName,
      'user': user,
      'amount': amount,
      'created_time': createdTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class BudgetsRecordDocumentEquality implements Equality<BudgetsRecord> {
  const BudgetsRecordDocumentEquality();

  @override
  bool equals(BudgetsRecord? e1, BudgetsRecord? e2) {
    return e1?.budgetDescription == e2?.budgetDescription &&
        e1?.budgetStartDate == e2?.budgetStartDate &&
        e1?.budgetTime == e2?.budgetTime &&
        e1?.budgetName == e2?.budgetName &&
        e1?.user == e2?.user &&
        e1?.amount == e2?.amount &&
        e1?.createdTime == e2?.createdTime;
  }

  @override
  int hash(BudgetsRecord? e) => const ListEquality().hash([
        e?.budgetDescription,
        e?.budgetStartDate,
        e?.budgetTime,
        e?.budgetName,
        e?.user,
        e?.amount,
        e?.createdTime
      ]);

  @override
  bool isValidKey(Object? o) => o is BudgetsRecord;
}
